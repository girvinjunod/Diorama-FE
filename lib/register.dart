import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'login.dart';
import 'model/register.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final bool _hidePassword = true;
  final TextEditingController _uname = TextEditingController();
  final TextEditingController _fullname = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirm = TextEditingController();
  final TextEditingController _mail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
        backgroundColor: const Color(0xFF9DE2E2),
        body: Center(
          child: Container(constraints: const BoxConstraints(maxWidth: 1200),child:
          ListView(shrinkWrap: true, children: <Widget>[
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(80.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('images/logo.png'),
                      const SizedBox(height: 40),
                      const Text(
                        'Register',
                        style: TextStyle(fontSize: 32),
                      ),
                      const SizedBox(height: 40),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          icon: Icon(Icons.mail),
                          hintText: 'example@example.com',
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        controller: _mail,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an email address';
                          }
                          if (!EmailValidator.validate(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Full Name',
                          icon: Icon(Icons.account_circle),
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        controller: _fullname,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          icon: Icon(Icons.account_circle),
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        controller: _uname,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a username';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          icon: Icon(Icons.lock),
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        obscureText: _hidePassword,
                        controller: _password,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Confirm Password',
                          icon: Icon(Icons.lock_outline),
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        obscureText: _hidePassword,
                        controller: _confirm,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password confirmation';
                          }
                          if (value != _password.text) {
                            return 'Password does not match';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            register(_uname.text, _mail.text, _fullname.text, _password.text).then((status){
                              if(status == "SUCCESS"){
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Account successfully registered')),
                                );
                                Navigator.pushAndRemoveUntil<dynamic>(
                                  context,
                                  MaterialPageRoute<dynamic>(
                                    builder: (BuildContext context) => const LoginPage(),
                                  ),
                                  (route) => false,
                                );
                              }
                              else
                              {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Error registering account')),
                                );
                              }
                            });

                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                          }
                        },
                        child: const Text('Register'),
                        style: ElevatedButton.styleFrom(

                          primary: const Color(0xFF05445E),
                          padding: const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 50.0),
                        ),
                      ),
                      const SizedBox(height: 10),
                      RichText(
                        text: TextSpan(children: [
                          const TextSpan(
                              text: 'Already have an account? ',
                              style: TextStyle(color: Colors.black)),
                          WidgetSpan(
                              child: GestureDetector(
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.black,
                              ),
                            ),
                            onTap: () {
                              Navigator.pushAndRemoveUntil<dynamic>(
                              context,
                              MaterialPageRoute<dynamic>(
                                builder: (BuildContext context) => const LoginPage(),
                              ),
                              (route) => false,
                            );
                            },
                          )),
                        ]),
                      ),
                    ]),
              ),
            ),
          ]),
        )));
  }
}
