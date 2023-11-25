import 'package:http/http.dart' as http;

class FirebaseAuthModel {
  final String url = "https://us-central1-pickar-app.cloudfunctions.net/createCustomToken";

  Future<String> createCustomToken(Map<String, dynamic> user) async {
    final customTokenResponse = await http.post(Uri.parse(url), body: user);

    return customTokenResponse.body;
  }
}