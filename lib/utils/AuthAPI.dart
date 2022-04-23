import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthApi {
  static Future<Map<String, dynamic>> loginRequest(username, password) async {
    var data = {
      "username": username,
      "password": password,
    };
    final response = await http.post(
        Uri.parse("http://34.101.123.15:8080/login"),
        body: json.encode(data),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        });
    var response_body = json.decode(response.body) as Map<String, dynamic>;
    return response_body;
  }

  static Future<Map<String, dynamic>> RegisterRequest(
      username, email, name, password) async {
    var data = {
      "username": username,
      "email": email,
      "name": name,
      "password": password,
    };
    final response = await http.post(
        Uri.parse("http://34.101.123.15:8080/login"),
        body: json.encode(data),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        });
    var response_body = json.decode(response.body) as Map<String, dynamic>;
    return response_body["error"];
  }
}
