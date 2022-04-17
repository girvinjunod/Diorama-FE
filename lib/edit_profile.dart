import 'package:diorama_id/Utils/edit_profile_api.dart';
import 'package:diorama_id/main.dart';
import 'package:flutter/material.dart';
import 'edit_password.dart';
import 'package:http/http.dart';
import 'dart:convert';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  EditProfilePageState createState() => EditProfilePageState();
}

class EditProfilePageState extends State<EditProfilePage> {
  late Future<Map<String, dynamic>> data;

  String? Uname = null;
  String? Name = null;
  String? Email = null;
  int userID = int.parse(Holder.userID);
  String message = "";

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController msgController = TextEditingController();

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                primary: Color.fromARGB(255, 148, 3, 3),
              ),
              onPressed: () {
                // balik ke halaman profile
                Navigator.pop(context,true);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                primary: Colors.white,
              ),
              onPressed: () {
                // save form
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  var response = EditProfile.EditUserDetail(userID, Uname, Name, Email);
                  if (response == "SUCCESS") {
                    message = "Profile updated successfully";
                  } else {
                    message = "Error occurred. Cannot update profile.";
                  }
                  final snackBar = SnackBar(
                    content: Text(
                      message,
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: Text('Done'),
            ),
          ],
        ),
        body: Center(
          child: ListView(shrinkWrap: true, children: <Widget>[
            CircleAvatar(
              radius: 40, // Image radius
              backgroundImage: AssetImage('images/blank_profile.png'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                primary: Color.fromARGB(255, 60, 133, 125),
              ),
              onPressed: () {
                // buka file manager untuk ambil foto
              },
              child: Text('Change Picture'),
            ),
            //disini form
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(50, 20, 50, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: 'old name',
                          hintStyle:
                              TextStyle(height: 2, fontWeight: FontWeight.bold),
                          labelText: 'Name',
                          floatingLabelBehavior: FloatingLabelBehavior.always),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                      onSaved: (value) => setState(() {
                        Name = value;
                      }),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: 'old username',
                          hintStyle:
                              TextStyle(height: 2, fontWeight: FontWeight.bold),
                          labelText: 'Username',
                          floatingLabelBehavior: FloatingLabelBehavior.always),
                      validator: (String? value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 6) {
                          return 'Please enter a valid username';
                        }
                        return null;
                      },
                      onSaved: (value) => setState(() {
                        Uname = value;
                      }),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: 'old email',
                          hintStyle:
                              TextStyle(height: 2, fontWeight: FontWeight.bold),
                          labelText: 'Email',
                          floatingLabelBehavior: FloatingLabelBehavior.always),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email';
                        }
                        return null;
                      },
                      onSaved: (value) => setState(() {
                        Email = value;
                      }),
                    ),
                  ],
                ),
              ),
            ),
            // Container(
            //   margin: EdgeInsets.fromLTRB(50, 10, 50, 10),
            //   child: Text(msg),
            //   alignment: Alignment.centerRight,
            // ),
            TextButton(
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(50, 20, 0, 20),
                  primary: Color.fromARGB(255, 60, 133, 125),
                  alignment: Alignment.centerLeft),
              onPressed: () {
                // open change password page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EditPasswordPage()),
                );
              },
              child: Text('Change Password'),
            ),
          ]),
        ));
  }
}
