import 'dart:convert';

import 'package:http/http.dart' as http;

mixin ServiceMixin {
  Future<http.Response> post(String url, {Object? body}) {
    var uri = _getUri(url);
    var headers = {
      'Authorization': 'GoogleLogin',
      'auth': ServiceOption.instance.auth,
    };
    return http.post(uri, body: body, headers: headers);
  }

  Future<dynamic> get(String url) async {
    var uri = _getUri(url);
    var headers = {
      'Authorization': 'GoogleLogin auth=${ServiceOption.instance.auth}',
    };
    var response = await http.get(uri, headers: headers);
    if (response.statusCode != 200) throw Exception(response.reasonPhrase);
    return jsonDecode(response.body);
  }

  Uri _getUri(String url) {
    if (url.startsWith('http')) return Uri.parse(url);
    var baseUrl = ServiceOption.instance.endpoint;
    return Uri.parse('$baseUrl$url');
  }
}

class ServiceOption {
  static ServiceOption instance = ServiceOption();
  String endpoint = '';
  String username = '';
  String password = '';
  String auth = '';
}
