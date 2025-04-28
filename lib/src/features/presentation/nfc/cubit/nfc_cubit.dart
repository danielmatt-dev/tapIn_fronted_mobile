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
                emit(const NfcUnavailable('NFC no encontrado o no habilitado'));
                return;
              }

              if (exception is NfcNoDataException) {
                emit(const NfcNoData('No hay datos en el NFC'));
                return;
              }

              emit(const NfcCheckError('Error en el escaneo'));
              },
            (data) {
              emit(NfcCheckSuccess(data, 'Escaneo exitoso'));
            });
  }

}