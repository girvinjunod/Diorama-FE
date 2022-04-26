import 'package:diorama_id/detail_trip.dart';
import 'package:diorama_id/edit_profile.dart';
import 'package:diorama_id/main.dart';
import 'package:flutter/material.dart';
import 'package:diorama_id/model/profile.dart';
import 'model/follows_model.dart';
import 'model/Logout.dart';
import 'follows.dart';

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
      // print(_followingList.list);
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
                height: 10,
              ),
              SizedBox(height: 3),
              Visibility(
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.only(left: 300.0, right: 10.0),
                    primary: Color.fromARGB(255, 148, 3, 3),
                  ),
                  onPressed: () {
                    var response = Logout();
                    if (response == "SUCCESS"){
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NavBar(),
                          ),
                              (r) => false);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                'Logout failed')),
                      );
                    }
                  },
                  child: Text('Logout'),
                ),
                visible: _isSelfProfile,
              ),
              SizedBox(
                height: 20,
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
                child:
                  Visibility(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                        primary: const Color(0xFF189AB4),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FollowPage()),
                        );
                      },
                      child: Text('Follower | Following'),
                    ),
                    visible: true,
                ),
                visible: true,
              ),
              SizedBox(height: 20),
              Visibility(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EditProfilePage()),
                    );
                  },
                  child: Text(
                    'Edit Profile \u{1F58C}',
                    style: TextStyle(
                      fontSize: 16,
                      color: const Color(0xFF189AB4),
                    ),
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
    // print(snapshot.data[1][1]);
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        // masih hardcode, fix later
                        builder: (context) => DetailTripPage(1, _userID)),
                  );
                },
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
