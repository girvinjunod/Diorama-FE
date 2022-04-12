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

Future<dynamic> getUserData(String UserID) async {
  final response = await http
      .get(Uri.parse('https://diorama-id.herokuapp.com/getUserByID/$UserID'));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load user data');
  }
}

Future<dynamic> getTimeline(String UserID) async {
  final response = await http
      .get(Uri.parse('https://diorama-id.herokuapp.com/getTimeline/$UserID'));
  var imglist = [];
  if (response.statusCode == 200) {
    Timeline json = Timeline.fromJson(jsonDecode(response.body));
    return json;
  } else {
    throw Exception('Failed to load timeline data');
  }
}
