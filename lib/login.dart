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
  final bool _hidePassword = true;
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
                    const SizedBox(height: 40),
                    const Text(
                      'Login',
                      style: TextStyle(fontSize: 32),
                    ),
                    const SizedBox(height: 40),
                    TextFormField(
                      decoration: const InputDecoration(
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
                      onChanged: (value) {
                        usernameUser = value.toString();
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        passwordUser = value.toString();
                      },
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please wait...')),
                          );
                          AuthApi.loginRequest(usernameUser, passwordUser)
                              .then((response) {
                            if (response["error"] == null) {
                              Holder.token = response["token"];
                              // print(Holder.token);
                              Holder.userID = response['user_id'];
                              // print(Holder.token);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const NavBar()),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Login failed. Please enter a correct username and password.')),
                              );
                            }
                          });
                        }
                      },
                      child: const Text('Login'),
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
                            text: 'Do not have an account? ',
                            style: TextStyle(color: Colors.black)),
                        WidgetSpan(
                            child: GestureDetector(
                          child: const Text(
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
                                  builder: (context) => const RegisterPage()),
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
