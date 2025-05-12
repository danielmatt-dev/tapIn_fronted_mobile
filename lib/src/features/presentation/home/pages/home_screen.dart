import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tapin/src/features/data/auth/google_auth_service.dart';
import 'package:tapin/src/features/domain/entites/alumno_request.dart';
import 'package:tapin/src/features/presentation/home/widgets/option_cart.dart';
import 'package:tapin/src/features/presentation/home/widgets/profile_dialog.dart';
import 'package:tapin/src/features/presentation/nfc/pages/nfc_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tapin/src/features/presentation/nfc/widgets/ingresar_asistencia_dialog.dart';
import 'package:tapin/src/shared/widgets/alert_cart.dart';

import '../../login/pages/login_screen.dart';

class HomeScreen extends StatefulWidget {
  final GoogleSignInAccount user;

  const HomeScreen({required this.user, super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _authService = GoogleAuthService();
  int _selectedIndex = 0;
  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  void _logout() async {
    await _authService.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appLocations = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.onPrimary,
      appBar: AppBar(
        backgroundColor: colorScheme.onPrimary,
        elevation: 0,
        title: null,
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle, color: colorScheme.primary, size: 40),
            onPressed: () {
              ProfileDialog.show(context, email: widget.user.email, onLogout: _logout);
            },
          ),
          const SizedBox(width: 12), // un poco de espacio al borde
        ],
      ),


      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 0.0, bottom: 16),
            child: Center(
              child: Image.asset(
                'assets/images/Escudo.png',
                height: 150,   // ajusta a tu gusto
                fit: BoxFit.contain,
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  OptionCard(
                    icon: Icons.login,
                    title: appLocations!.entranceTitleLabel,
                    subtitle:
                    appLocations.entranceSubtitleLabel,
                    onTap: () {
                      Navigator.push(context,
                        MaterialPageRoute(
                          builder: (_) => NFCScreen(tipoAcceso: TipoAcceso.Entrada,
                          user: widget.user,),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  OptionCard(
                    icon: Icons.logout,
                    title: appLocations.exitTitleLabel,
                    subtitle:
                    appLocations.exitSubtitleLabel,
                    onTap: () {
                      Navigator.push(context,
                        MaterialPageRoute(
                          builder: (_) => NFCScreen(tipoAcceso: TipoAcceso.Salida,
                          user: widget.user,),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomAppBar(
        color: colorScheme.primary,
        elevation: 16,
        child: SizedBox(
          height: 60,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  appLocations.tapInLabel,
                  style: TextStyle(
                    color: colorScheme.onPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  appLocations.tapInSubtitleLabel,
                  style: TextStyle(
                    color: colorScheme.onPrimary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}