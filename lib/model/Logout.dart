import '../main.dart';

Future<String> Logout() async {
  Holder.token = "";
  Holder.userID = "";
  await storage.deleteAll();

  if (Holder.userID.isEmpty && Holder.token.isEmpty){
    return "SUCCESS";
  }
  return "FAILED";s
}