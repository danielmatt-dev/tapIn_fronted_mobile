import 'package:flutter/material.dart';
import 'package:tapin/src/features/presentation/home/pages/home_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final blueHeight = size.height * 0.35;
    final appLocations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E3A8A),
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: Stack(
        children: [
          Container(color: const Color(0xFF1E3A8A)),

          Positioned(
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  appLocations!.loginSchoolLabel,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Image.asset(
                  'assets/images/Escudo.png',
                  height: 230,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),

          Positioned(
            top: blueHeight,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                   Text(
                    appLocations.loginMessageLabel,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 16,
                    color: Colors.grey),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (_) => const HomeScreen(),
                          ),
                        );
                      },
                      icon: Image.asset(
                        'assets/images/Google.png',
                        height: 24,
                        width: 24,
                      ),
                      label: Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          appLocations.loginButtonLabel,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.grey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
