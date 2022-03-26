import 'package:diorama_id/main.dart';
import 'package:flutter/material.dart';

class FollowPage extends StatefulWidget {
  const FollowPage({Key? key}) : super(key: key);

  @override
  _FollowPageState createState() => _FollowPageState();
}

class _FollowPageState extends State<FollowPage>
    with SingleTickerProviderStateMixin {
  bool _isFollowing = true;
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        body: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            color: const Color(0xFFFFFFFF),
            child: Column(children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'username_user',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
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
                  tabs: [
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
                      child: Column(children: <Widget>[
                        Stack(children: <Widget>[
                          Container(
                            height: 100,
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(
                                  'https://avatars.githubusercontent.com/u/57818885?v=4'),
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                          Container(
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
                                                MaterialState.hovered))
                                          return const Color(0x10000000);
                                        return Colors.transparent;
                                      },
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Container(
                                    height: 100,
                                    width: double.infinity,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.fromLTRB(100, 8, 4, 8),
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'friend1',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16.0),
                                      ),
                                    ),
                                  ),
                                )),
                          ),
                        ]),
                      ]),
                    ),
                    SingleChildScrollView(
                      child: Column(children: <Widget>[
                        Stack(children: <Widget>[
                          Container(
                            height: 100,
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(
                                  'https://avatars.githubusercontent.com/u/57818885?v=4'),
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                          Container(
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
                                                MaterialState.hovered))
                                          return const Color(0x10000000);
                                        return Colors.transparent;
                                      },
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Container(
                                    height: 100,
                                    width: double.infinity,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.fromLTRB(100, 8, 4, 8),
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'friend2',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16.0),
                                      ),
                                    ),
                                  ),
                                )),
                          ),
                          Visibility(
                            visible: false,
                            child: Container(
                              height: 100,
                              width: double.infinity,
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.fromLTRB(4, 8, 15, 8),
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  textStyle: const TextStyle(fontSize: 16),
                                  fixedSize: Size.fromHeight(50),
                                ),
                                onPressed: () {},
                                child: const Text('Follow'),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: true,
                            child: Container(
                              height: 100,
                              width: double.infinity,
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.fromLTRB(4, 8, 15, 8),
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  textStyle: const TextStyle(fontSize: 16),
                                  fixedSize: Size.fromHeight(50),
                                ),
                                onPressed: () {
                                  setState(() {});
                                },
                                child: Text('Unfollow',
                                    style: TextStyle(color: Colors.red)),
                              ),
                            ),
                          ),
                        ]),
                      ]),
                    ),
                  ],
                ),
              ),
            ])));
  }
}
