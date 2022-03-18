import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String?> addEvent(String tripID, String userID, String caption, String eventDate, String postTime, var file) async {
  var request = http.MultipartRequest('POST', Uri.parse('http://127.0.0.1:3000/addEvent'));
  request.headers["Content-Type"] = 'application/json';

  request.fields["tripID"] = tripID;
  request.fields["userID"] = userID;
  request.fields["caption"] = caption;
  request.fields["eventDate"] = eventDate;
  request.fields["postTime"] = postTime;
  request.fields["picture"] = postTime;

  final eventImage = http.MultipartFile.fromBytes('picture', file);
  // final eventImage = await http.MultipartFile.fromPath('picture', file);
  request.files.add(eventImage);

  print(request.headers);
  print(request.fields);
  print(request.files.length);

  var res = await request.send();

  print("reason: ");
  print(res.reasonPhrase);
  
  return res.reasonPhrase;
}