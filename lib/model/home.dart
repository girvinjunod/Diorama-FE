import 'dart:convert';
import 'package:http/http.dart' as http;

class Feed {
  final int userID;
  final String username;

  const FollowedUser({required this.userID, required this.username});

  factory FollowedUser.fromJson(Map<String, dynamic> json) {
    return FollowedUser(
      userID: json['userID'],
      username: json['username'],
    );
  }
}

Future<dynamic> getUserData(String UserID) async{
  final response = await http.get(Uri.parse('http://127.0.0.1:3000/getUserByID/$UserID'));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load Feed');
  }
}

Future<String> getTripsByUser(int UserID) async {
  final response = await http.get(Uri.parse('http://127.0.0.1:3000/getTripDetailByUser/$UserID'));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load Feed');
  }
  });

Future<String> getTripsImage(int tripID) async {
  final response = await http.get(Uri.parse('http://127.0.0.1:3000/getTripsImage/$tripID'));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load Feed');
  }
  });

  //print(body);

  final response = await http.post(
    Uri.parse('http://127.0.0.1:3000/getTripDetailByID/:id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    },
    body: body,
  );

  if (response.statusCode == 201) {
    return "SUCCESS";
  } else {
    // Error
    return "ERROR";
  }
}