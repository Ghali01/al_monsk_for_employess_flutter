import 'dart:convert';

import 'package:employee/utils/server.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EmployeesAPI {
  static Future<String> login(String token) async {
    http.Response response = await Server.send(
      http.get,
      'employees/data',
      headers: {
        'Authorization': ' Token $token',
      },
      useToken: false,
    );
    if (response.statusCode == 200) {
      return utf8.decode(response.bodyBytes);
    }

    throw Exception();
  }

  static Future<String> getProfile() async {
    http.Response response = await Server.send(http.get, 'employees/data');

    if (response.statusCode == 200) {
      return utf8.decode(response.bodyBytes);
    }

    throw Exception();
  }
}
