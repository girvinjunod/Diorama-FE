import 'dart:convert';
import 'package:diorama_id/main.dart';
import 'package:http/http.dart' as http;

class AllEvent {
  final List<dynamic> EventID;

  const AllEvent({
    required this.EventID,
  });

  factory AllEvent.fromJson(Map<String, dynamic> json) {
    return AllEvent(
      EventID: json['eventIDs'],
    );
  }
}

Future<List> getAllEvent(int tripID) async {
  var header = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${Holder.token}',
  };

  final response = await http
      .get(Uri.parse('http://34.101.123.15:8080/getEventsFromTrip/$tripID'), headers: header);

  var imglist = [];
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    AllEvent eventID = AllEvent.fromJson(jsonDecode(response.body));
    for (int i = 0; i < eventID.EventID.length; i++) {
      final img = await http.get(Uri.parse(
          'http://34.101.123.15:8080/getEventPictureByID/${eventID.EventID[i]}'), headers: header);
      imglist.add(img.bodyBytes);
    }

    return [eventID, imglist];
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load DetailEvent');
  }
}

class DetailTrip {
  final int TripID;
  final int UserID;
  final String StartDate;
  final String EndDate;
  final String TripName;
  final String LocationName;

  const DetailTrip({
    required this.TripID,
    required this.UserID,
    required this.StartDate,
    required this.EndDate,
    required this.TripName,
    required this.LocationName,
  });

  factory DetailTrip.fromJson(Map<String, dynamic> json) {
    return DetailTrip(
      TripID: json['id'],
      UserID: json['userId'],
      StartDate: json['startDate'],
      EndDate: json['endDate'],
      TripName: json['tripName'],
      LocationName: json['locationName'],
    );
  }
}

Future<DetailTrip> getDetailTrip(int tripID) async {
  var header = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${Holder.token}',
  };
  
  final response = await http
      .get(Uri.parse('http://34.101.123.15:8080/getTripDetailByID/$tripID'), headers: header);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return DetailTrip.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load DetailEvent');
  }
}
