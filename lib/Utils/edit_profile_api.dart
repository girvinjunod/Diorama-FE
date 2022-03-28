import 'dart:convert';
import 'package:http/http.dart' as http;

class EditProfile {

  Future<String> ChangePassRequest(userID, old_password, new_password) async {
    var data = {
      "UserId": userID,
      "OldPassword": old_password,
      "NewPassword": new_password,
    };
    final response = await http.post(
        Uri.parse("http://127.0.0.1:3000/setUserPassword"),
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

  Future<String?> ChangePPRequest(userID, var file) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://127.0.0.1:3000/setUserPP'));
    request.headers["Content-Type"] = 'multipart/form-data';

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

  Future<String> EditUserDetail(userID, Username, Name, Email) async {
    var data = {
      "UserId": userID,
      "Username": Username,
      "Name": Name,
      "Email": Email,
    };
    final response = await http.post(
        Uri.parse("http://127.0.0.1:3000/setUserDetail"),
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
}



