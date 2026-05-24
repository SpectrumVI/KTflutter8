import 'dart:convert';
import 'package:http/http.dart' as http;
import '../error/exceptions.dart';

class ApiClient {
  final http.Client client;
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  ApiClient({required this.client});

  Future<dynamic> get(String path) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl$path'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw ServerException('HTTP ${response.statusCode}');
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw NetworkException(e.toString());
    }
  }
}
