import 'package:google_sign_in/google_sign_in.dart';

/**
 * Class to handle Google Login
 */
class GoogleLogin {
  static const List<String> scopes = <String>[
    'https://www.google.com/calendar/feeds',
    'https://www.googleapis.com/auth/script.scriptapp',
    'https://www.googleapis.com/auth/userinfo.email',
    'https://www.googleapis.com/auth/drive.readonly'
  ];

  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    // Optional clientId
      clientId: '642352946638-eg7ipfcdajlh9vmrf1a6jq2n8nejsljr.apps.googleusercontent.com',
      scopes: scopes
  );

  static Future<GoogleSignInAccount?> handleSignIn() async {
    try {
      return await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
    return null;
  }

  static Future<Map<String, String>> getAccessToken(GoogleSignInAccount? account) async {
    if(account != null) {
      final auth = await account.authentication;
      return account.authHeaders;
    }
    return {};
  }
}