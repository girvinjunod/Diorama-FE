import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'model/detail_event_model.dart';

class DetailEventPage extends StatefulWidget {
  const DetailEventPage({Key? key}) : super(key: key);

  @override
  DetailEventPageState createState() => DetailEventPageState();
}

class DetailEventPageState extends State<DetailEventPage> {
  // ketika buka page ini yang dipassing adalah username pengguna dan eventID
  var username = "username";
  var eventImg = "images/car.png";
  var eventCap = "caption";
  var eventDate = "Date";
  var postDate = "DD-MM-YYYY";
  late Future<DetailEvent> futureDetailEvent;
  int eventID = 3;

  // @override
  // void initState() {
  //   super.initState();
  //   futureDetailEvent = getDetailEvent(eventID);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(username + "'s Event",
                style: TextStyle(fontSize: 20, color: Colors.white))),
        backgroundColor: const Color(0xFFF1F1F1),
        body: Center(
          child: ListView(shrinkWrap: true, children: <Widget>[
            // Container(
            //     child: Text(username, style: TextStyle(fontSize: 18)),
            //     padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
            //     alignment: Alignment.center,
            //     decoration: BoxDecoration(color: Colors.white)),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Text(eventTitle + "\n", style: TextStyle(fontSize: 18)),
                    SizedBox(
                      height: 350,
                      width: double.infinity,
                      child: FittedBox(
                        clipBehavior: Clip.hardEdge,
                        fit: BoxFit.cover,
                        child: Image.asset(eventImg),
                      ),
                    ),
                  ]),
            ),
            // Container(
            //   child: FutureBuilder(
            //       future: futureDetailEvent,
            //       builder: (context, AsyncSnapshot snapshot) {
            //         if (snapshot.hasData) {
            //           return Column(
            //             children: [
            //               Padding(
            //                   padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
            //                   child: Text(snapshot.data!.Caption,
            //                       style: TextStyle(fontSize: 15))),
            //               Padding(
            //                   padding: EdgeInsets.fromLTRB(20, 5, 10, 5),
            //                   child: Text("Date : " + snapshot.data!.EventDate,
            //                       style: TextStyle(fontSize: 15))),
            //               Padding(
            //                   padding: EdgeInsets.fromLTRB(20, 5, 10, 5),
            //                   child: Text(snapshot.data!.PostTime,
            //                       style: TextStyle(
            //                           fontSize: 15,
            //                           color: Colors.black.withOpacity(0.6)))),
            //             ],
            //           );
            //         } else if (snapshot.hasError) {
            //           return Container(
            //               child: Center(child: Text('${snapshot.error}')));
            //         } else {
            //           // null
            //           return Container(
            //             child: Center(child: CircularProgressIndicator()),
            //           );
            //         }
            //       }),
            // ),
            Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
                child: Text(eventCap, style: TextStyle(fontSize: 15))),
            Padding(
                padding: EdgeInsets.fromLTRB(20, 5, 10, 10),
                child: Text("Date     : " + eventDate,
                    style: TextStyle(fontSize: 15))),
            Padding(
                padding: EdgeInsets.fromLTRB(20, 5, 10, 5),
                child: Text(postDate,
                    style: TextStyle(
                        fontSize: 13, color: Colors.black.withOpacity(0.6)))),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 0, 40),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.cyan.shade900)),
                    onPressed: () {},
                    child: const Text('Comment'),
                  )),
            )
            // Padding(
            //   padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            //   child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       children: [
            //         RichText(
            //           text: TextSpan(
            //             style: DefaultTextStyle.of(context).style,
            //             children: <TextSpan>[
            //               TextSpan(
            //                 text: eventCap + "\n",
            //                 style: TextStyle(color: Colors.black),
            //               ),
            //               TextSpan(
            //                 text: eventLoc + "\n",
            //                 style: TextStyle(color: Colors.black),
            //               ),
            //               TextSpan(
            //                 text: eventDate + "\n",
            //                 style: TextStyle(color: Colors.black),
            //               ),
            //             ],
            //           ),
            //         )
            //       ]),
            // )
          ]),
        ));
  }
}
