import 'package:flutter/material.dart';
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
    final controller = TextEditingController();
    final appLoc = AppLocalizations.of(context)!;
    final colorSchema = Theme.of(context).colorScheme;

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
                controller: controller,
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
                  onPressed: () {
                    final text = controller.text.trim();
                    Navigator.of(context).pop();

                    if (text.isEmpty) {
                      // Alerta de alumno no encontrado
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
                    } else {
                      // Lanza el evento de escaneo con el tipo de acceso
                      nfcCubit.escanearNfcEvent(tipoAcceso);
                    }
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
