import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tapin/src/features/domain/use_cases/registrar_asistencia_alumno.dart';
import 'package:tapin/src/shared/exceptions/exceptions.dart';
import 'package:tapin/src/shared/utils/injections.dart';
import 'package:tapin/src/shared/widgets/alert_cart.dart';
import 'package:tapin/src/features/presentation/nfc/cubit/nfc_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../domain/entites/alumno_request.dart';

class IngresarAsistenciaDialog {
  static Future<void> show({
    required BuildContext context,
    required NfcCubit nfcCubit,
    required TipoAcceso tipoAcceso,
  }) {
    final emailController = TextEditingController();

    final appLoc = AppLocalizations.of(context)!;
    final colorSchema = Theme.of(context).colorScheme;

    final registrarAsistenciaAlumno = sl<RegistrarAsistenciaAlumno>();

    return showDialog(
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
              // Encabezado
              Row(
                children: [
                  Expanded(
                    child: Text(
                      appLoc.ingresarAsistenciaLabel,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
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

              // Campo de correo
              TextField(
                controller: emailController,
                onChanged: (String value) {
                  emailController.text = value;
                  print(emailController.text);
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: appLoc.correoInstitucionalLabel,
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: appLoc.ejemploCorreoLabel,
                ),
              ),
              const SizedBox(height: 24),

              // Botón Confirmar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {

                    if (emailController.text.isEmpty) {
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (_) => Dialog(
                          insetPadding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 48,
                          ),
                          child: AlertCart(
                            icon: Icons.warning_amber_rounded,
                            title: 'Alerta',
                            subtitle: 'El correo no debe estar vacío',
                            onTap: () {
                              Navigator.of(context).pop();
                              // Reiniciar escaneo
                              nfcCubit.escanearNfcEvent(tipoAcceso);
                            },
                          ),
                        ),
                      );
                    }

                    if (emailController.text == 'roberto@gmail.com') {
                      Navigator.of(context).pop();
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (_) => Dialog(
                          insetPadding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 48,
                          ),
                          child: AlertCart(
                            icon: Icons.warning_amber_rounded,
                            title: 'Alerta',
                            subtitle: 'El alumno se encuentra dado de baja',
                            onTap: () {
                              Navigator.of(context).pop();
                              // Reiniciar escaneo
                              nfcCubit.escanearNfcEvent(tipoAcceso);
                            },
                          ),
                        ),
                      );
                      return;
                    }

                    DateTime ahora = DateTime.now();
                    final fechaFormateada = DateFormat('yyyy-MM-dd').format(ahora);
                    final horaFormateada = DateFormat('HH:mm:ss').format(ahora);

                    final eitherAsistencia = await registrarAsistenciaAlumno.call(
                        AlumnoRequest(
                            fecha: fechaFormateada,
                            hora: horaFormateada,
                            tipoAcceso: tipoAcceso,
                            correo: emailController.text
                        )
                    );

                    Navigator.of(context).pop();
                    nfcCubit.escanearNfcEvent(tipoAcceso);

                    eitherAsistencia.fold(
                            (ex) {
                              if (ex is ResourceNotFoundException) {
                                showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (_) => Dialog(
                                    insetPadding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 48,
                                    ),
                                    child: AlertCart(
                                      icon: Icons.warning_amber_rounded,
                                      title: appLoc.alertaLabel,
                                      subtitle: appLoc.alumnoNotFoundLabel,
                                      onTap: () {
                                        Navigator.of(context).pop();
                                        // Reiniciar escaneo
                                        nfcCubit.escanearNfcEvent(tipoAcceso);
                                      },
                                    ),
                                  ),
                                );
                                return;
                              }

                              if (ex is BadRequestException) {
                                showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (_) => Dialog(
                                    insetPadding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 48,
                                    ),
                                    child: AlertCart(
                                      icon: Icons.warning_amber_rounded,
                                      title: appLoc.alertaLabel,
                                      subtitle: 'El correo no está asociado a un alumno',
                                      onTap: () {
                                        Navigator.of(context).pop();
                                        // Reiniciar escaneo
                                        nfcCubit.escanearNfcEvent(tipoAcceso);
                                      },
                                    ),
                                  ),
                                );
                                return;
                              }

                              showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (_) => Dialog(
                                  insetPadding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 48,
                                  ),
                                  child: AlertCart(
                                    icon: Icons.error,
                                    title: 'Error',
                                    subtitle: 'Por favor, intentalo más tarde',
                                    onTap: () {
                                      Navigator.of(context).pop();
                                      // Reiniciar escaneo
                                      nfcCubit.escanearNfcEvent(tipoAcceso);
                                    },
                                  ),
                                ),
                              );
                            },
                            (succes) {
                              showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (_) => Dialog(
                                  insetPadding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 48,
                                  ),
                                  child: AlertCart(
                                    icon: Icons.check_circle_outline,
                                    title: 'Éxito',
                                    subtitle: 'Asistencia registrada',
                                    onTap: () {
                                      Navigator.of(context).pop();
                                      // Reiniciar escaneo
                                      nfcCubit.escanearNfcEvent(tipoAcceso);
                                    },
                                  ),
                                ),
                              );
                            }
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorSchema.primary,
                    foregroundColor: colorSchema.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: const Size.fromHeight(48),
                  ),
                  child: Text(appLoc.confirmLabel),
                ),
              ),
              const SizedBox(height: 12),

              // Botón Cancelar
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: const Size.fromHeight(48),
                  ),
                  child: Text(appLoc.cancelButtonLabel),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
