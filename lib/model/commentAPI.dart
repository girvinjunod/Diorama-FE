import 'dart:convert';
import 'package:diorama_id/main.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

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

Future<dynamic> getComments(String UserID, String EventID) async {
  var header = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiZ2lydmluanVub2QifQ.uy_5_DzArTfCLZh5zgebUok27RwtmAykmTxXAu7-FdY',
  };
  final response = await http.get(
      Uri.parse('http://34.101.123.15:8080/GetCommentsFromEvent/$EventID'),
      headers: header);
  // developer.log(response.statusCode.toString());s
  if (response.statusCode == 200) {
    Comments json = Comments.fromJson(jsonDecode(response.body));
    return json;
  } else {
    throw Exception('Failed to load timeline data');
  }
}

Future<dynamic> getPPUser(String UserID) async {
  var header = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiZ2lydmluanVub2QifQ.uy_5_DzArTfCLZh5zgebUok27RwtmAykmTxXAu7-FdY',
  };
  final response = await http.get(
      Uri.parse('http://34.101.123.15:8080/getPPByID/$UserID'),
      headers: header);
  developer.log(response.body);
  if (response.statusCode == 200) {
    return "SUCCESS";
  } else {
    throw Exception('Failed to load timeline data');
  }
}

Future<String> addComment(userID, EventID, Text) async {
  var header = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiZ2lydmluanVub2QifQ.uy_5_DzArTfCLZh5zgebUok27RwtmAykmTxXAu7-FdY',
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
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiZ2lydmluanVub2QifQ.uy_5_DzArTfCLZh5zgebUok27RwtmAykmTxXAu7-FdY',
  };
  var data = {
    "id": commentID,
  };
  final response = await http.post(
      Uri.parse("http://34.101.123.15:8080/deleteComment"),
      body: json.encode(data),
      headers: header);
  if (response.statusCode == 200) {
    return "SUCCESS";
  }
  return "ERROR";
}
