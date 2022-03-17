import 'package:diorama_id/main.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Apakah username berbeda dari name user?
  bool _isUsernameVisible = true;

  // Apakah profile milik sendiri?
  bool _isSelfProfile = true;

  // Apakah user mem-follow user ini?
  bool _isFollowed = false;

  // Apakah trips user kosong?
  bool _noTrips = false;

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
                              borderRadius: BorderRadius.circular(50.0),
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
                              borderRadius: BorderRadius.circular(50.0),
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
              Visibility(
                child: Stack(children: <Widget>[
                  Container(
                    height: 150,
                    width: double.infinity,
                    child: Image.network(
                      'https://drive.google.com/uc?export=view&id=1DMtJUYp6U2F2FXDkGCdfJOno0k_0RcG6',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0x02000000),
                          const Color(0x90000000),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 150,
                    width: double.infinity,
                    child: SizedBox(
                        width: double.infinity,
                        height: double.infinity, // <-- match_parent
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed) ||
                                    states.contains(MaterialState.hovered))
                                  return const Color(0x70000000);
                                return Colors
                                    .transparent; // Use the component's default.
                              },
                            ),
                          ),
                          onPressed: () {},
                          child: Container(
                            height: 150,
                            width: double.infinity,
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.fromLTRB(4, 8, 4, 8),
                            child: RichText(
                              text: TextSpan(
                                text:
                                    'jalan-jalan di planet bumi sebagai manusia biasa\n',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22.0),
                                children: const <TextSpan>[
                                  TextSpan(
                                      text: '16 Feb 2022 - 21 Feb 2022\n',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          height: 1.5)),
                                  TextSpan(
                                      text:
                                          'Tokyo, Japan, Asia, Planet Bumi, Galaksi Milky Way',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          height: 1.5)),
                                ],
                              ),
                            ),
                          ),
                        )),
                  ),
                ]),
                visible: !_noTrips,
              ),
              Visibility(
                child: Stack(children: <Widget>[
                  Container(
                    height: 150,
                    width: double.infinity,
                    child: Image.network(
                      'https://drive.google.com/uc?export=view&id=1EnkLO8V868NWgzcbmy-6OTGtkHXMPINF',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0x02000000),
                          const Color(0x90000000),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 150,
                    child: SizedBox(
                        width: double.infinity,
                        height: double.infinity, // <-- match_parent
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed) ||
                                    states.contains(MaterialState.hovered))
                                  return const Color(0x70000000);
                                return Colors
                                    .transparent; // Use the component's default.
                              },
                            ),
                          ),
                          onPressed: () {},
                          child: Container(
                            height: 150,
                            width: double.infinity,
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.fromLTRB(4, 8, 4, 8),
                            child: RichText(
                              text: TextSpan(
                                text:
                                    'sekolah rantau di negara sebelah, taunya malah kiamat (real)\n',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22.0),
                                children: const <TextSpan>[
                                  TextSpan(
                                      text: '10 May S.1206 - 26 Aug S.1206\n',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          height: 1.5)),
                                  TextSpan(
                                      text: 'Leeves, Erebonia, Zemuria',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          height: 1.5)),
                                ],
                              ),
                            ),
                          ),
                        )),
                  )
                ]),
                visible: !_noTrips,
              ),
              Visibility(
                child: Stack(children: <Widget>[
                  Container(
                    height: 150,
                    width: double.infinity,
                    child: Image.network(
                      'https://drive.google.com/uc?export=view&id=1dcKb4FWicycUGU50RHdfqOe-68hRhxQP',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0x02000000),
                          const Color(0x90000000),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 150,
                    child: SizedBox(
                        width: double.infinity,
                        height: double.infinity, // <-- match_parent
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed) ||
                                    states.contains(MaterialState.hovered))
                                  return const Color(0x70000000);
                                return Colors
                                    .transparent; // Use the component's default.
                              },
                            ),
                          ),
                          onPressed: () {},
                          child: Container(
                            height: 150,
                            width: double.infinity,
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.fromLTRB(4, 8, 4, 8),
                            child: RichText(
                              text: TextSpan(
                                text: '2 jam di rumah ga ngapa-ngapain\n',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22.0),
                                children: const <TextSpan>[
                                  TextSpan(
                                      text: '14 Feb 2022 - 14 Feb 2022\n',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          height: 1.5)),
                                  TextSpan(
                                      text: 'Depan Laptop',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          height: 1.5)),
                                ],
                              ),
                            ),
                          ),
                        )),
                  )
                ]),
                visible: !_noTrips,
              ),
            ]))
      ]),
    );
  }
}
