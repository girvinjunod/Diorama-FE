import 'dart:convert';
import 'package:diorama_id/main.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

class DetailEvent {
  final int EventID;
  final int UserID;
  final int TripID;
  final String Caption;
  final String EventDate;
  final String PostTime;

  const DetailEvent(
      {required this.EventID,
      required this.UserID,
      required this.TripID,
      required this.Caption,
      required this.EventDate,
      required this.PostTime});

  factory DetailEvent.fromJson(Map<String, dynamic> json) {
    return DetailEvent(
      EventID: json['id'],
      TripID: json['tripId'],
      UserID: json['userId'],
      Caption: json['caption'],
      EventDate: json['eventDate'],
      PostTime: json['postTime'],
    );
  }
}

Future<DetailEvent> getDetailEvent(int EventID) async {
  var header = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${Holder.token}',
  };

  final response = await http.get(
      Uri.parse('http://34.101.123.15:8080/getEventDetailByID/$EventID'),
      headers: header);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    log('data: $response.body');
    return DetailEvent.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    log('failed');
    throw Exception('Failed to load DetailEvent');
  }
}

Future<List> getEventPicture(int EventID) async {
  var header = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${Holder.token}',
  };

  final response = await http.get(
      Uri.parse('http://34.101.123.15:8080/getEventPictureByID/$EventID'),
      headers: header);

  var imglist = [];
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    imglist.add(response.bodyBytes);
    return imglist;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load DetailEvent');
  }
}
