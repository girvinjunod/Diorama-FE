import 'dart:convert';
import 'package:http/http.dart' as http;

class Timeline {
  final List<dynamic> list;

  const Timeline({required this.list});

  factory Timeline.fromJson(Map<String, dynamic> json) {
    return Timeline(
      list: json['timeline_data'],
    );
  }
}

Future<dynamic> getUserData(String UserID) async{
  final response = await http.get(Uri.parse('http://127.0.0.1:3000/getUserByID/$UserID'));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load user data');
  }
}

Future<dynamic> getTimeline(String UserID) async{
  final response = await http.get(Uri.parse('http://127.0.0.1:3000/getTimeline/$UserID'));
  var imglist = [];
  if (response.statusCode == 200) {
    Timeline json = Timeline.fromJson(jsonDecode(response.body));
    for (var element in json.list) {
      final img = await http.get(Uri.parse('http://127.0.0.1:3000/getEventPictureByID/${element["eventID"]}'));
      imglist.add(img.bodyBytes);
    }
    return [json, imglist];
  } else {
    throw Exception('Failed to load timeline data');
  }
}