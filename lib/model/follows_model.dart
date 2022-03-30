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

Future<dynamic> getUserData(String UserID) async{
  final response = await http.get(Uri.parse('http://127.0.0.1:3000/getUserByID/$UserID'));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load followed users');
  }
}
Future<List> fetchFollowers(String UserID) async {
  final response = await http.get(Uri.parse('http://127.0.0.1:3000/getFollowers/$UserID'));
  var imglist = [];
  if (response.statusCode == 200) {
    Followers json = Followers.fromJson(jsonDecode(response.body));
    for (var element in json.list){
      final img = await http.get(Uri.parse('http://127.0.0.1:3000/getPPByID/${element["userId"]}'));
      imglist.add(img.bodyBytes);
    }
    return [json,imglist];
  } else {
    return [[],[]];
  }

}

Future<List> fetchFollowing(String UserID) async {
  final response = await http.get(Uri.parse('http://127.0.0.1:3000/getFollowedUsers/$UserID'));
  var imglist = [];
  if (response.statusCode == 200) {
    Followers json = Followers.fromJson(jsonDecode(response.body));
    for (var element in json.list){
      final img = await http.get(Uri.parse('http://127.0.0.1:3000/getPPByID/${element["userId"]}'));
      imglist.add(img.bodyBytes);
    }
    return [json,imglist];
  } else {
    return [[],[]];
  }
}