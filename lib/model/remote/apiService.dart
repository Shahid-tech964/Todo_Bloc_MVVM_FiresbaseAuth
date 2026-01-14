import 'dart:io';

import 'package:http/http.dart' as http;

class Apiservice {
  Future<http.Response> getjson() async {
    var response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/posts"),
    );

    return response;
  }
}
