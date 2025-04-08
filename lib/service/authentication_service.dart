import 'package:pure_news/service/service.dart';

class AuthenticationService with ServiceMixin {
  Future<String> signIn({
    required String endpoint,
    required String password,
    required String username,
  }) async {
    var response = await post(
      '$endpoint/accounts/ClientLogin?output=json',
      body: {'Passwd': password, 'Email': username},
    );
    if (response.statusCode != 200) throw Exception(response.reasonPhrase);
    var parts = response.body.split('\n');
    for (var part in parts) {
      if (part.startsWith('Auth') == false) continue;
      return part.split('=')[1];
    }
    throw Exception('Auth not found');
  }
}
