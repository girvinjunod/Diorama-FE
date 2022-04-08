import 'package:flutter/material.dart';

class CommentDetail extends StatefulWidget {
  const CommentDetail({Key? key}) : super(key: key);

  @override
  _CommentDetailState createState() => _CommentDetailState();
}

class _CommentDetailState extends State<CommentDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      body: Column(
        children: <Widget> [
          ListView.builder(
            shrinkWrap: true,
            itemCount: 5,
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            itemBuilder: (context, i) {
              return _buildRow();
            },
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(15, 0, 0, 20),
            child: SizedBox(
                width: double.infinity,
              child: Row(
                  children: const <Widget>[
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
                      )
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

  Widget _buildRow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 20),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: SizedBox(
                width: double.infinity,
                child: Row(
                  children: const <Widget>[
                    CircleAvatar(
                      radius: 20, // Image radius
                      backgroundImage: AssetImage('images/pp-temp.jpg'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text("username"),
                    )
                  ],
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text("comment"),
            ),
          )
        ],
      ),
    );
  }
}