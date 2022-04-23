import 'dart:convert';
import 'package:diorama_id/main.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';

class Search {
  final List<dynamic> list;

  const Search({required this.list});

  factory Search.fromJson(Map<String, dynamic> json) {
    return Search(
      list: json['users'],
    );
  }
}

Future<List> fetchSearch(String query) async {
  var header = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${Holder.token}',
  };
  // print(header);
  // print(Holder.token);
  final response = await http.get(
      Uri.parse('http://34.101.123.15:8080/searchUser/$query'),
      headers: header);
  // print(response.body);

  var imglist = [];
  if (response.statusCode == 200) {
    Search json = Search.fromJson(jsonDecode(response.body));
    for (var element in json.list) {
      final img = await http.get(Uri.parse(
          'http://34.101.123.15:8080/getPPByID/${element["id"]}'));
      imglist.add(img.bodyBytes);
    }
    return [json, imglist];
  } else {
    // No users found
    return [];
  }
}
