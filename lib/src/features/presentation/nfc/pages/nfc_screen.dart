import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulsator/pulsator.dart';
import 'package:tapin/src/core/theme/colors.dart';
import 'package:tapin/src/features/domain/entites/alumno_request.dart';
import 'package:tapin/src/features/presentation/nfc/cubit/nfc_cubit.dart';
import 'package:tapin/src/shared/utils/injections.dart';

class NFCScreen extends StatefulWidget {

  final TipoAcceso tipoAcceso;

  const NFCScreen({super.key, required this.tipoAcceso});

  @override
  State<NFCScreen> createState() => _NFCScreenState();
}

class _NFCScreenState extends State<NFCScreen> {

  final nfcCubit = sl<NfcCubit>();
  Color pulseColor = mapColor['Initial'];

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

    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Text(widget.tipoAcceso.name.toUpperCase())),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<NfcCubit, NfcState>(
                builder: (context, state) {

                  if (state is NfcCheckSuccess) {
                    pulseColor = mapColor['Success'];
                  }

                  if (state is NfcUnavailable || state is NfcNoData || state is NfcCheckError) {
                    pulseColor = mapColor['Error'];
                  }

                  return Column(
                    children: [
                      PulseIcon(
                        icon: Icons.phone_android_rounded,
                        pulseColor: pulseColor,
                        iconSize: 60,
                        innerSize: 100,
                        pulseSize: width,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: _buildWidget(state),
                      )
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }

  Widget _buildWidget(NfcState state) {

    if (state is NfcLoading) {
      return Column(
        children: [
          const Text('Acerque el dispositivo',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          Text('Coloque su dispositivo cerca del lector NFC y manténgalo estable hasta que se complete el escaneo.', textAlign: TextAlign.center,),
          SizedBox(height: 14,),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF23436E),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Cancelar', style: TextStyle(fontWeight: FontWeight.bold),),
          )
        ],
      );
    }

    if (state is NfcCheckSuccess) {
      return Column(
        children: [
          const Icon(Icons.circle, size:150,),
          Text(
            state.message,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          Text('Asistencia Registrada'),
          SizedBox(height: 10,),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF23436E),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Continuar', style: TextStyle(fontWeight: FontWeight.bold),),
          )
        ],
      );
    }

    return Column(
      children: [
        const Icon(Icons.circle, size:150,),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            state.message,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 10,),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF23436E),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text('Ingresar manualmente', style: TextStyle(fontWeight: FontWeight.bold),),
        )
      ],
    );
  }

}