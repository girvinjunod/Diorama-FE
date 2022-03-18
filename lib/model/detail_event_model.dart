import 'dart:convert';
import 'package:http/http.dart' as http;

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
      EventID: json['Id'],
      UserID: json['UserID'],
      TripID: json['TripID'],
      Caption: json['Caption'],
      EventDate: json['EventDate'],
      PostTime: json['PostTime'],
    );
  }
}

Future<DetailEvent> getDetailEvent(int EventID) async {
  final response =
      await http.get(Uri.parse('http://127.0.0.1:3000/getEventDetailByID/3'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return DetailEvent.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load DetailEvent');
  }
}
