import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:tapin/src/features/domain/use_cases/escanear_nfc.dart';
import 'package:tapin/src/features/domain/entites/alumno_request.dart';
import 'package:tapin/src/shared/exceptions/exceptions.dart';
part 'nfc_state.dart';

class NfcCubit extends Cubit<NfcState> {

  final EscanearNFC escanearNFC;

  static const _scanTimeout = Duration(seconds: 30);
  Timer? _timeoutTimer;
  bool _isPaused = false;

  NfcCubit({
    required this.escanearNFC
  }) : super(const NfcInitial());

  Future<void> escanearNfcEvent(TipoAcceso tipoAcceso) async {
    if (_isPaused) return;

    emit(const NfcLoading());

    _timeoutTimer?.cancel();
    _timeoutTimer = Timer(_scanTimeout, () {
      if (_isPaused) return;
      NfcManager.instance.stopSession();
      emit(const NfcTimeout());
    });

    final result = await escanearNFC.call(tipoAcceso);

    _timeoutTimer?.cancel();

    if (_isPaused) return;

    result.fold(
          (exception) {
        if (exception is NFCUnavailableException) {
          emit(const NfcUnavailable());
          return;
        }
        if (exception is NfcNoDataException) {
          emit(const NfcNoData());
          return;
        }
        if (exception is NFCTimeoutException) {
          emit(const NfcTimeout());
          return;
        }
        emit(const NfcCheckError());
      },
      (data) {
        final id = data[0];
        final email = data[1];
        final name = data[2];
        emit(NfcCheckSuccess(id: id, email: email, name: name));
      });
  }

  void pauseScanning() {
    _isPaused = true;
    _timeoutTimer?.cancel();
    NfcManager.instance.stopSession();
  }

  void resumeScanning(TipoAcceso tipoAcceso) {
    _isPaused = false;
    escanearNfcEvent(tipoAcceso);
  }

  @override
  Future<void> close() {
    _timeoutTimer?.cancel();
    return super.close();
  }
}
