import 'package:google_sign_in/google_sign_in.dart';

/**
 * Class to handle Google Login
 */
class GoogleLogin {
  static GoogleSignInAccount? account;
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

  static Future<void> handleSignIn() async {
    try {
      account = await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
    return null;
  }

  static Future<Map<String, String>> getAuthHeaders() {
    if(account != null) {
      return account!.authHeaders;
    }
    return Future.value({});
  }
}