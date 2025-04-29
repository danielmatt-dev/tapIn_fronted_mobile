import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulsator/pulsator.dart';
import 'package:tapin/src/core/styles/button_custom.dart';
import 'package:tapin/src/core/styles/text_custom_style.dart';
import 'package:tapin/src/core/theme/colors.dart';
import 'package:tapin/src/features/domain/entites/alumno_request.dart';
import 'package:tapin/src/features/presentation/nfc/cubit/nfc_cubit.dart';
import 'package:tapin/src/shared/utils/injections.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      appBar: AppBar(title: Text(widget.tipoAcceso.name.toUpperCase()), centerTitle: true,),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              BlocBuilder<NfcCubit, NfcState>(
                  builder: (context, state) {

                    if (state is NfcLoading) {
                      pulseColor = mapColor['Initial'];
                    }

                    if (state is NfcCheckSuccess) {
                      pulseColor = mapColor['Success'];
                    }

                    if (state is NfcUnavailable || state is NfcNoData || state is NfcTimeout || state is NfcCheckError) {
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
                          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10),
                          child: _buildWidget(state, AppLocalizations.of(context)),
                        )
                      ],
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWidget(NfcState state, AppLocalizations? app) {

    if (state is NfcLoading) {
      return Column(
        children: [
          TextCustomStyle(
            text: app!.bringDeviceCloser,
            typeText: TypeText.title,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 18, right: 40, left: 40),
            child: TextCustomStyle(
              text: app.placeDeviceNearReader,
              textAlign: TextAlign.center,
            ),
          ),
          ButtonCustom(
            text: app.cancelButtonLabel,
            onPressed: () {},
          ),
        ],
      );
    }

    if (state is NfcCheckSuccess) {
      return Column(
        children: [
          const Icon(Icons.circle, size:150,),
          TextCustomStyle(
            text: app!.nfcCheckSuccessMessage,
            fontWeight: FontWeight.bold,
            fontSize: 16,),
          TextCustomStyle(text: app.attendanceRegistered),
          const SizedBox(height: 10,),
          TextCustomStyle(text: state.name),
          const SizedBox(height: 10,),
          ButtonCustom(
            text: app.continueButtonLabel,
            onPressed: () {
              nfcCubit.escanearNfcEvent(widget.tipoAcceso);
            },
          ),
        ],
      );
    }

    String messageError = app!.nfcCheckErrorMessage;

    if (state is NfcNoData) {
      messageError = app.nfcNoDataMessage;
    }

    if (state is NfcUnavailable) {
      messageError = app.nfcUnavailableMessage;
    }

    if (state is NfcTimeout) {
      messageError = app.nfcTimeoutMessage;
    }

    return Column(
      children: [
        const Icon(Icons.circle, size:150,),
        Padding(
          padding: const EdgeInsets.only(bottom: 18),
          child: TextCustomStyle(text: messageError, fontWeight: FontWeight.bold, fontSize: 16,)
        ),
        ButtonCustom(
          text: app.manualEntryButtonLabel,
          onPressed: () {},
        ),
        ButtonCustom(
          text: app.retryButtonLabel,
          onPressed: () {
            nfcCubit.escanearNfcEvent(widget.tipoAcceso);
          },
          topPadding: 10,
        ),
      ],
    );
  }

}