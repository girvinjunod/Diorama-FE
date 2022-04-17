import 'package:flutter/material.dart';

import 'model/commentAPI.dart';

class CommentDetail extends StatefulWidget {
  const CommentDetail({Key? key}) : super(key: key);

  @override
  _CommentDetailState createState() => _CommentDetailState();
}

class _CommentDetailState extends State<CommentDetail> {
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  final int _userID = 1; // which user's current user page
  final int _eventID = 1;
  late Comments _commentsList;
  final commentsWidget = <Widget>[];
  var _userPics = [];
  String _username = "username";
  String text_comments;
  String message ="";

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 2);
    getComments(_userID.toString(), _eventID.toString()).then((list){
    _commentsList = list[0];
    _userPics = list[1];
    initCommentsList();
    setState(() {});
    });

    getUserData(_userID.toString()).then((userdata){
    setState(() {
    _username = userdata["username"];
    });
    });
  }

    void initCommentsList() {
      for(var i=0;i<_commentsList.list.length;i++)
      {
        commentsWidget.add(
          Stack(children: <Widget>[
          Sizebox(
            width: double.infinity;
            child: Column(
              Sizebox (
                width: double.infinity;
                child: Row(
                  Container(
                    height: 100,
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                    child: CircleAvatar(
                      radius: 40,
                        backgroundImage: MemoryImage(_userPics[i]),
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
                        onPressed: () {},
                        child: Container(
                          height: 100,
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.fromLTRB(100, 8, 4, 8),
                          child: RichText(
                            text: TextSpan(
                            text: _commentsList.list[i]['username'],
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 16.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 100,
                width: double.infinity,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.fromLTRB(100, 8, 4, 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(
                      text: _commentsList.list[i]['text'],
                      style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.0),
                    ),
                  ),
                ),
              )
            ]
          ),
        );
      }
    }



    @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      body: Column(
        children: <Widget> [
          SingleChildScrollView(
            child: Column(children:
              commentsWidget
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(15, 0, 0, 20),
            child: SizedBox(
              width: double.infinity,
              child: Row(
                  children: <Widget>[
                  CircleAvatar(
                    radius: 20, // Image radius
                    backgroundImage: AssetImage('images/pp-temp.jpg'),
                  ),
                  SizedBox(
                      //padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    width: 200,
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Add comment...',
                        contentPadding: EdgeInsets.only(left: 10),
                      ),
                    onSaved: (value) => setState(() {
                      text_comments = value.toString();
                      response = addComment(_userID, _eventID, text_comments);
                      if (response == "SUCCESS") {
                        message = "Comment added successfully";
                      } else {
                        message = "Error occurred. Cannot add your comment.";
                      }
                    final snackBar = SnackBar(
                      content: Text(
                        message,
                        style: TextStyle(fontSize: 20),
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }),
                    )
                  ),
                ],
              )
            )
          )
        ]
      )
    );
    }
}