import 'package:flutter/material.dart';
import 'package:tapin/src/features/domain/entites/alumno_request.dart';
import 'package:tapin/src/features/presentation/home/widgets/option_cart.dart';
import 'package:tapin/src/features/presentation/nfc/pages/nfc_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    const azul = Color(0xFF1E3A8A);
    final appLocations = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 0,
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 24, bottom: 16),
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
                          builder: (_) => const NFCScreen(tipoAcceso: TipoAcceso.Entrada),
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
                          builder: (_) => const NFCScreen(tipoAcceso: TipoAcceso.Salida),
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
        color: azul,
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
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  appLocations.tapInSubtitleLabel,
                  style: TextStyle(
                    color: Colors.white,
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