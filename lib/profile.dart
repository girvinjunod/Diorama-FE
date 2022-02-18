import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD4F1F4),
      body: ListView(shrinkWrap: true, children: <Widget>[
        Column(
          children: [
            SizedBox(height: 40),
            CircleAvatar(
              radius: 100.0,
              backgroundImage: NetworkImage(
                  'https://avatars.githubusercontent.com/u/57818885?v=4'),
              backgroundColor: Colors.transparent,
            ),
            SizedBox(height: 20),
            Text(
              'Nama Pengguna',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 3),
            Text(
              '(username_jika_beda)',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Edit Profile \u{1F58C}',
              style: TextStyle(
                  fontSize: 16,
                  color: const Color(0xFF189AB4),
              ),
            ),
            SizedBox(height: 40),
            Text(
              'Trips',
              style: TextStyle(fontSize: 20),
            ),
          ],
        )
      ]),
    );
  }
}
