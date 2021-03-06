import 'package:diorama_id/profile.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'model/commentAPI.dart';
class CommentDetail extends StatefulWidget {
  final int _eventID;
  const CommentDetail(this._eventID, {Key? key}) : super(key: key);


  @override
  _CommentDetailState createState() => _CommentDetailState(this._eventID);
}

class _CommentDetailState extends State<CommentDetail> {
  final _userID = Holder.userID;
  final int _eventID;
  _CommentDetailState(this._eventID);
  late Comments _commentsList;
  final commentsWidget = <Widget>[];
  String text_comments = "";
  String message = "";
  final _formKey = GlobalKey<FormState>();
  var a = "1";
  var current_uname = "";
  var current_pp = "";
  int sum_comments = 0;
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getComments(_userID.toString(), _eventID.toString()).then((list) {
      _commentsList = list;
      sum_comments = _commentsList.list.length;
      setState(() {});
    });
    getUserData(_userID.toString()).then((userdata) {
      setState(() {
        a = "GETUSER";
      });
    });
  }

  Widget initCommentsList(int i) {
        return Stack(
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              child: Column(
                children: <Widget>[
                Padding(padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child:
                SizedBox( 
                  height: 50,
                  width: double.infinity,
                  child: Row(children: <Widget>[
                    Container(
                      height: 50,
                      width: 50,
                      alignment: Alignment.centerLeft,
                      child: InkWell(child:
                      CircleAvatar(
                        radius: 20, // Image radius
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(
                        "http://34.101.123.15:8080/getPPByID/${_commentsList.list[i]["userID"]}"),
                        ),
                        onTap: (){
                        Navigator.push(
                        context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage(_commentsList.list[i]["userID"])),
                          );
                        },
                      ),
                    ),
                    Expanded(child: InkWell(
                      child: 
                        RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            text: _commentsList.list[i]['username'],
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0),
                          ),
                        ),
                        onTap: (){
                        Navigator.push(
                        context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage(_commentsList.list[i]["userID"])),
                          );
                        },
                      ),
                    ),
                    Visibility(child:
                      TextButton(
                        style: TextButton.styleFrom(
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          primary: Colors.white,
                          backgroundColor: const Color.fromARGB(255, 148, 3, 3),
                        ),
                        onPressed: () {
                          deleteComment(_commentsList.list[i]['id'])
                            .then((response) {
                          if (response == "SUCCESS") {
                            getComments(_userID, _eventID.toString())
                                .then((list) {
                              _commentsList = list;
                              sum_comments = _commentsList.list.length;
                              setState(() {});
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Comment deleted')),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Error: unable to delete comment')),
                            );
                          }
                          });
                          
                        },
                        child: const Text('Delete'),
                      ),
                      visible: int.parse(Holder.userID) == _commentsList.list[i]["userID"]
                    )
                  ]),
                ),),
                Row(children:<Widget> [
                  Expanded(child:
                    Container(
                    height: 50,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(20, 8, 4, 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                          text: _commentsList.list[i]['text'],
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 100,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: RichText(
                      textAlign: TextAlign.right,
                      text: TextSpan(
                        text: _commentsList.list[i]['commentTime'],
                        style: const TextStyle(
                            color: Color.fromARGB(255, 104, 103, 103),
                            fontWeight: FontWeight.w400,
                            fontSize: 10.0),
                      ),
                    ),
                  ),
                  )])
              ]),
            ),
          ],
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            title: const Text("Comment Detail",
                style: TextStyle(fontSize: 20, color: Colors.white))),
        backgroundColor: const Color(0xFFF1F1F1),
        body: 
            Stack(children: [
              FutureBuilder<dynamic>(
                      future: getComments(_userID, _eventID.toString()),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        List<Widget> children;
                        if (snapshot.hasData && sum_comments > 0) {
                          _commentsList = snapshot.data;
                          return ListView.builder(
                                shrinkWrap: true,
                                itemCount: _commentsList.list.length,
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
                                itemBuilder: (context, int index) {
                                  return initCommentsList(index);
                                });
                        } else if (snapshot.hasError || sum_comments == 0) {
                          children = <Widget>[
                            Image.asset("images/notfound.png"),
                            const Padding(
                              padding: EdgeInsets.only(top: 16),
                              child: Text('No comments available'),
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
                  Container(
                  height: double.infinity,
                  alignment: Alignment.bottomCenter,
                  child: Container(
                  height: 100,
                  color: Colors.white, 
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                  child: Form(
                      key: _formKey,
                      child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: <Widget>[
                              CircleAvatar(
                                radius: 20, // Image radius
                                backgroundImage: NetworkImage(
                                    "http://34.101.123.15:8080/getPPByID/$_userID"),
                                backgroundColor: Colors.transparent,
                              ),
                              Expanded(
                                  child: TextField(
                                controller: myController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Add comment...',
                                  contentPadding: EdgeInsets.only(left: 10),
                                ),
                                onChanged: (value) => setState(() {
                                  text_comments = value.toString();
                                }),
                              )),
                              TextButton(
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10.0),
                                    primary:
                                        const Color.fromARGB(255, 5, 68, 94),
                                  ),
                                  child: const Text('Send'),
                                  onPressed: () {
                                    if (text_comments.isNotEmpty) {
                                      addComment(int.parse(_userID), _eventID,
                                              text_comments)
                                          .then((response) {
                                        if (response == "SUCCESS") {
                                          message =
                                              "Comment added successfully";
                                          text_comments = "";
                                          myController.text = "";
                                          getComments(
                                                  _userID, _eventID.toString())
                                              .then((list) {
                                            _commentsList = list;
                                            sum_comments =
                                                _commentsList.list.length;
                                            //initCommentsList();
                                            setState(() {});
                                          });
                                        } else {
                                          message =
                                              "Error occurred. Cannot add your comment.";
                                        }
                                        final snackBar = SnackBar(
                                          content: Text(
                                            message,
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      });
                                    }
                                  })
                            ],
                          )))))
            ])
            );
  }
}
