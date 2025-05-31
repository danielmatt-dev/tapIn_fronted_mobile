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

      if (account == null) {
        return null;
      }

      String role = 'administrativo';

      // robertorooch2004@gmail.com
      if (account.email ==  'danielgonzales3005@gmail.com') {
        role = 'directivo';
      }

      sl<DataSourceLocal>().setRole(role);
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
