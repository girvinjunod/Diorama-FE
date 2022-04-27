import 'package:diorama_id/main.dart';
import 'package:flutter/material.dart';
import 'edit_password.dart';
import 'model/edit_profile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io';
import 'package:email_validator/email_validator.dart';

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
  final _formKey = GlobalKey<FormState>();
  String? Uname = null;
  String? Name = null;
  final _userID = Holder.userID;
  var _imageFile;
  var _imagePath;
  bool isNotPicked = true;
  var message = "";
  TextEditingController Email = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserData(_userID.toString()).then((userdata) {
      setState(() {
        Uname = userdata["username"];
        Name = userdata["name"];
        Email.text = userdata["email"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController msgController = TextEditingController();

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                primary: const Color.fromARGB(255, 148, 3, 3),
              ),
              onPressed: () {
                // balik ke halaman profile
                Navigator.pop(context,true);
              },
              child: const Text('Cancel'),
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
                  var edit_succ = false;
                  var pp_succ = true;
                  EditProfile.EditUserDetail(_userID, Uname, Name, Email.text)
                      .then((response) {
                    if (response == "SUCCESS") {
                      edit_succ = true;
                    }
                    EditProfile.ChangePPRequest(
                            _userID, _imageFile, _imagePath, isNotPicked)
                        .then((response) {
                      if (!isNotPicked && _imageFile != null) {
                        if (response == "SUCCESS") {
                          pp_succ = true;
                        } else {
                          pp_succ = false;
                        }
                      }
                      if (pp_succ && edit_succ) {
                        message = "Profile updated";
                        Navigator.pop(context);
                        
                      } else {
                        message = "Unable to update profile";
                      }
                      final snackBar = SnackBar(
                        content: Text(
                          message,
                          style: const TextStyle(fontSize: 20),
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    });
                  });
                
                }
              },
              child: const Text('Done'),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            const SizedBox(height: 50),
            Container(child: _imageFile != null
              ? CircleAvatar(
              radius: 100, // Image radius
              backgroundImage: Image.file(_imageFile).image,
              backgroundColor: Colors.transparent)
              : CircleAvatar(
              radius: 100, // Image radius
              backgroundImage: NetworkImage(
                        "http://34.101.123.15:8080/getPPByID/$_userID",),
              backgroundColor: Colors.transparent),
              ),
            TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                primary: const Color.fromARGB(255, 60, 133, 125),
              ),
              onPressed: () {
                _getFromGallery();
                isNotPicked = false;
                // buka file manager untuk ambil foto
              },
              child: const Text('Change Picture'),
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
                      initialValue: Name,
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
                      initialValue: Uname,
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
                      controller: Email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email address';
                        }
                        if (!EmailValidator.validate(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      //initialValue: Email.text,
                      onSaved: (value) => setState(() {
                        if (value != null){
                          Email.text = value.toString();
                        }
                      }),
                    ),
                  ],
                ),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(50, 20, 0, 20),
                  primary: const Color.fromARGB(255, 60, 133, 125),
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
  _getFromGallery() async {
    ImagePicker picker = ImagePicker();
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if (kIsWeb) {
        var f = await pickedFile.readAsBytes();
        setState(() {
          _imagePath = pickedFile.path;
          _imageFile = f;
        });
      } else {
        setState(() {
          _imageFile = File(pickedFile.path);
          _imagePath = pickedFile.path;
        });
      }
    }
  }
}
