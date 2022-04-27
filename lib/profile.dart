import 'dart:async';

import 'package:diorama_id/detail_trip.dart';
import 'package:diorama_id/edit_profile.dart';
import 'package:diorama_id/follows.dart';
import 'package:diorama_id/login.dart';
import 'package:diorama_id/main.dart';
import 'package:diorama_id/model/Logout.dart';
import 'package:flutter/material.dart';
import 'package:diorama_id/model/profile.dart';
import 'model/follows_model.dart';

class ProfilePage extends StatefulWidget {
  final int _userID;
  const ProfilePage(this._userID, {Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState(this._userID);
}

class _ProfilePageState extends State<ProfilePage> {
  final int _userID;
  _ProfilePageState(this._userID);
  // late Profile profile;
  var followings = [];
  var followernum = 0;
  var followingnum = 0;

  @override
  void initState() {
    super.initState();
    _isSelfProfile = int.parse(Holder.userID) == _userID;
    fetchFollowStatus(Holder.userID, _userID.toString()).then((result) {
      _isFollowed = result == "YES";
    });
    fetchFollowNum(_userID.toString()).then((result) {
      setState(() {
        followernum = result[0];
        followingnum = result[1];
      });
    });
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
        appBar: AppBar(
            title: const Text("Profile",
                style: TextStyle(fontSize: 20, color: Colors.white))),
        backgroundColor: const Color(0xFFF1F1F1),
        body: FutureBuilder(
          future: getUser(_userID.toString()),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: Text("Loading..."),
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
    if (_profile.name == _profile.username) {
      _isUsernameVisible = false;
    }
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        Container(
          width: double.infinity,
          color: const Color(0xFFD4F1F4),
          child: Column(
            children: [
              Container(
                alignment: Alignment.topRight,
                child: Visibility(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      primary: const Color.fromARGB(255, 148, 3, 3),
                    ),
                    onPressed: () {
                      Logout().then((response) {
                        if (response == "SUCCESS") {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                              (r) => false);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Logout failed')),
                          );
                        }
                      });
                    },
                    child: const Text('Logout'),
                  ),
                  visible: _isSelfProfile,
                ),
              ),
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 100,
                backgroundImage: NetworkImage(
                    "http://34.101.123.15:8080/getPPByID/$_userID" "?x=" +
                        DateTime.now().millisecondsSinceEpoch.toString()),
                backgroundColor: Colors.transparent,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                _profile.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 3),
              Visibility(
                child: Text(
                  _profile.username,
                  style: const TextStyle(fontSize: 16),
                ),
                visible: _isUsernameVisible,
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FollowPage(_userID)),
                  );
                },
                child: Text(
                  '$followingnum Following | $followernum Follower',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Color(0xFF05445E),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Visibility(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EditProfilePage()),
                    ).then(onGoBack);
                  },
                  child: const Text(
                    'Edit Profile \u{1F58C}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF189AB4),
                    ),
                  ),
                ),
                visible: _isSelfProfile,
              ),
              Visibility(
                child: TextButton(
                    child: const Text(
                      'Follow',
                      style:
                          TextStyle(fontSize: 18.0, color: Color(0xFFFFFFFF)),
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              side:
                                  const BorderSide(color: Colors.transparent))),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed) ||
                              states.contains(MaterialState.hovered)) {
                            return const Color(0xFF05445E);
                          }
                          return const Color(
                              0xFF189AB4); // Use the component's default.
                        },
                      ),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.fromLTRB(30, 15, 30, 15)),
                    ),
                    onPressed: () {
                      followUser(Holder.userID, _userID.toString())
                          .then((result) {
                        if (result == "SUCCESS") {
                          _isFollowed = true;
                          setState(() {
                            followernum += 1;
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Error following.')),
                          );
                        }
                      });
                      setState(() {});
                    }),
                visible: (!_isSelfProfile && !_isFollowed),
              ),
              Visibility(
                child: TextButton(
                    child: const Text(
                      'Unfollow',
                      style:
                          TextStyle(fontSize: 18.0, color: Color(0xFF189AB4)),
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              side:
                                  const BorderSide(color: Color(0xFF189AB4)))),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed) ||
                              states.contains(MaterialState.hovered)) {
                            return const Color(0xFF9DE2E2);
                          }
                          return Colors
                              .transparent; // Use the component's default.
                        },
                      ),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.fromLTRB(30, 15, 30, 15)),
                    ),
                    onPressed: () {
                      unfollowUser(Holder.userID, _userID.toString())
                          .then((result) {
                        if (result == "SUCCESS") {
                          _isFollowed = false;
                          setState(() {
                            followernum -= 1;
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Error unfollowing.')),
                          );
                        }
                      });
                      setState(() {});
                    }),
                visible: (!_isSelfProfile && _isFollowed),
              ),
              const SizedBox(height: 40),
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
                  child: const Text(
                    'Trips',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Visibility(
                child: const SizedBox(height: 20),
                visible: _noTrips,
              ),
              Visibility(
                child: const Text(
                  'No trips available',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0x95000000),
                  ),
                ),
                visible: _noTrips,
              ),
              Visibility(
                child: const SizedBox(height: 20),
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
                child: const Center(
                  child: Text("No Trips Available"),
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
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return tripCard(context, snapshot, index);
      },
    );
  }

  Widget tripCard(BuildContext context, AsyncSnapshot snapshot, int index) {
    return Stack(
      children: <Widget>[
        _tripPic(context, snapshot, index),
        Container(
          height: 150,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0x50000000),
                Color(0xB0000000),
              ],
            ),
          ),
        ),
        _tripText(context, snapshot, index),
      ],
    );
  }

  Widget _tripPic(BuildContext context, AsyncSnapshot snapshot, int index) {
    return Container(
        height: 150,
        width: double.infinity,
        child: Image.network(
          "http://34.101.123.15:8080/getTripsImage/${snapshot.data[0][index].TripID}",
          fit: BoxFit.cover,
        ));
  }

  FutureOr onGoBack(dynamic value) {
    refreshData();
    setState(() {});
  }

  void refreshData() {
    fetchFollowStatus(Holder.userID, _userID.toString()).then((result) {
      _isFollowed = result == "YES";
    });
    fetchFollowNum(_userID.toString()).then((result) {
      setState(() {
        followernum = result[0];
        followingnum = result[1];
      });
    });
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
                        states.contains(MaterialState.hovered)) {
                      return const Color(0x70000000);
                    }
                    return Colors.transparent;
                  },
                )),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        settings: const RouteSettings(name: "/mytrip"),
                        builder: (context) => DetailTripPage(
                            snapshot.data[0][index].TripID, _userID)),
                  ).then(onGoBack);
                  ;
                },
                child: Container(
                    height: 150,
                    width: double.infinity,
                    alignment: Alignment.bottomLeft,
                    padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
                    child: RichText(
                      text: TextSpan(
                        text: '$_tripName\n',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 22),
                        children: <TextSpan>[
                          TextSpan(
                              text: '$_tripStartDate - $_tripEndDate\n',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                height: 1.5,
                              )),
                          TextSpan(
                              text: '$_tripLocation\n',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                height: 1.5,
                              )),
                        ],
                      ),
                    )))));
  }
}
