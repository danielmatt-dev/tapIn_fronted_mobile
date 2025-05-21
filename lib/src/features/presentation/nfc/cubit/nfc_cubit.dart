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
  static const _inactivityDuration = Duration(seconds: 30);

  Timer? _scanTimer;
  Timer? _inactivityTimer;
  bool _isPaused = false;

  NfcCubit({ required this.escanearNFC }) : super(const NfcInitial());

  Future<void> escanearNfcEvent(TipoAcceso tipoAcceso) async {
    if (_isPaused) return;

    _cancelInactivityTimer();        // cancelar cualquier inactividad anterior
    _startScanTimer();               // timeout de escaneo
    emit(const NfcLoading());

    final result = await escanearNFC.call(tipoAcceso);

    _cancelScanTimer();

    if (_isPaused) return;

    result.fold(
      _handleException,
          (data) {
        final id = data[0], email = data[1], name = data[2];
        emit(NfcCheckSuccess(id: id, email: email, name: name));
      },
    );
  }

  void _startScanTimer() {
    _scanTimer?.cancel();
    _scanTimer = Timer(_scanTimeout, () {
      if (_isPaused) return;
      NfcManager.instance.stopSession();
      emit(const NfcTimeout());
    });
  }

  void _cancelScanTimer() {
    _scanTimer?.cancel();
    _scanTimer = null;
  }

  void _handleException(Exception exception) {
    if (exception is NFCUnavailableException) {
      emit(const NfcUnavailable());
    } else if (exception is NfcNoDataException) {
      emit(const NfcNoData());
    } else if (exception is NFCTimeoutException) {
      emit(const NfcTimeout());
    } else {
      emit(const NfcCheckError());
    }
    _startInactivityTimer();  // al emitir cualquier error, lanza el temporizador de inactividad
  }

  /// Arranca el temporizador de inactividad (30s) tras un error
  void _startInactivityTimer() {
    _inactivityTimer?.cancel();
    _inactivityTimer = Timer(_inactivityDuration, () {
      if (_isPaused) return;
      emit(const NfcInactivityTimeout());
    });
  }

  void _cancelInactivityTimer() {
    _inactivityTimer?.cancel();
    _inactivityTimer = null;
  }

  /// Pausa completamente el escaneo y todos los timers
  void pauseScanning() {
    _isPaused = true;
    _cancelScanTimer();
    _cancelInactivityTimer();
    NfcManager.instance.stopSession();
  }

  /// Reanuda el escaneo desde cero (resetea pausa e invoca escaneo)
  void resumeScanning(TipoAcceso tipoAcceso) {
    _isPaused = false;
    escanearNfcEvent(tipoAcceso);
  }

  /// Debe llamarse desde la UI ante cualquier interacción del usuario
  void userActivity() {
    _cancelInactivityTimer();  // cancela la navegación automática a Home
  }

  @override
  Future<void> close() {
    _cancelScanTimer();
    _cancelInactivityTimer();
    return super.close();
  }
}
