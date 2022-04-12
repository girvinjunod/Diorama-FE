import 'dart:convert';
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
  final response = await http
      .get(Uri.parse('https://diorama-id.herokuapp.com/searchUser/$query'));

  var imglist = [];
  if (response.statusCode == 200) {
    Search json = Search.fromJson(jsonDecode(response.body));
    for (var element in json.list) {
      final img = await http.get(Uri.parse(
          'https://diorama-id.herokuapp.com/getPPByID/${element["id"]}'));
      imglist.add(img.bodyBytes);
    }
    return [json, imglist];
  } else {
    // No users found
    return [];
  }
}
