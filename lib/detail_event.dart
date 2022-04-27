import 'package:diorama_id/comment.dart';
import 'package:diorama_id/main.dart';
import 'package:flutter/material.dart';
import 'model/detail_event_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'detail_trip.dart';
import 'model/follows_model.dart';

class DetailEventPage extends StatefulWidget {
  final int eventID;
  final int tripID;
  final int userID;
  const DetailEventPage(this.eventID, this.tripID, this.userID, {Key? key})
      : super(key: key);

  @override
  DetailEventPageState createState() =>
      DetailEventPageState(this.eventID, this.tripID, this.userID);
}

// ketika buka page ini yang dipassing adalah username pengguna, dan eventID
class DetailEventPageState extends State<DetailEventPage> {
  // Apakah event milik sendiri?
  bool _isSelfEvent = false;
  var ImgEvent = [];
  late Future<DetailEvent> futureDetailEvent;
  late Future<List> futureImgEvent;

  //ini harusnya tidak hardcode
  int eventID;
  int tripID;
  int userID;
  DetailEventPageState(this.eventID, this.tripID, this.userID);
  var username = "username";

  @override
  void initState() {
    super.initState();
    futureDetailEvent = getDetailEvent(eventID);
    futureImgEvent = getEventPicture(eventID);
    getUserData(userID.toString()).then((result) {
      username = result["username"];
      setState(() {});
    });
    _isSelfEvent = Holder.userID == userID.toString();
  }

  void deleteEventDialog(int id) {
    // set up the buttons
    Widget noButton = TextButton(
      child: const Text("NO"),
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          backgroundColor:
              MaterialStateProperty.all<Color>(Colors.red.shade900)),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget yesButton = TextButton(
      child: const Text("YES"),
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          backgroundColor:
              MaterialStateProperty.all<Color>(Colors.cyan.shade900)),
      onPressed: () {
        deleteEvent(id);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailTripPage(tripID, userID)),
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Delete Event"),
      content: const Text("Would you like to delete this event?"),
      actions: [
        noButton,
        yesButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void dialog(String msg) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Success"),
      content: Text(msg),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void deleteEvent(int eventID) async {
    var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${Holder.token}',
    };

    final http.Response response = await http
        .delete(Uri.parse('http://34.101.123.15:8080/deleteEvent/$eventID'), headers: header);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      var message = data["msg"];
      dialog(message);
    } else {
      throw Exception('Failed to delete event.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(username + "'s Event",
                style: const TextStyle(fontSize: 20, color: Colors.white))),
        backgroundColor: const Color(0xFFFFFFFF),
        body: Center(
          child: ListView(shrinkWrap: true, children: <Widget>[
            // untuk gambar
            FutureBuilder(
                future: futureImgEvent,
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator());
                  } else {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 350,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: MemoryImage(snapshot.data![0]),
                                      ),
                                    ),
                                  )
                                ]),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text('${snapshot.error}'));
                    }
                  }
                  return const Text("Event load error");
                }),

            // untuk detail
            FutureBuilder(
                future: futureDetailEvent,
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
                            child: Text(snapshot.data!.Caption,
                                style: const TextStyle(fontSize: 15))),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(20, 5, 10, 5),
                            child: Text("Date : " + snapshot.data!.EventDate,
                                style: const TextStyle(fontSize: 15))),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(20, 5, 10, 5),
                            child: Text(snapshot.data!.PostTime,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black.withOpacity(0.6)))),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('${snapshot.error}'));
                  }

                  return const Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator());
                }),
            Row(children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 40, 0, 40),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.cyan.shade900)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CommentDetail(eventID)
                          )
                        );
                      },
                      child: const Text('Comment'),
                    )),
              ),
              // button delete
              Visibility(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.red.shade900)),
                        onPressed: () {
                          deleteEventDialog(eventID);
                        },
                        child: const Text('Delete Event'),
                      )),
                ),
                visible: _isSelfEvent,
              ),
            ])
          ]),
        ));
  }
}
