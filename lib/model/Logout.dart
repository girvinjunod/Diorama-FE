import '../main.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<String> Logout() async {
  Holder.token = "";
  Holder.userID = "";
  final storage = new FlutterSecureStorage();
  storage.deleteAll();

  if (Holder.userID.isEmpty && Holder.token.isEmpty){
    return "SUCCESS";
  }
  return "FAILED";
}