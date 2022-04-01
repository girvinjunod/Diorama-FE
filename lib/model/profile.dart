import 'dart:convert';
import 'package:http/http.dart' as http;

class Trips {
  final List<dynamic> list;

  const Trips({required this.list});

  factory Trips.fromJson(Map<String, dynamic> json) {
    return Timeline(
      list: json['tripIds'],
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

Future<dynamic> getUserPP(String UserID) async{
  final response = await http.get(Uri.parse('http://127.0.0.1:3000/getPPByID/$UserID'));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load user profpic');
  }

Future<dynamic> getTripIdsFromUser(String UserID) async{
  final response = await http.get(Uri.parse('http://127.0.0.1:3000/getTripsByUser/$UserID'));
  var imgTripList = [];
  if (response.statusCode == 200) {
    Trips json = Trips.fromJson(jsonDecode(response.body));
    for (var element in json.list) {
      final img = await http.get(Uri.parse('http://127.0.0.1:3000/getTripsImage/$element'));
      imgTripList.add(img.bodyBytes);
    }
    return [json, imgTripList];
  } else {
    throw Exception('Failed to load trips');
  }
}

