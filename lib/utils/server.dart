import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:ping_discover_network_forked/ping_discover_network_forked.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class Server {
  static const int port = 8000;

  static String? host;
  static const String protocol = 'http';
  static const String webSocketProtocol = 'ws';
  static Future<http.Response> send(Function method, String path,
      {Object? body,
      Map<String, String>? headers,
      bool jsonBody = true,
      bool useToken = true}) async {
    String url = '$protocol://$host:$port/$path';

    if (useToken) {
      SharedPreferences sp = await SharedPreferences.getInstance();

      String token = sp.getString('token') ?? '';
      headers ??= {};
      headers['Authorization'] = ' Token $token';
    }
    if (method == http.get) {
      String qp = '?';
      if (body is Map) {
        for (var e in body.entries) {
          qp = qp + '${e.key}=${e.value}&';
        }
      }
      return await http.get(
        Uri.parse(url + qp),
        headers: headers,
      );
    } else {
      if (jsonBody) {
        headers ??= {};
        headers['Content-Type'] = 'application/json';
        body = jsonEncode(body);
      }
      return await method(Uri.parse(url), body: body, headers: headers);
    }
  }

  static String getAbsluteUrl(String path) => '$protocol://$host:$port$path';
  static String getWsUrl(String path) =>
      '$webSocketProtocol://$host:$port$path';

  static Future<bool> scan() async {
    var i = await NetworkInterface.list();
    String ip = i.first.addresses.first.address;
    ip = ip.substring(0, ip.lastIndexOf('.'));

    await for (NetworkAddress addr in NetworkAnalyzer.discover2(ip, port,
        timeout: const Duration(seconds: 3))) {
      if (addr.exists) {
        host = addr.ip;
        return true;
      }
    }
    return false;
  }
}
