import 'dart:convert';
import 'package:diorama_id/main.dart';
import 'package:http/http.dart' as http;

class Trip {
  final int UserID;
  final String StartDate;
  final String EndDate;
  final String TripName;
  final String LocationName;

  const Trip(
      {required this.UserID,
      required this.StartDate,
      required this.EndDate,
      required this.TripName,
      required this.LocationName});

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      UserID: json['UserID'],
      StartDate: json['StartDate'],
      EndDate: json['EndDate'],
      TripName: json['TripName'],
      LocationName: json['LocationName'],
    );
  }
}

Future<List> addTrip(int UserID, String StartDate, String EndDate,
    String TripName, String LocationName) async {
  String body = jsonEncode(<String, dynamic>{
    'UserID': UserID,
    'StartDate': StartDate,
    'EndDate': EndDate,
    'TripName': TripName,
    'LocationName': LocationName,
  });

  //print(body);

  final response = await http.post(
    Uri.parse('http://34.101.123.15:8080/addTrip'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${Holder.token}',
    },
    body: body,
  );

  if (response.statusCode == 200) {
    return ["SUCCESS", jsonDecode(response.body)["TripID"]];
  } else {
    // Error
    return ["ERROR", null];
  }
}
