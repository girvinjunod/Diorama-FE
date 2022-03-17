import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class DetailEventPage extends StatefulWidget {
  const DetailEventPage({Key? key}) : super(key: key);

  @override
  DetailEventPageState createState() => DetailEventPageState();
}

class DetailEventPageState extends State<DetailEventPage> {
  var username = "username";
  var eventTitle = "title";
  var eventImg = "images/car.png";
  var eventCap = "caption";
  var eventLoc = "Location";
  var eventDate = "Date";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF1F1F1),
        body: Center(
          child: ListView(shrinkWrap: true, children: <Widget>[
            Container(
                child: Text(username, style: TextStyle(fontSize: 18)),
                padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Colors.white)),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(eventTitle + "\n", style: TextStyle(fontSize: 18)),
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
            Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
                child: Text(eventCap, style: TextStyle(fontSize: 15))),
            Padding(
                padding: EdgeInsets.fromLTRB(20, 5, 10, 5),
                child: Text("Location : " + eventLoc,
                    style: TextStyle(fontSize: 15))),
            Padding(
                padding: EdgeInsets.fromLTRB(20, 5, 10, 40),
                child: Text("Date     : " + eventDate,
                    style: TextStyle(fontSize: 15))),
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
