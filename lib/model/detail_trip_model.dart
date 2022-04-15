import 'dart:convert';
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
  final response = await http
      .get(Uri.parse('http://127.0.0.1:3000/getEventsFromTrip/${tripID}'));

  var imglist = [];
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    AllEvent eventID = AllEvent.fromJson(jsonDecode(response.body));
    for (int i = 0; i < eventID.EventID.length; i++) {
      final img = await http.get(Uri.parse(
          'http://127.0.0.1:3000/getEventPictureByID/${eventID.EventID[i]}'));
      imglist.add(img.bodyBytes);
    }
    // for (var element in eventID.EventID) {
    //   final img = await http.get(
    //       Uri.parse('http://127.0.0.1:3000/getEventPictureByID/${element}'));
    //   imglist.add(img.bodyBytes);
    // }
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
  final response = await http
      .get(Uri.parse('http://127.0.0.1:3000/getTripDetailByID/${tripID}'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return DetailTrip.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load DetailEvent');
  }
}

// Future<List> getDetailTrip(int tripID) async {
//   final response = await http
//       .get(Uri.parse('http://127.0.0.1:3000/getTripDetailByID/${tripID}'));

//   final response2 = await http
//       .get(Uri.parse('http://127.0.0.1:3000/getEventsFromTrip/${tripID}'));

//   if (response.statusCode == 200 && response2.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     DetailTrip detail = DetailTrip.fromJson(jsonDecode(response.body));

//     AllEvent eventID = AllEvent.fromJson(jsonDecode(response.body));

//     var imglist = [];
//     for (var element in eventID.EventID) {
//       final img = await http.get(
//           Uri.parse('http://127.0.0.1:3000/getEventPictureByID/${element}'));
//       imglist.add(img.bodyBytes);
//     }

//     return [detail, imglist];
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load DetailEvent');
//   }
// }
