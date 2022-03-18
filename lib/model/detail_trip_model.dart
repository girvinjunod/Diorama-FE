import 'dart:convert';
import 'package:http/http.dart' as http;

class DetailTrip {
  final List<int> EventID;

  const DetailTrip({
    required this.EventID,
  });

  factory DetailTrip.fromJson(Map<String, dynamic> json) {
    return DetailTrip(
      EventID: json['eventIDs'],
    );
  }
}

Future<DetailTrip> getDetailTrip(int tripID) async {
  final response =
      await http.get(Uri.parse('http://127.0.0.1:3000/getEventsFromTrip/1'));

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
