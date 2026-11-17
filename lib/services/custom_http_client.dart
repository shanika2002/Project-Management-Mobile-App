import 'dart:io';
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;

class CustomHttpClient {
  // Create a custom HTTP client with SSL bypass
  static Future<http.Client> createIOClient() async {
    HttpClient httpClient = HttpClient();
    httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => true; 
    return IOClient(httpClient);
  }

  // GET request
  static Future<http.Response> get(String url, {Map<String, String>? headers}) async {
    final client = await createIOClient();
    final response = await client.get(Uri.parse(url), headers: headers);
    return response;
  }

  // POST request
  static Future<http.Response> post(String url, {Map<String, String>? headers, Object? body}) async {
    final client = await createIOClient();
    final response = await client.post(Uri.parse(url), headers: headers, body: body);
    return response;
  }
}
