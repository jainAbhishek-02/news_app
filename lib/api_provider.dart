import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class NetworkApi {
  // String url;
  // NetworkApi(this.url);
  static const _baseUrl = 'https://newsapi.org/v2/';

  Future getResponse(String url) async {
    try {
      final _response = await http.get(Uri.parse(_baseUrl + url));
      if (_response.statusCode == 200) {
        return jsonDecode(_response.body);
      }
    } on SocketException {
      print('No internet Connection');
    }
  }

  Future post(String url, Map body) async {
    try {
      final response = await http.post(Uri.parse(_baseUrl + url), body: body);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('bad request or bad response');
      }
    } on SocketException {
      print('No internet Connection');
    }
  }
}
