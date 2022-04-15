import 'package:diorama_id/main.dart';
import 'package:flutter/material.dart';
import 'package:diorama_id/model/profile.dart';
import 'model/follows_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _userID = 1;
  // late Profile profile;
  String _username = "";
  var _trips = [];
  var _tripPictures = [];
  var followings = [];
  late Followers _followingList;

  @override
  void initState() {
    super.initState();

    fetchFollowing(_userID.toString()).then((list) {
      _followingList = list[0];
      print(_followingList.list);
      setState(() {});
    });

    // if(FirebaseAuth.instance.currentUser() != null){

    //   Navigator.of(context).pushReplacement(MaterialPageRoute(
    //     builder: (context) => HomeScreen()
    //   ));
    // }
  }

  // Apakah username berbeda dari name user?
  bool _isUsernameVisible = true;

  // Apakah profile milik sendiri?
  bool _isSelfProfile = false;

  // Apakah user mem-follow user ini?
  bool _isFollowed = false;

  // Apakah trips user kosong?
  bool _noTrips = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF1F1F1),
        body: FutureBuilder(
          future: getUser(_userID.toString()),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text("Loading..."),
                ),
              );
            } else {
              // Profile a = snapshot.data[0];
              // print(a);
              // return Text(a.name);
              return profileView(context, snapshot);
            }
          },
        ));
  }

  Widget profileView(BuildContext context, AsyncSnapshot snapshot) {
    Profile _profile = snapshot.data[0];
    var _profilepp = snapshot.data[1];
    if (_profile.name == _profile.username) {
      _isUsernameVisible = false;
    }
    if (_profile.userID == _userID) {
      _isSelfProfile = true;
    }
    // if (_followingList.list["userID"].contains(_profile.userID)) {
    //   _isFollowed = true;
    // }
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        Container(
          color: const Color(0xFFD4F1F4),
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              CircleAvatar(
                radius: 100,
                backgroundImage: MemoryImage(_profilepp),
                backgroundColor: Colors.transparent,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                _profile.username,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 3),
              Visibility(
                child: Text(
                  _profile.username,
                  style: TextStyle(fontSize: 16),
                ),
                visible: _isUsernameVisible,
              ),
              SizedBox(height: 20),
              Visibility(
                  child: Text('Edit Profile \u{1F58C}',
                      style: TextStyle(fontSize: 16, color: Colors.blue)),
                  visible: _isSelfProfile),
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
            ])),
        Container(
          child: tripListView(context, snapshot),
        ),
      ],
    );
  }

  Widget tripListView(BuildContext context, AsyncSnapshot snap) {
    return Container(
      child: FutureBuilder(
          future: getTripFromUser(_userID.toString()),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Visibility(
                child: Container(
                  child: Center(
                    child: Text("No Trips Available"),
                  ),
                ),
                visible: _noTrips,
              );
            } else {
              // print(snap.data);
              // print(snapshot.data);
              return tripView(context, snapshot);
            }
          }),
    );
  }

  Widget tripView(BuildContext context, AsyncSnapshot snapshot) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: snapshot.data[0].length,
      itemBuilder: (context, index) {
        return tripCard(context, snapshot, index);
      },
    );
  }

  Widget tripCard(BuildContext context, AsyncSnapshot snapshot, int index) {
    return Stack(
      children: <Widget>[
        _tripPic(context, snapshot, index),
        _tripText(context, snapshot, index),
      ],
    );
  }

  Widget _tripPic(BuildContext context, AsyncSnapshot snapshot, int index) {
    var _img = snapshot.data[1][index];
    print(snapshot.data[1][1]);
    if (snapshot.data[1][index].length == 0) {
      return Container(
        child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("No Image"),
        ])),
      );
    } else {
      return Container(
          height: 150,
          width: double.infinity,
          child: Image.memory(
            _img,
            fit: BoxFit.cover,
          ));
    }
  }

  Widget _tripText(BuildContext context, AsyncSnapshot snapshot, int index) {
    dynamic _tripName = snapshot.data[0][index].TripName;
    dynamic _tripStartDate = snapshot.data[0][index].StartDate;
    dynamic _tripEndDate = snapshot.data[0][index].EndDate;
    dynamic _tripLocation = snapshot.data[0][index].LocationName;
    return Container(
        height: 150,
        child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed) ||
                        states.contains(MaterialState.hovered))
                      return const Color(0x70000000);
                    return Colors.transparent; // Use the component's default.
                  },
                )),
                onPressed: () {},
                child: Container(
                    height: 150,
                    width: double.infinity,
                    alignment: Alignment.bottomLeft,
                    padding: EdgeInsets.fromLTRB(4, 8, 4, 8),
                    child: RichText(
                      text: TextSpan(
                        text: '$_tripName\n',
                        style: TextStyle(color: Colors.white, fontSize: 22),
                        children: <TextSpan>[
                          TextSpan(
                              text: '$_tripStartDate - $_tripEndDate\n',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                height: 1.5,
                              )),
                          TextSpan(
                              text: '$_tripLocation\n',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                height: 1.5,
                              )),
                        ],
                      ),
                    )))));
  }
}
//   ListView(shrinkWrap: true, children: <Widget>[
//         Container(
//           color: const Color(0xFFD4F1F4),
//           child: Column(
//             children: [
//               SizedBox(height: 40),
//               CircleAvatar(
//                 radius: 100.0,
//                 backgroundImage: NetworkImage(
//                     'https://avatars.githubusercontent.com/u/57818885?v=4'),
//                 backgroundColor: Colors.transparent,
//               ),
//               SizedBox(height: 20),
//               Text(
//                 _username,
//                 style: TextStyle(fontSize: 24),
//               ),
//               SizedBox(height: 3),
//               Visibility(
//                 child: Text(
//                   _username,
//                   style: TextStyle(fontSize: 16),
//                 ),
//                 visible: _isUsernameVisible,
//               ),
//               SizedBox(height: 20),
//               Visibility(
//                 child: Text(
//                   'Edit Profile \u{1F58C}',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: const Color(0xFF189AB4),
//                   ),
//                 ),
//                 visible: _isSelfProfile,
//               ),
//               Visibility(
//                 child: TextButton(
//                     child: Text(
//                       'Follow',
//                       style: TextStyle(
//                           fontSize: 18.0, color: const Color(0xFFFFFFFF)),
//                     ),
//                     style: ButtonStyle(
//                       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                           RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(50.0),
//                               side: BorderSide(color: Colors.transparent))),
//                       backgroundColor: MaterialStateProperty.resolveWith<Color>(
//                         (Set<MaterialState> states) {
//                           if (states.contains(MaterialState.pressed) ||
//                               states.contains(MaterialState.hovered))
//                             return const Color(0xFF05445E);
//                           return const Color(
//                               0xFF189AB4); // Use the component's default.
//                         },
//                       ),
//                       padding: MaterialStateProperty.all<EdgeInsets>(
//                           EdgeInsets.fromLTRB(30, 15, 30, 15)),
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _isFollowed = true;
//                       });
//                     }),
//                 visible: (!_isSelfProfile && !_isFollowed),
//               ),
//               Visibility(
//                 child: TextButton(
//                     child: Text(
//                       'Unfollow',
//                       style: TextStyle(
//                           fontSize: 18.0, color: const Color(0xFF189AB4)),
//                     ),
//                     style: ButtonStyle(
//                       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                           RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(50.0),
//                               side:
//                                   BorderSide(color: const Color(0xFF189AB4)))),
//                       backgroundColor: MaterialStateProperty.resolveWith<Color>(
//                         (Set<MaterialState> states) {
//                           if (states.contains(MaterialState.pressed) ||
//                               states.contains(MaterialState.hovered))
//                             return const Color(0xFF9DE2E2);
//                           return Colors
//                               .transparent; // Use the component's default.
//                         },
//                       ),
//                       padding: MaterialStateProperty.all<EdgeInsets>(
//                           EdgeInsets.fromLTRB(30, 15, 30, 15)),
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _isFollowed = false;
//                       });
//                     }),
//                 visible: (!_isSelfProfile && _isFollowed),
//               ),
//               SizedBox(height: 40),
//             ],
//           ),
//         ),
//         Container(
//             width: double.infinity,
//             child:
//                 Column(mainAxisAlignment: MainAxisAlignment.start, children: [
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(18.0),
//                   color: Colors.white,
//                   child: Text(
//                     'Trips',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                 ),
//               ),
//               Visibility(
//                 child: SizedBox(height: 20),
//                 visible: _noTrips,
//               ),
//               Visibility(
//                 child: Text(
//                   'No trips available',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: const Color(0x95000000),
//                   ),
//                 ),
//                 visible: _noTrips,
//               ),
//               Visibility(
//                 child: SizedBox(height: 20),
//                 visible: _noTrips,
//               ),
//               Visibility(
//                 child: Stack(children: <Widget>[
//                   Container(
//                     height: 150,
//                     width: double.infinity,
//                     child: Image.network(
//                       'https://drive.google.com/uc?export=view&id=1DMtJUYp6U2F2FXDkGCdfJOno0k_0RcG6',
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   Container(
//                     height: 150,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: [
//                           const Color(0x02000000),
//                           const Color(0x90000000),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     height: 150,
//                     width: double.infinity,
//                     child: SizedBox(
//                         width: double.infinity,
//                         height: double.infinity, // <-- match_parent
//                         child: TextButton(
//                           style: ButtonStyle(
//                             backgroundColor: MaterialStateProperty.resolveWith<Color>(
//                                   (Set<MaterialState> states) {
//                                 if (states.contains(MaterialState.pressed) ||
//                                     states.contains(MaterialState.hovered))
//                                   return const Color(0x70000000);
//                                 return Colors
//                                     .transparent; // Use the component's default.
//                               },
//                             ),
//                           ),
//                           onPressed: () {},
//                           child: Container(
//                             height: 150,
//                             width: double.infinity,
//                             alignment: Alignment.bottomLeft,
//                             padding: EdgeInsets.fromLTRB(4, 8, 4, 8),
//                             child: RichText(
//                               text: TextSpan(
//                                 text:
//                                 'jalan-jalan di planet bumi sebagai manusia biasa\n',
//                                 style: TextStyle(color: Colors.white, fontSize: 22.0),
//                                 children: const <TextSpan>[
//                                   TextSpan(
//                                       text: '16 Feb 2022 - 21 Feb 2022\n',
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 12.0,
//                                           height: 1.5)),
//                                   TextSpan(
//                                       text:
//                                       'Tokyo, Japan, Asia, Planet Bumi, Galaksi Milky Way',
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 12.0,
//                                           height: 1.5)),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         )),
//                   ),
//                 ]),
//                 visible: !_noTrips,
//               ),
//               Visibility(
//                 child: Stack(children: <Widget>[
//                   Container(
//                     height: 150,
//                     width: double.infinity,
//                     child: Image.network(
//                       'https://drive.google.com/uc?export=view&id=1EnkLO8V868NWgzcbmy-6OTGtkHXMPINF',
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   Container(
//                     height: 150,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: [
//                           const Color(0x02000000),
//                           const Color(0x90000000),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     height: 150,
//                     child: SizedBox(
//                         width: double.infinity,
//                         height: double.infinity, // <-- match_parent
//                         child: TextButton(
//                           style: ButtonStyle(
//                             backgroundColor: MaterialStateProperty.resolveWith<Color>(
//                                   (Set<MaterialState> states) {
//                                 if (states.contains(MaterialState.pressed) ||
//                                     states.contains(MaterialState.hovered))
//                                   return const Color(0x70000000);
//                                 return Colors
//                                     .transparent; // Use the component's default.
//                               },
//                             ),
//                           ),
//                           onPressed: () {},
//                           child: Container(
//                             height: 150,
//                             width: double.infinity,
//                             alignment: Alignment.bottomLeft,
//                             padding: EdgeInsets.fromLTRB(4, 8, 4, 8),
//                             child: RichText(
//                               text: TextSpan(
//                                 text:
//                                 'sekolah rantau di negara sebelah, taunya malah kiamat (real)\n',
//                                 style: TextStyle(color: Colors.white, fontSize: 22.0),
//                                 children: const <TextSpan>[
//                                   TextSpan(
//                                       text: '10 May S.1206 - 26 Aug S.1206\n',
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 12.0,
//                                           height: 1.5)),
//                                   TextSpan(
//                                       text: 'Leeves, Erebonia, Zemuria',
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 12.0,
//                                           height: 1.5)),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         )),
//                   )
//                 ]),
//                 visible: !_noTrips,
//               ),
//               Visibility(
//                 child: Stack(children: <Widget>[
//                   Container(
//                     height: 150,
//                     width: double.infinity,
//                     child: Image.network(
//                       'https://drive.google.com/uc?export=view&id=1dcKb4FWicycUGU50RHdfqOe-68hRhxQP',
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   Container(
//                     height: 150,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: [
//                           const Color(0x02000000),
//                           const Color(0x90000000),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     height: 150,
//                     child: SizedBox(
//                         width: double.infinity,
//                         height: double.infinity, // <-- match_parent
//                         child: TextButton(
//                           style: ButtonStyle(
//                             backgroundColor: MaterialStateProperty.resolveWith<Color>(
//                                   (Set<MaterialState> states) {
//                                 if (states.contains(MaterialState.pressed) ||
//                                     states.contains(MaterialState.hovered))
//                                   return const Color(0x70000000);
//                                 return Colors
//                                     .transparent; // Use the component's default.
//                               },
//                             ),
//                           ),
//                           onPressed: () {},
//                           child: Container(
//                             height: 150,
//                             width: double.infinity,
//                             alignment: Alignment.bottomLeft,
//                             padding: EdgeInsets.fromLTRB(4, 8, 4, 8),
//                             child: RichText(
//                               text: TextSpan(
//                                 text: '2 jam di rumah ga ngapa-ngapain\n',
//                                 style: TextStyle(color: Colors.white, fontSize: 22.0),
//                                 children: const <TextSpan>[
//                                   TextSpan(
//                                       text: '14 Feb 2022 - 14 Feb 2022\n',
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 12.0,
//                                           height: 1.5)),
//                                   TextSpan(
//                                       text: 'Depan Laptop',
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 12.0,
//                                           height: 1.5)),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         )),
//                   )
//                 ]),
//                 visible: !_noTrips,
//               ),
//             ]))
//       ]),

// }
