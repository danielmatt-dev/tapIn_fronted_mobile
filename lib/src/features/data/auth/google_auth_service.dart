import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    serverClientId: dotenv.get('SERVER_CLIENT_ID'),
    scopes: ['email', 'profile'],
  );

  Future<GoogleSignInAccount?> signIn() async {
    try {
      final account = await _googleSignIn.signIn();
      final auth = await account?.authentication;
      return account;
    } catch (e) {
      rethrow;
    }
  }

  Future<GoogleSignInAccount?> currentUser() async {
    return _googleSignIn.signInSilently();
  }

  Future<void> signOut() async {
    await _googleSignIn.disconnect();
  }
}
