import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:diorama_id/main.dart';

class Comments {
  final List<dynamic> list;

  const Comments({required this.list});

  factory Comments.fromJson(Map<String, dynamic> json) {
    return Comments(
      list: json['comments'],
    );
  }
}

Future<dynamic> getUserData(String UserID) async {
  var header = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${Holder.token}',
  };
  final response = await http.get(
      Uri.parse('http://34.101.123.15:8080/getUserByID/$UserID'),
      headers: header);

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load followed users');
  }
}

Future<dynamic> getComments(String UserID, String EventID) async {
  var header = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${Holder.token}',
  };
  final response = await http.get(
      Uri.parse('http://34.101.123.15:8080/GetCommentsFromEvent/$EventID'),
      headers: header);
  // developer.log(response.statusCode.toString());s
  if (response.statusCode == 200) {
    Comments json =
        Comments.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    return json;
  } else {
    throw Exception('Failed to load comments data');
  }
}

Future<String> addComment(int userID, int EventID, String Text) async {
  var header = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${Holder.token}',
  };
  var data = {
    "EventID": EventID,
    "UserID": userID,
    "Text": Text,
  };
  final response = await http.post(
      Uri.parse("http://34.101.123.15:8080/addComment"),
      body: json.encode(data),
      headers: header);

  if (response.statusCode == 200) {
    return "SUCCESS";
  }
  return "ERROR";
}

Future<String> deleteComment(commentID) async {
  var header = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${Holder.token}',
  };
  var data = {
    "id": commentID,
  };
  final response = await http.delete(
      Uri.parse("http://34.101.123.15:8080/deleteComment/$commentID"),
      body: json.encode(data),
      headers: header);
  if (response.statusCode == 200) {
    return "SUCCESS";
  }
  return "ERROR";
}
