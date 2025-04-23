import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

import 'package:dartz/dartz.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:tapin/src/features/domain/entites/alumno_request.dart';
import 'package:tapin/src/shared/exceptions/exceptions.dart';
import 'package:tapin/src/shared/utils/use_case.dart';

class EscanearNFC extends UseCase<AlumnoRequest, TipoAcceso> {

  @override
    Future<Either<Exception, AlumnoRequest>> call(TipoAcceso params) async {

    final isAvailable = await NfcManager.instance.isAvailable();
    if (!isAvailable) {
      return Left(NFCUnavailableException());
    }

    final completer = Completer<Either<Exception, AlumnoRequest>>();

    NfcManager.instance.startSession(

        onDiscovered: (NfcTag tag) async {

          try {

            final ndef = Ndef.from(tag);
            if (ndef == null || ndef.cachedMessage == null) {
              completer.complete(Left(NfcNoDataException()));
              NfcManager.instance.stopSession();
              return;
            }

            final records = ndef.cachedMessage!.records;
            final decodedMessages = records.map((record) {
              final payload = record.payload;
              return utf8.decode(payload.sublist(3));
            }).toList();

            final idNfc = decodedMessages[0];
            //final correo = decodedMessages[1];
            final mexico = tz.getLocation('America/Mexico_City');
            final fechaHoraMexico = tz.TZDateTime.now(mexico);
            final fecha = DateFormat('yyyy-MM-dd').format(fechaHoraMexico);
            final hora = DateFormat.Hms().format(fechaHoraMexico);

            final alumno = AlumnoRequest(
                idNfc: idNfc,
                fecha: fecha,
                hora: hora,
                tipoAcceso: params
            );

            completer.complete(Right(alumno));
            NfcManager.instance.stopSession();
          } catch (e) {
            completer.complete(Left(NFCException()));
            NfcManager.instance.stopSession();
          }
        });

    return completer.future;
  }

}