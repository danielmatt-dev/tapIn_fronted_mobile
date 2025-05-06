import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pulsator/pulsator.dart';
import 'package:tapin/src/core/styles/button_custom.dart';
import 'package:tapin/src/core/styles/text_custom_style.dart';
import 'package:tapin/src/core/theme/colors.dart';
import 'package:tapin/src/features/domain/entites/alumno_request.dart';
import 'package:tapin/src/features/presentation/nfc/cubit/nfc_cubit.dart';
import 'package:tapin/src/shared/utils/injections.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tapin/src/shared/widgets/alert_cart.dart';

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
    final colorSchema = Theme.of(context).colorScheme;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tipoAcceso.name.toUpperCase()),
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.normal,
          color: colorSchema.primary,
          fontSize: 24
        ),
      ),
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

  void showIngresarAsistenciaDialog(BuildContext context) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Ingresar Asistencia',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => Navigator.of(context).pop(),
                    child: const Padding(
                      padding: EdgeInsets.all(4),
                      child: Icon(Icons.close, size: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Campo de correo con controller
              TextField(
                controller: controller,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Correo electrónico Institucional',
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  hintText: 'you@edu.com',
                ),
              ),
              const SizedBox(height: 24),

              // Confirmar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final text = controller.text.trim();
                    if (text.isEmpty) {
                      Navigator.of(context).pop();

                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (_) => Dialog(
                          insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
                          child: AlertCart(
                              icon: Icons.warning_amber_rounded,
                              title: "Alerta",
                              subtitle: "Alumno no encontrado",
                              onTap: (){
                                Navigator.of(context).pop();
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => const NFCScreen(tipoAcceso: TipoAcceso.Entrada)),
                                );
                              }
                              ),
                        )
                      );
                      return;
                    } else {
                      Navigator.of(context).pop();
                      nfcCubit.escanearNfcEvent(widget.tipoAcceso);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF23456e),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    minimumSize: const Size.fromHeight(48),
                  ),
                  child: const Text('Confirmar'),
                ),
              ),
              const SizedBox(height: 12),

              // Cancelar
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    minimumSize: const Size.fromHeight(48),
                  ),
                  child: const Text('Cancelar'),
                ),
              ),
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
          SvgPicture.asset(
            'assets/images/icon_check_success.svg',
            width: 90,
            height: 90,
          ),
          SizedBox(height: 20),
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
        SvgPicture.asset(
          'assets/images/icon_check_reload.svg',
          width: 90,
          height: 90,
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(bottom: 18),
          child: TextCustomStyle(text: messageError, fontWeight: FontWeight.bold, fontSize: 16,)
        ),
        ButtonCustom(
          text: app.manualEntryButtonLabel,
          onPressed: () {
            showIngresarAsistenciaDialog(context);
          },
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