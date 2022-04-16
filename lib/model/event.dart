import 'dart:convert';
import 'dart:io';
import 'package:diorama_id/main.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

Future<String?> addEvent(String tripID, String userID, String caption,
    String eventDate, String postTime, var file, String path) async {
  var request = http.MultipartRequest(
      'POST', Uri.parse('https://diorama-id.herokuapp.com/addEvent'));
  // request.headers["Content-Type"] = 'multipart/form-data';
  request.headers["Authorization"] = 'Bearer ${Holder.token}';
  request.fields["tripID"] = tripID;
  request.fields["userID"] = userID;
  request.fields["caption"] = caption;
  request.fields["eventDate"] = eventDate;
  // request.fields["postTime"] = postTime;

  final eventImage = http.MultipartFile.fromBytes(
      'picture', await File.fromUri(Uri.parse(path)).readAsBytes(),
      contentType: MediaType('image', 'jpeg'));
  // final eventImage = await http.MultipartFile.fromPath('picture', file);
  request.files.add(eventImage);

  var res = await request.send();

  print("reason: ");
  print(res.reasonPhrase);
  print(res.statusCode);
  print(res.headers);
  print(res.request?.headers);

  if (res.statusCode == 200) {
    return "SUCCESS";
  } else {
    return res.reasonPhrase;
  }
}
