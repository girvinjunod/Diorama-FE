import 'dart:convert';
import 'package:diorama_id/main.dart';
import 'package:http/http.dart' as http;

class Profile {
  final int userID;
  final String username;
  final String name;
  final String email;

  const Profile(
      {required this.userID,
      required this.username,
      required this.name,
      required this.email});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      userID: json['id'],
      username: json['username'],
      name: json['name'],
      email: json['email'],
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
      UserID: json['userId'],
      StartDate: json['startDate'],
      EndDate: json['endDate'],
      TripName: json['tripName'],
      LocationName: json['locationName'],
    );
  }
}

Future<dynamic> getUser(String UserID) async {
  var header = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${Holder.token}',
  };
  
  final response =
      await http.get(Uri.parse('http://34.101.123.15:8080/getUserByID/$UserID'), headers: header);
  final img =
      await http.get(Uri.parse('http://34.101.123.15:8080/getPPByID/$UserID'), headers: header);
  if (response.statusCode == 200 && img.statusCode == 200) {
    dynamic res = Profile.fromJson(jsonDecode(response.body));
    // print(res);

    return [res, img.bodyBytes];
  } else {
    throw Exception('Failed to load user data');
  }
}

Future<dynamic> getUserPP(String UserID) async {
  var header = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${Holder.token}',
  };

  final response =
      await http.get(Uri.parse('http://34.101.123.15:8080/getPPByID/$UserID'), headers: header);
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load user profpic');
  }
}

Future<dynamic> getProfile(String UserID) async {
  final user = await getUser(UserID);
  final pp = await getUserPP(UserID);
  return [user, pp];
}

Future<dynamic> getTripFromUser(String UserID) async {
  var header = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${Holder.token}',
  };

  final response =
      await http.get(Uri.parse('http://34.101.123.15:8080/getTripsByUser/$UserID'), headers: header);
  // print(response.body.runtimeType);
  var imgTripList = [];
  var tripList = [];
  if (response.statusCode == 200) {
    Trips json = Trips.fromJson(jsonDecode(response.body));
    for (var element in json.list) {
      final img = await http
          .get(Uri.parse('http://34.101.123.15:8080/getTripsImage/$element'), headers: header);
      imgTripList.add(img.bodyBytes);
      final detail = await http
          .get(Uri.parse('http://34.101.123.15:8080/getTripDetailByID/$element'), headers: header);
      tripList.add(TripDetail.fromJson(jsonDecode(detail.body)));
    }
    return [tripList, imgTripList];
  } else {
    throw Exception('Failed to load trips');
  }
}
