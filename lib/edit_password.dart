import 'package:diorama_id/main.dart';
import 'package:flutter/material.dart';
import 'model/edit_profile.dart';

class EditPasswordPage extends StatefulWidget {
  const EditPasswordPage({Key? key}) : super(key: key);

  @override
  EditPasswordPageState createState() => EditPasswordPageState();
}

class EditPasswordPageState extends State<EditPasswordPage> {
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    bool _hidePassword = true;
    TextEditingController msgController = TextEditingController();
    //String msg = "aaaa";
    String oldPassword = "";
    String newPassword = "";
    String valPassword = "";
    final _userID = int.parse(Holder.userID);

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                primary: const Color.fromARGB(255, 148, 3, 3),
              ),
              onPressed: () {
                // balik ke halaman edit profile
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        ),
        body: Center(
          child: ListView(shrinkWrap: true, children: <Widget>[
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
                          hintText: '',
                          hintStyle:
                              TextStyle(height: 2, fontWeight: FontWeight.bold),
                          labelText: 'Old Password',
                          floatingLabelBehavior: FloatingLabelBehavior.always),
                      obscureText: _hidePassword,
                      validator: (String? value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 6) {
                          return 'Please enter a minimum of 6 characters';
                        }
                        return null;
                      },
                      onSaved: (value) => setState(() {
                        oldPassword = value!;
                      }),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: '',
                          hintStyle:
                              TextStyle(height: 2, fontWeight: FontWeight.bold),
                          labelText: 'New Password',
                          floatingLabelBehavior: FloatingLabelBehavior.always),
                      obscureText: _hidePassword,
                      validator: (String? value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 6) {
                          return 'Please enter a minimum of 6 characters';
                        }
                        return null;
                      },
                      onSaved: (value) => setState(() {
                        newPassword = value!;
                      }),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: '',
                          hintStyle:
                              TextStyle(height: 2, fontWeight: FontWeight.bold),
                          labelText: 'Confirm Password',
                          floatingLabelBehavior: FloatingLabelBehavior.always),
                      obscureText: _hidePassword,
                      validator: (String? value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 6) {
                          return 'Please enter a minimum of 6 characters';
                        }

                        return null;
                      },
                      onSaved: (value) => setState(() {
                        valPassword = value!;
                      }),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          String message = "";
                          if (newPassword == valPassword) {
                            EditProfile.ChangePassRequest(
                                    _userID, oldPassword, newPassword)
                                .then((response) {
                              if (response == "SUCCESS") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Password Changed Successfully')),
                                );
                                Navigator.pop(context);
                                Navigator.pop(context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(response)),
                                );
                              }
                            });
                          } else {
                            message = "Confirm password does not match";
                            final snackBar = SnackBar(
                              content: Text(
                                message,
                                style: const TextStyle(fontSize: 20),
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        }
                      },
                      child: const Text('Save'),
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xFF05445E),
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 50.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ));
  }
}
