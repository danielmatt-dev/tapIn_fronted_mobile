import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final blueHeight = size.height * 0.35;

    return Scaffold(
      body: Stack(
        children: [
          Container(color: const Color(0xFF1E3A8A)),

          Positioned(
            top: kToolbarHeight, // o el padding que prefieras
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  'Secundaria Instituto Patria',
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
                  const Text(
                    'Inicia sesión con tu cuenta institucional de Google',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 16,
                    color: Colors.grey),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        // lógica de Google Sign-In
                      },
                      icon: Image.asset(
                        'assets/images/Google.png',
                        height: 24,
                        width: 24,
                      ),
                      label: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'Iniciar sesión con Google',
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
