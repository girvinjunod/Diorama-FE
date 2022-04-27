import 'dart:convert';
import 'package:diorama_id/main.dart';
import 'package:http/http.dart' as http;

class Feed {
  final int userID;
  final String username;
  final int eventID;
  final String caption;
  final String tripname;
  final int tripID;

  const Feed(
      {required this.userID,
      required this.username,
      required this.eventID,
      required this.caption,
      required this.tripname,
      required this.tripID});

  factory Feed.fromJson(Map<String, dynamic> json) {
    return Feed(
        userID: json['userID'],
        username: json['username'],
        eventID: json['eventID'],
        caption: json['caption'],
        tripname: json['tripname'],
        tripID: json['tripID']);
  }
}

class Timeline {
  final List<dynamic> list;

  const Timeline({required this.list});

  factory Timeline.fromJson(dynamic json) {
    // var feedList = json['timeline_data'] as List;
    // List<dynamic> _feed = feedList.map((i) => Feed.fromJson(i)).toList();
    return Timeline(
      list: json['timeline_data'],
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
    throw Exception('Failed to load user data');
  }
}

Future<dynamic> getTimeline(String UserID) async {
  var header = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${Holder.token}',
  };
  final response = await http.get(
      Uri.parse('http://34.101.123.15:8080/getTimeline/$UserID'),
      headers: header);
  var imglist = [];
  if (response.statusCode == 200) {
    Timeline json =
        Timeline.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    return json;
  } else {
    return const Timeline(list: []);
  }
}
