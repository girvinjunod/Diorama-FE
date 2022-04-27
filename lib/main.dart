// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:diorama_id/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'home.dart';
import 'profile.dart';
import 'login.dart';
import 'search.dart';
import 'add_trip.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const storage = FlutterSecureStorage();
  String? value = await storage.read(key: "jwt");
  String? id = await storage.read(key: "userID");
  // print(value);
  if (value != null) {
    Holder.token = value;
    Holder.userID = id!;
    runApp(MyApp(
      jwt: value,
    ));
  } else {
    runApp(const MyApp());
  }
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final String? jwt;
  const MyApp({Key? key, this.jwt}) : super(key: key);

//if jwt is not null, build with home equals Homepage, else LoginPage
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diorama',
      home: jwt == null ? const LoginPage() : const NavBar(),
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            backgroundColor: Colors.cyan.shade700,
            foregroundColor: Colors.white,
            elevation: 0),
      ),
    );
  }
}

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  final _pages = [const TripFeed(), const AddTripPage(), ProfilePage(int.parse(Holder.userID))];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diorama',
            style: TextStyle(fontFamily: 'Condiment', fontSize: 35)),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SearchPage()),
                  );
                },
                child: const Icon(
                  Icons.search,
                  size: 26.0,
                ),
              ))
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Trip',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        backgroundColor: Colors.cyan.shade700,
        onTap: _onItemTapped,
      ),
    );
  }
}

class Holder {
  static String token = "";

  static String userID = "-1";
}
