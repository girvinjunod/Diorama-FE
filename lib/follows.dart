import 'package:diorama_id/main.dart';
import 'package:flutter/material.dart';

class FollowPage extends StatefulWidget {
  const FollowPage({Key? key}) : super(key: key);

  @override
  _FollowPageState createState() => _FollowPageState();
}

class _FollowPageState extends State<FollowPage> {
  bool _isFollowing = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: ListView(shrinkWrap: true, children: <Widget>[
        Container(
            color: const Color(0xFFFFFFFF),
            child: Column(children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'username_user',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(0),
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Container(
                              decoration: const BoxDecoration(
                                color: const Color(0xFF189AB4),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0.0),
                                      side: BorderSide(color: Colors.transparent))),
                                  padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.fromLTRB(16, 22, 16, 22)),
                                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                                    
                                    (Set<MaterialState> states) {
                                      if (_isFollowing)
                                      {
                                        if (states.contains(MaterialState.pressed) ||
                                            states.contains(MaterialState.hovered))
                                          return const Color(0xFF05445E);
                                        return const Color(
                                            0xFF189AB4); // Use the component's default.
                                      }
                                      else
                                      {
                                        if (states.contains(MaterialState.pressed) ||
                                            states.contains(MaterialState.hovered))
                                          return const Color(0xFFDEDEDE);
                                        return const Color(
                                            0xFFFCF9F9); // Use the component's default.
                                      }
                                    }
                                   ),
                                  ),
                                onPressed: () {
                                  setState(() {
                                    _isFollowing = true;
                                  });
                                },
                                child: Text('Following', textAlign: TextAlign.center,
                                style: _isFollowing?
                                  TextStyle(fontSize: 14.0, color:const Color(0xFFFFFFFF)):
                                  TextStyle(fontSize: 14.0, color:const Color(0xFF000000)),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(0),
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Container(
                              decoration: const BoxDecoration(
                                color: const Color(0xFF189AB4),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0.0),
                                      side: BorderSide(color: Colors.transparent))),
                                  padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.fromLTRB(16, 22, 16, 22)),
                                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                                    
                                    (Set<MaterialState> states) {
                                      if (_isFollowing)
                                      {
                                        if (states.contains(MaterialState.pressed) ||
                                            states.contains(MaterialState.hovered))
                                          return const Color(0xFFDEDEDE);
                                        return const Color(
                                            0xFFFCF9F9); // Use the component's default.
                                      }
                                      else
                                      {
                                        if (states.contains(MaterialState.pressed) ||
                                            states.contains(MaterialState.hovered))
                                          return const Color(0xFF05445E);
                                        return const Color(
                                            0xFF189AB4); // Use the component's default.
                                      }
                                    },
                                   ),
                                  ),
                                onPressed: () {
                                  setState(() {
                                    _isFollowing = false;
                                  });
                                },
                                child: Text('Followers', textAlign: TextAlign.center,
                                style: _isFollowing?
                                  TextStyle(fontSize: 14.0, color:const Color(0xFF000000)):
                                  TextStyle(fontSize: 14.0, color:const Color(0xFFFFFFFF)),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Visibility(
                // Following column
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
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed) ||
                                      states.contains(MaterialState.hovered))
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
                visible: _isFollowing,
              ),

              Visibility(
                // Followers column
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
                    Visibility(
                      visible: true,
                      child: Container(
                      height: 100,
                      width: double.infinity,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.fromLTRB(4, 8, 15, 8),
                      child: RichText(
                        text: TextSpan(
                          text: 'unfollowed',
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.grey,
                              fontSize: 16.0),
                          ),
                        ),
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
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed) ||
                                      states.contains(MaterialState.hovered))
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
                  ]),
                ]),
                visible: !_isFollowing,
              ),
            ]))
      ]),
    );
  }
}
