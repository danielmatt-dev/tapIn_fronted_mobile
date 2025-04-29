import 'dart:async';
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:tapin/src/features/domain/entites/alumno_request.dart';
import 'package:tapin/src/shared/exceptions/exceptions.dart';
import 'package:tapin/src/shared/utils/use_case.dart';

class EscanearNFC extends UseCase<List<String>, TipoAcceso> {

  @override
    Future<Either<Exception, List<String>>> call(TipoAcceso params) async {

    final isAvailable = await NfcManager.instance.isAvailable();
    if (!isAvailable) {
      return Left(NFCUnavailableException());
    }

    final completer = Completer<Either<Exception, List<String>>>();

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

            completer.complete(Right(decodedMessages));
            NfcManager.instance.stopSession();
          } catch (e) {
            completer.complete(Left(NFCException()));
            NfcManager.instance.stopSession();
          }
        });

    return completer.future.timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          NfcManager.instance.stopSession();
          return Left(NFCTimeoutException());
        });
  }

}