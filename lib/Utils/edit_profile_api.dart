import 'dart:convert';
import 'package:diorama_id/main.dart';
import 'package:http/http.dart' as http;

class EditProfile {

  static Future<String> ChangePassRequest(userID, old_password, new_password) async {
    var data = {
      "UserId": userID,
      "OldPassword": old_password,
      "NewPassword": new_password,
    };
    final response = await http.post(
        Uri.parse("https://diorama-id.herokuapp.com/setUserPassword"),
        body: json.encode(data),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        }
    );
    if (response.statusCode == 200) {
      return "SUCCESS";
    }
    return "ERROR";
  }

  static Future<String?> ChangePPRequest(userID, var file) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://diorama-id.herokuapp.com/setUserPP'));
    request.headers["Content-Type"] = 'multipart/form-data';
    request.headers["Authorization"] = 'Bearer ${Holder.token}';

    final PPImage = http.MultipartFile.fromBytes('picture', file);

    request.files.add(PPImage);

    var res = await request.send();

    if (res.statusCode == 200) {
      return "SUCCESS";
    }
    else {
      return res.reasonPhrase;
    }
  }

  static Future<String> EditUserDetail(userID, Username, Name, Email) async {
    var data = {
      "UserId": userID,
      "Username": Username,
      "Name": Name,
      "Email": Email,
    };
    var header = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${Holder.token}',
  };
  
    final response = await http.post(
        Uri.parse("https://diorama-id.herokuapp.com/setUserDetail"),
        body: json.encode(data),
        headers: header
    );
    if (response.statusCode == 200) {
      return "SUCCESS";
    }
    return "ERROR";
  }
}



