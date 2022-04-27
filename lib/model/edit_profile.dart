import 'dart:convert';
import 'dart:io';
import 'package:diorama_id/main.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class EditProfile {

  static Future<String> ChangePassRequest(userID, old_password, new_password) async {
    var data = {
      "userID": userID,
      "OldPassword": old_password,
      "NewPassword": new_password,
    };
    final response = await http.post(
        Uri.parse("http://34.101.123.15:8080/setUserPassword"),
        body: json.encode(data),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiZ2lydmluanVub2QifQ.uy_5_DzArTfCLZh5zgebUok27RwtmAykmTxXAu7-FdY',
        }
    );
    print("reason: ");
      print(response.statusCode);
      print(response.reasonPhrase);
      print(response.headers);
      print(response.request?.headers);
    if (response.statusCode == 200) {
      return "SUCCESS";
    }
    Map<String, dynamic> res = json.decode(response.body);
    return res["msg"];
  }

  static Future<String?> ChangePPRequest(userID, var file, var path, bool isNotPicked) async {
    if (file !=null && !isNotPicked)
    {  var request = http.MultipartRequest(
        'PUT', Uri.parse('http://34.101.123.15:8080/setUserPP/$userID'));
    // request.headers["Content-Type"] = 'multipart/form-data';
      request.headers["Authorization"] = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiZ2lydmluanVub2QifQ.uy_5_DzArTfCLZh5zgebUok27RwtmAykmTxXAu7-FdY';
      request.fields["userID"] = userID.toString();
      // request.fields["postTime"] = postTime;

      final eventImage = http.MultipartFile.fromBytes(
          'picture', await File.fromUri(Uri.parse(path)).readAsBytes(),
          contentType: MediaType('image', 'jpeg'));
      // final eventImage = await http.MultipartFile.fromPath('picture', file);
      request.files.add(eventImage);

      var res = await request.send();

      print("reason: ");
      print(res.reasonPhrase);
      print(res.statusCode);
      print(res.headers);
      print(res.request?.headers);

      if (res.statusCode == 200) {
        return "SUCCESS";
      } else {
        return res.reasonPhrase;
      }}
  }

  static Future<String> EditUserDetail(userID, Username, Name, Email) async {
    var data = {
      "username": Username,
      "email": Email,
      "name": Name,
    };
    final response = await http.put(
        Uri.parse("http://34.101.123.15:8080/setUserDetail/$userID"),
        body: json.encode(data),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiZ2lydmluanVub2QifQ.uy_5_DzArTfCLZh5zgebUok27RwtmAykmTxXAu7-FdY',
        }
    );
    print("reason: ");
    print(response.reasonPhrase);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return "SUCCESS";
    }
    return "ERROR";
  }
}
Future<dynamic> getUserData(String UserID) async {
    var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiZ2lydmluanVub2QifQ.uy_5_DzArTfCLZh5zgebUok27RwtmAykmTxXAu7-FdY',
    };
    final response = await http.get(
        Uri.parse('http://34.101.123.15:8080/getUserByID/$UserID'),
        headers: header);
    print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load followed users');
    }
  }
