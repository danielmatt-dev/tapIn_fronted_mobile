import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tapin/src/features/domain/entites/alumno_request.dart';
import 'package:tapin/src/features/domain/use_cases/escanear_nfc.dart';
import 'package:tapin/src/shared/exceptions/exceptions.dart';

part 'nfc_state.dart';

// <>
class NfcCubit extends Cubit<NfcState> {

  final EscanearNFC escanearNFC;

  NfcCubit({
    required this.escanearNFC
  }): super(const NfcInitial());

  Future<void> escanearNfcEvent(TipoAcceso tipoAcceso) async {
    emit(const NfcLoading());

    final result = await escanearNFC.call(tipoAcceso);

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

}