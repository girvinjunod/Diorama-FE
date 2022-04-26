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
  // String data = "";
  // Future<Null> _fetchDataUser() async {
  //   String url = "http://34.101.123.15:8080/getUserByID/1";
  //   final response = await get(url as Uri);

  //   data = response.body.toString();
  // }

  String? Uname = null;
  String? Name = null;
  String? Email = null;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController msgController = TextEditingController();
    //String msg = "aaaa";

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

                  final message = "Profile Changed Successfully";
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
                          return 'Please enter some text';
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
                            value.length < 7) {
                          return 'Please enter minimum 7 words';
                        }
                        return null;
                      },
                      onSaved: (value) => setState(() {
                        Uname = value;
                      }),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: 'old username',
                          hintStyle:
                              TextStyle(height: 2, fontWeight: FontWeight.bold),
                          labelText: 'Email',
                          floatingLabelBehavior: FloatingLabelBehavior.always),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
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
