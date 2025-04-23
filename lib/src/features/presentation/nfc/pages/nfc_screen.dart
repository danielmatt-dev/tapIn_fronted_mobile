import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tapin/src/features/domain/entites/alumno_request.dart';
import 'package:tapin/src/features/presentation/nfc/cubit/nfc_cubit.dart';
import 'package:tapin/src/shared/utils/injections.dart';

class NFCScreen extends StatefulWidget {
  const NFCScreen({super.key});

  @override
  State<NFCScreen> createState() => _NFCScreenState();
}

class _NFCScreenState extends State<NFCScreen> {

  final nfcCubit = sl<NfcCubit>();

  @override
  void initState() {
    _escanearNFC();
    super.initState();
  }

  void _escanearNFC() {
    nfcCubit.escanearNfcEvent(TipoAcceso.Entrada);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Leer NFC')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<NfcCubit, NfcState>(
                builder: (context, state) {

                  if (state is NfcLoading) {
                    return const CircularProgressIndicator();
                  }

                  if (state is NfcCheckSuccess) {
                    return const Text('Escaneo exitoso');
                  }

                  if (state is NfcUnavailable) {
                    return const Text('El dispositivo no tiene NFC');
                  }

                  if (state is NfcNoData) {
                    return const Text('El tag no tiene datos');
                  }

                  if (state is NfcCheckError) {
                    return const Text('Error al escanear NFC');
                  }

                  return const SizedBox.shrink();
                }),
            ElevatedButton(
              onPressed: _escanearNFC,
              child: const Text('Leer tarjeta NFC'),
            ),
          ],
        ),
      ),
    );
  }
}