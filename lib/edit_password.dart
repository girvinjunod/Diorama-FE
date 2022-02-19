import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

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
    String msg = "aaaa";

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
                // balik ke halaman edit profile
                Navigator.pop(context);
              },
              child: Text('Cancel'),
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
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
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
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
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
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: Text(msg),
                      alignment: Alignment.centerRight,
                    ),
                    SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Loading...')),
                          );
                        }
                      },
                      child: const Text('Save'),
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xFF05445E),
                        padding: EdgeInsets.symmetric(
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
