import 'package:diorama_id/profile.dart';
import 'package:flutter/material.dart';
import 'model/follows_model.dart';
class FollowPage extends StatefulWidget {
  final int _userID;
  const FollowPage(this._userID, {Key? key}) : super(key: key);

  @override
  _FollowPageState createState() => _FollowPageState(this._userID);
}

class _FollowPageState extends State<FollowPage>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  int _userID; // which user's follow page
  _FollowPageState(this._userID);
  late Followers _followerList;
  late Followers _followingList;
  final followerWidget = <Widget>[];
  var _followPics = [];
  final followingWidget = <Widget>[];
  var _followingPics = [];
  String _username = "username";

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 2);
    fetchFollowers(_userID.toString()).then((list){
      _followerList = list[0];
      _followPics = list[1];
      initFollowerList();
      setState(() {});
    });

    fetchFollowing(_userID.toString()).then((list){
      _followingList = list[0];
      _followingPics = list[1];
      initFollowingList();
      setState(() {});
    });

    getUserData(_userID.toString()).then((userdata){
      setState(() {
        _username = userdata["username"];
      });
    });
  }

  void initFollowerList() {
    for(var i=0;i<_followerList.list.length;i++)
    {
      followerWidget.add(
        Stack(children: <Widget>[
          Container(
            height: 100,
            width: double.infinity,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
            child: CircleAvatar(
              radius: 40,
              backgroundImage: MemoryImage(_followPics[i]),
              backgroundColor: Colors.transparent,
            ),
          ),
          SizedBox(
            height: 100,
            width: double.infinity,
            child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty
                        .resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(
                                MaterialState.pressed) ||
                            states.contains(
                                MaterialState.hovered)) {
                          return const Color(0x10000000);
                        }
                        return Colors.transparent;
                      },
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfilePage(_followerList.list[i]["userId"])),
                    );
                  },
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(100, 8, 4, 8),
                    child: RichText(
                      text: TextSpan(
                        text: _followerList.list[i]['username'],
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 16.0),
                      ),
                    ),
                  ),
                )),
          ),
          // Visibility(
          //   visible: false,
          //   child: Container(
          //     height: 100,
          //     width: double.infinity,
          //     alignment: Alignment.centerRight,
          //     padding: EdgeInsets.fromLTRB(4, 8, 15, 8),
          //     child: TextButton(
          //       style: TextButton.styleFrom(
          //         textStyle: const TextStyle(fontSize: 16),
          //         fixedSize: Size.fromHeight(50),
          //       ),
          //       onPressed: () {},
          //       child: const Text('Follow'),
          //     ),
          //   ),
          // ),
          // Visibility(
          //   visible: true,
          //   child: Container(
          //     height: 100,
          //     width: double.infinity,
          //     alignment: Alignment.centerRight,
          //     padding: EdgeInsets.fromLTRB(4, 8, 15, 8),
          //     child: TextButton(
          //       style: TextButton.styleFrom(
          //         textStyle: const TextStyle(fontSize: 16),
          //         fixedSize: Size.fromHeight(50),
          //       ),
          //       onPressed: () {
          //         setState(() {});
          //       },
          //       child: Text('Unfollow',
          //           style: TextStyle(color: Colors.red)),
          //     ),
          //   ),
          // ),
        ]),
      );
    }
  }

  void initFollowingList() {
    for(var i=0;i<_followingList.list.length;i++)
    {
      followingWidget.add(
        Stack(children: <Widget>[
          Container(
            height: 100,
            width: double.infinity,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
            child: CircleAvatar(
              radius: 40,
              backgroundImage: MemoryImage(_followingPics[i]),
              backgroundColor: Colors.transparent,
            ),
          ),
          SizedBox(
            height: 100,
            width: double.infinity,
            child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty
                        .resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(
                                MaterialState.pressed) ||
                            states.contains(
                                MaterialState.hovered)) {
                          return const Color(0x10000000);
                        }
                        return Colors.transparent;
                      },
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfilePage(_followingList.list[i]["userId"])),
                    );
                  },
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(100, 8, 4, 8),
                    child: RichText(
                      text: TextSpan(
                        text: _followingList.list[i]['username'],
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 16.0),
                      ),
                    ),
                  ),
                )),
          ),
          // Visibility(
          //   visible: false,
          //   child: Container(
          //     height: 100,
          //     width: double.infinity,
          //     alignment: Alignment.centerRight,
          //     padding: EdgeInsets.fromLTRB(4, 8, 15, 8),
          //     child: TextButton(
          //       style: TextButton.styleFrom(
          //         textStyle: const TextStyle(fontSize: 16),
          //         fixedSize: Size.fromHeight(50),
          //       ),
          //       onPressed: () {},
          //       child: const Text('Follow'),
          //     ),
          //   ),
          // ),
          // Visibility(
          //   visible: true,
          //   child: Container(
          //     height: 100,
          //     width: double.infinity,
          //     alignment: Alignment.centerRight,
          //     padding: EdgeInsets.fromLTRB(4, 8, 15, 8),
          //     child: TextButton(
          //       style: TextButton.styleFrom(
          //         textStyle: const TextStyle(fontSize: 16),
          //         fixedSize: Size.fromHeight(50),
          //       ),
          //       onPressed: () {
          //         setState(() {});
          //       },
          //       child: Text('Unfollow',
          //           style: TextStyle(color: Colors.red)),
          //     ),
          //   ),
          // ),
        ]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            title: Text("Follows",
                style: TextStyle(fontSize: 20, color: Colors.white))),
        backgroundColor: const Color(0xFFFFFFFF),
        body: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            color: const Color(0xFFFFFFFF),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _username,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                color: const Color(0xFFFCF9F9),
                child: TabBar(
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      color: const Color(0xFF189AB4)),
                  controller: _controller,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  tabs: const [
                    Tab(child: Text('Following')),
                    Tab(child: Text('Followers')),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _controller,
                  children: [
                    SingleChildScrollView(
                      child: Column(children:
                        followingWidget
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(children:
                        followerWidget
                      ),
                    ),
                  ],
                ),
              ),
            ])));
  }
}
