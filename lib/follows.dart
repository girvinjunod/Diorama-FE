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
  String _username = "username";

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 2);
    getUserData(_userID.toString()).then((userdata){
      setState(() {
        _username = userdata["username"];
      });
    });
  }

  Widget initFollowerList(int i) {
    return Stack(children: <Widget>[
          Container(
            height: 100,
            width: double.infinity,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
            child: CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage("http://34.101.123.15:8080/getPPByID/${_followerList.list[i]['userId']}"),
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
        ]);
    }

  Widget initFollowingList(int i) {
      return Stack(children: <Widget>[
          Container(
            height: 100,
            width: double.infinity,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
            child: CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage("http://34.101.123.15:8080/getPPByID/${_followingList.list[i]['userId']}"),
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
        ]);
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
                    FutureBuilder<dynamic>(
                        future: fetchFollowing(_userID.toString()),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          List<Widget> children;
                          if (snapshot.hasData) {
                            _followingList = snapshot.data[0];
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: _followingList.list.length,
                                padding:
                                    const EdgeInsets.fromLTRB(0, 0, 0, 100),
                                itemBuilder: (context, int index) {
                                  return initFollowingList(index);
                                });
                          } else if (snapshot.hasError) {
                            children = <Widget>[
                              const Icon(
                                Icons.error_outline,
                                color: Colors.red,
                                size: 60,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Text('${snapshot.error}'),
                              )
                            ];

                            return Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: children,
                            ));
                          } else {
                            children = const <Widget>[
                              SizedBox(
                                width: 60,
                                height: 60,
                                child: CircularProgressIndicator(),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 16),
                                child: Text('Loading...'),
                              )
                            ];

                            return Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: children,
                            ));
                          }
                        }),
                    FutureBuilder<dynamic>(
                        future: fetchFollowers(_userID.toString()),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          List<Widget> children;
                          if (snapshot.hasData) {
                            _followerList = snapshot.data[0];
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: _followerList.list.length,
                                padding:
                                    const EdgeInsets.fromLTRB(0, 0, 0, 100),
                                itemBuilder: (context, int index) {
                                  return initFollowerList(index);
                                });
                          } else if (snapshot.hasError) {
                            children = <Widget>[
                              const Icon(
                                Icons.error_outline,
                                color: Colors.red,
                                size: 60,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Text('${snapshot.error}'),
                              )
                            ];

                            return Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: children,
                            ));
                          } else {
                            children = const <Widget>[
                              SizedBox(
                                width: 60,
                                height: 60,
                                child: CircularProgressIndicator(),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 16),
                                child: Text('Loading...'),
                              )
                            ];

                            return Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: children,
                            ));
                          }
                        }),
                  ],
                ),
              ),
            ])));
  }
}
