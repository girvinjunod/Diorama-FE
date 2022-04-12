import 'dart:convert';
import 'package:http/http.dart' as http;

class Profile {
  final String userID;
  final String username;
  final String name;

  const Profile(
      {required this.userID, required this.username, required this.name});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      userID: json['userID'],
      username: json['username'],
      name: json['name'],
    );
  }
}

class Trips {
  final List<dynamic> list;

  const Trips({required this.list});

  factory Trips.fromJson(dynamic json) {
    return Trips(
      list: json['tripIds'],
    );
  }
}

class TripDetail {
  final int UserID;
  final String StartDate;
  final String EndDate;
  final String TripName;
  final String LocationName;

  const TripDetail(
      {required this.UserID,
      required this.StartDate,
      required this.EndDate,
      required this.TripName,
      required this.LocationName});

  factory TripDetail.fromJson(Map<String, dynamic> json) {
    return TripDetail(
      UserID: json['UserID'],
      StartDate: json['StartDate'],
      EndDate: json['EndDate'],
      TripName: json['TripName'],
      LocationName: json['LocationName'],
    );
  }
}

Future<dynamic> getUserData(String UserID) async {
  final response =
      await http.get(Uri.parse('http://127.0.0.1:3000/getUserByID/$UserID'));
  if (response.statusCode == 200) {
    return Profile.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load user data');
  }
}

Future<dynamic> getUserPP(String UserID) async {
  final response =
      await http.get(Uri.parse('http://127.0.0.1:3000/getPPByID/$UserID'));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load user profpic');
  }
}

Future<dynamic> getProfile(String UserID) async {
  final user = getUserData(UserID);
  final pp = getUserPP(UserID);
  return [user, pp];
}

Future<dynamic> getTripFromUser(String UserID) async {
  final response =
      await http.get(Uri.parse('http://127.0.0.1:3000/getTripsByUser/$UserID'));
  print(response.body.runtimeType);
  var imgTripList = [];
  var tripList = [];
  if (response.statusCode == 200) {
    Trips json = Trips.fromJson(jsonDecode(response.body));
    for (var element in json.list) {
      final img = await http
          .get(Uri.parse('http://127.0.0.1:3000/getTripsImage/$element'));
      imgTripList.add(img.bodyBytes);
      final detail = await http
          .get(Uri.parse('http://127.0.0.1:3000/getTripDetailByID/$element'));
      tripList.add(TripDetail.fromJson(jsonDecode(detail.body)));
    }
    return [tripList, imgTripList];
  } else {
    throw Exception('Failed to load trips');
  }
}
