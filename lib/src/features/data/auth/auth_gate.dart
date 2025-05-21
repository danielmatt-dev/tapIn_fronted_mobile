import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../presentation/home/pages/home_screen.dart';
import '../../presentation/login/pages/login_screen.dart';
import 'google_auth_service.dart';

class AuthGate extends StatelessWidget {
  final _authService = GoogleAuthService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GoogleSignInAccount?>(
      future: _authService.currentUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // mientras chequea, muestra un loading
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasData && snapshot.data != null) {
          // usuario logeado: navega a Home
          return HomeScreen(user: snapshot.data!);
        }
        // no hay usuario: va a Login
        return LoginScreen();
      },
    );
  }
}
