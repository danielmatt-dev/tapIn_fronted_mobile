import 'package:flutter/material.dart';

class ProfileDialog {
  /// Muestra la carta de perfil con [email], la foto de perfil opcional [photoUrl]
  /// y llama a [onLogout] al cerrar sesión.
  static void show(
      BuildContext context, {
        required String email,
        String? photoUrl,
        required VoidCallback onLogout,
      }) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 40),
        child: Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Si hay photoUrl, la muestra; si no, usa un icono
                if (photoUrl != null && photoUrl.isNotEmpty) ...[
                  CircleAvatar(
                    radius: 32,
                    backgroundImage: NetworkImage(photoUrl),
                  ),
                ] else ...[
                  Icon(
                    Icons.account_circle,
                    size: 64,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
                const SizedBox(height: 12),
                const Text("Correo electrónico:"),
                Text(email, style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // cierra el diálogo
                    onLogout();
                  },
                  child: const Text('Cerrar sesión'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
