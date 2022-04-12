import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:typed_data';

class Followers {
  final List<dynamic> list;

  const Followers({required this.list});

  factory Followers.fromJson(Map<String, dynamic> json) {
    return Followers(
      list: json['followed_users'],
    );
  }
}

Future<dynamic> getUserData(String UserID) async {
  final response = await http
      .get(Uri.parse('https://diorama-id.herokuapp.com/getUserByID/$UserID'));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load followed users');
  }
}

Future<List> fetchFollowers(String UserID) async {
  final response = await http
      .get(Uri.parse('https://diorama-id.herokuapp.com/getFollowers/$UserID'));
  var imglist = [];
  if (response.statusCode == 200) {
    Followers json = Followers.fromJson(jsonDecode(response.body));
    for (var element in json.list) {
      final img = await http.get(Uri.parse(
          'https://diorama-id.herokuapp.com/getPPByID/${element["userId"]}'));
      imglist.add(img.bodyBytes);
    }
    return [json, imglist];
  } else {
    return [[], []];
  }
}

Future<List> fetchFollowing(String UserID) async {
  final response = await http.get(
      Uri.parse('https://diorama-id.herokuapp.com/getFollowedUsers/$UserID'));
  var imglist = [];
  if (response.statusCode == 200) {
    Followers json = Followers.fromJson(jsonDecode(response.body));
    for (var element in json.list) {
      final img = await http.get(Uri.parse(
          'https://diorama-id.herokuapp.com/getPPByID/${element["userId"]}'));
      imglist.add(img.bodyBytes);
    }
    return [json, imglist];
  } else {
    return [[], []];
  }
}
