import 'dart:convert';
import 'package:http/http.dart' as http;

class NewUser {
  final String Username;
  final String Email;
  final String Fullname;
  final String Password;

  const NewUser(
      {required this.Username,
      required this.Email,
      required this.Fullname,
      required this.Password});

  factory NewUser.fromJson(Map<String, dynamic> json) {
    return NewUser(
      Username: json['Username'],
      Email: json['Email'],
      Fullname: json['Fullname'],
      Password: json['Password'],
    );
  }
}

Future<String> register(
    String Username, String Email, String Fullname, String Password) async {
  String body = jsonEncode(<String, dynamic>{
    'username': Username,
    'email': Email,
    'name': Fullname,
    'password': Password,
  });

  //print(body);

  final response = await http.post(
    Uri.parse('http://34.101.123.15:8080/register'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    },
    body: body,
  );

  if (response.statusCode == 200) {
    return "SUCCESS";
  } else {
    // Error
    return "ERROR";
  }
}
