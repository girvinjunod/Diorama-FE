import 'dart:convert';
import 'package:diorama_id/main.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';


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
      Uri.parse('https://diorama-id.herokuapp.com/getUserByID/$UserID'),
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
      Uri.parse('https://diorama-id.herokuapp.com/getCommentDetailByID/$EventID'),
      headers: header);
  var imglist = [];
  if (response.statusCode == 200) {
    Comments json = Comments.fromJson(jsonDecode(response.body));
      return json;
  } else {
      throw Exception('Failed to load timeline data');
  }
}

static Future<String> addComment(userID, EventID, Text) async {
  var header = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${Holder.token}',
  };
  var data = {
    "EventId": EventID,
    "UserId": userID,
    "Text": Text,
  };
  final response = await http.post(
    Uri.parse("http://127.0.0.1:3000/addComment"),
    body: json.encode(data),
    headers: header);
  );
  log(response.reasonPhrase.toString());
  if (response.statusCode == 200) {
    return "SUCCESS";
  }
    return "ERROR";
}
