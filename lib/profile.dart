import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isUsernameVisible = true;
  bool _isSelfProfile = false;
  bool _isFollowed = false;
  bool _noTrips = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      body: ListView(shrinkWrap: true, children: <Widget>[
        Container(
          color: const Color(0xFFD4F1F4),
          child: Column(
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
              Visibility(
                child: Text(
                  '(username_jika_beda)',
                  style: TextStyle(fontSize: 16),
                ),
                visible: _isUsernameVisible,
              ),
              SizedBox(height: 20),
              Visibility(
                child: Text(
                  'Edit Profile \u{1F58C}',
                  style: TextStyle(
                    fontSize: 16,
                    color: const Color(0xFF189AB4),
                  ),
                ),
                visible: _isSelfProfile,
              ),
              Visibility(
                child: TextButton(
                    child: Text(
                      'Follow',
                      style: TextStyle(
                          fontSize: 18.0, color: const Color(0xFFFFFFFF)),
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                              side: BorderSide(color: Colors.transparent))),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed) ||
                              states.contains(MaterialState.hovered))
                            return const Color(0xFF05445E);
                          return const Color(
                              0xFF189AB4); // Use the component's default.
                        },
                      ),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.fromLTRB(30, 15, 30, 15)),
                    ),
                    onPressed: () {
                      setState(() {
                        _isFollowed = true;
                      });
                    }),
                visible: (!_isSelfProfile && !_isFollowed),
              ),
              Visibility(
                child: TextButton(
                    child: Text(
                      'Unfollow',
                      style: TextStyle(
                          fontSize: 18.0, color: const Color(0xFF189AB4)),
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                              side:
                                  BorderSide(color: const Color(0xFF189AB4)))),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed) ||
                              states.contains(MaterialState.hovered))
                            return const Color(0xFF9DE2E2);
                          return Colors
                              .transparent; // Use the component's default.
                        },
                      ),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.fromLTRB(30, 15, 30, 15)),
                    ),
                    onPressed: () {
                      setState(() {
                        _isFollowed = false;
                      });
                    }),
                visible: (!_isSelfProfile && _isFollowed),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
        Container(
            width: double.infinity,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18.0),
                  color: Colors.white,
                  child: Text(
                    'Trips',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Visibility(
                child: SizedBox(height: 20),
                visible: _noTrips,
              ),
              Visibility(
                child: Text(
                  'No trips available',
                  style: TextStyle(
                    fontSize: 16,
                    color: const Color(0x95000000),
                  ),
                ),
                visible: _noTrips,
              ),
              Visibility(
                child: SizedBox(height: 20),
                visible: _noTrips,
              ),
            ]))
      ]),
    );
  }
}
