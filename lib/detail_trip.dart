import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class DetailTripPage extends StatefulWidget {
  const DetailTripPage({Key? key}) : super(key: key);

  @override
  DetailTripPageState createState() => DetailTripPageState();
}

class DetailTripPageState extends State<DetailTripPage> {
  // ketika buka page ini yang dipassing adalah username pengguna dan tripID
  var username = "username";
  var TripTitle = "Bandung Trip";
  var TripLocation = "Bandung";
  var StartDate = "DD-MM-YYYY";
  var EndDate = "DD-MM-YYYY";
  var nPost = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(username + "'s Trip",
                style: TextStyle(fontSize: 20, color: Colors.white))),
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Text(TripTitle, style: TextStyle(fontSize: 18)),
              padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
              alignment: Alignment.center,
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(20, 15, 20, 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // RichText(
                      //   text: TextSpan(
                      //     style: DefaultTextStyle.of(context).style,
                      //     children: <TextSpan>[
                      //       TextSpan(
                      //         text: "Trip : ",
                      //         style:
                      //             TextStyle(color: Colors.black, fontSize: 15),
                      //       ),
                      //       TextSpan(
                      //         text: TripTitle + "\n",
                      //         style: TextStyle(
                      //             color: Colors.white,
                      //             fontSize: 15,
                      //             backgroundColor: Colors.blue),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Text("Location   : " + TripLocation,
                          style: TextStyle(color: Colors.black, fontSize: 15)),
                      Text("Start Date : " + StartDate,
                          style: TextStyle(color: Colors.black, fontSize: 15)),
                      Text("End Date   : " + EndDate,
                          style: TextStyle(color: Colors.black, fontSize: 15))
                    ])),
            Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Text("Event", style: TextStyle(fontSize: 18))),
            Flexible(
                child: GridView.count(
                    controller: ScrollController(),
                    crossAxisCount: 3,
                    children: <Widget>[
                  for (int i = 0; i < nPost; i++)
                    Material(
                      color: Colors.white,
                      child: InkWell(
                        onTap: () {
                          print('clicked');
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          child: Image.asset("images/car.png"),
                        ),
                      ),
                    ),
                ]))
          ],
        ));
  }
}
