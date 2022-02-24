// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'home.dart';
import 'edit_profile.dart';
import 'edit_password.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diorama',
      home: const NavBar(),
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   actions: <Widget>[
      //     TextButton(
      //       style: TextButton.styleFrom(
      //         padding: const EdgeInsets.only(left: 30.0, right: 30.0),
      //         primary: Color.fromARGB(255, 148, 3, 3),
      //       ),
      //       onPressed: () {
      //         // balik ke halaman profile
      //       },
      //       child: Text('Cancel'),
      //     ),
      //     TextButton(
      //       style: TextButton.styleFrom(
      //         padding: const EdgeInsets.only(left: 30.0, right: 30.0),
      //         primary: Colors.white,
      //       ),
      //       onPressed: () {
      //         // balik ke halaman profile
      //       },
      //       child: Text('Done'),
      //     ),
      //   ],
      // ),
      body: const EditProfilePage(),
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
