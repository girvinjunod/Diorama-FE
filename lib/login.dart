import 'package:diorama_id/register.dart';
import 'package:flutter/material.dart';
import 'utils/AuthAPI.dart';
import 'main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _hidePassword = true;
  String usernameUser = "";
  String passwordUser = "";

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
        backgroundColor: const Color(0xFF9DE2E2),
        body: Center(
          child: ListView(shrinkWrap: true, children: <Widget>[
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(80.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('images/logo.png'),
                    SizedBox(height: 40),
                    Text(
                      'Login',
                      style: TextStyle(fontSize: 32),
                    ),
                    SizedBox(height: 40),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Username',
                        icon: Icon(Icons.account_circle),
                        hintText: 'username',
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter username';
                        }
                        return null;
                      },
                      onChanged: (value){
                        usernameUser = value.toString();
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        icon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      obscureText: _hidePassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        return null;
                      },
                      onChanged: (value){
                        passwordUser = value.toString();
                      },
                    ),
                    SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please wait...')),
                          );
                          var response = AuthApi.loginRequest(usernameUser, passwordUser);
                          if (response == true){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const NavBar()),
                            );
                          } else{
                            //gagal
                          }
                        }
                      },
                      child: const Text('Login'),
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xFF05445E),
                        padding: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 50.0),
                      ),
                    ),
                    SizedBox(height: 10),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: 'Do not have an account? ',
                            style: TextStyle(color: Colors.black)),
                        WidgetSpan(
                            child: GestureDetector(
                          child: Text(
                            'Register',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.black,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()),
                            );
                          },
                        ))
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ));
  }
}
