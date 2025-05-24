import 'package:google_sign_in/google_sign_in.dart';
import 'package:tapin/src/features/data/data_sources/local/datasource_local.dart';
import 'package:tapin/src/shared/utils/injections.dart';

class GoogleAuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );

  Future<GoogleSignInAccount?> signIn() async {
    try {
      final account = await _googleSignIn.signIn();
      final auth = await account?.authentication;

      final email = account?.email;
      final idToken = auth?.idToken;

      if (email == null || idToken == null) {
        return null;
      }

      final local = sl<DataSourceLocal>();

      if (email == '') {
        local.setRole('Administrativo');
      }

      if (email == '') {
        local.setRole('Directivo');
      }

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
