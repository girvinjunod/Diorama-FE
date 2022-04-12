import 'dart:convert';
import 'package:http/http.dart' as http;

class Feed {
  final int userID;
  final String username;
  final int eventID;
  final String caption;
  final String tripname;

  const Feed(
      {required this.userID,
      required this.username,
      required this.eventID,
      required this.caption,
      required this.tripname});

  factory Feed.fromJson(Map<String, dynamic> json) {
    return Feed(
      userID: json['userID'],
      username: json['username'],
      eventID: json['eventID'],
      caption: json['caption'],
      tripname: json['tripname'],
    );
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
  final response =
      await http.get(Uri.parse('http://127.0.0.1:3000/getUserByID/$UserID'));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load user data');
  }
}

Future<dynamic> getTimeline(String UserID) async {
  final response =
      await http.get(Uri.parse('http://127.0.0.1:3000/getTimeline/$UserID'));
  // print(response.body);
  var imglist = [];
  if (response.statusCode == 200) {
    dynamic json = Timeline.fromJson(jsonDecode(response.body));
    for (var element in json.list) {
      final img = await http.get(Uri.parse(
          'http://127.0.0.1:3000/getEventPictureByID/${element["eventID"]}'));
      imglist.add(img.bodyBytes);
    }
    // print(json.list);
    return [json, imglist];
  } else {
    throw Exception('Failed to load timeline data');
  }
}
