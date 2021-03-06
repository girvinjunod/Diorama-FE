import 'dart:async';

import 'package:diorama_id/add_event.dart';
import 'package:diorama_id/main.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'detail_event.dart';
import 'model/detail_trip_model.dart';
import 'package:http/http.dart' as http;
import 'model/follows_model.dart';

class DetailTripPage extends StatefulWidget {
  final int tripID;
  final int userID;
  const DetailTripPage(this.tripID, this.userID, {Key? key}) : super(key: key);

  @override
  DetailTripPageState createState() =>
      DetailTripPageState(this.tripID, this.userID);
}

// ketika buka page ini yang dipassing adalah username pengguna dan tripID
class DetailTripPageState extends State<DetailTripPage> {
  // Apakah event milik sendiri?
  bool _isSelfTrip = false;

  late Future<DetailTrip> futureDetailTrip;
  late Future<List> futureEvents;

  // harusnya tidak hardcode
  int tripID;
  int userID;
  DetailTripPageState(this.tripID, this.userID);
  var username = "username";

  @override
  void initState() {
    super.initState();
    futureDetailTrip = getDetailTrip(tripID);
    futureEvents = getAllEvent(tripID);
    getUserData(userID.toString()).then((result) {
      username = result["username"];
      setState(() {});
    });
    _isSelfTrip = Holder.userID == userID.toString();
  }

  void deleteTripDialog(int id) {
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
        deleteTrip(id);
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Delete Trip"),
      content: const Text("Would you like to delete this trip?"),
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

  void deleteTrip(int tripID) async {
    var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${Holder.token}',
    };

    final http.Response response = await http
        .delete(Uri.parse('http://34.101.123.15:8080/deleteTrip/$tripID'), headers: header);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      var message = data["msg"];
      dialog(message);
    } else {
      throw Exception('Failed to delete trip.');
    }
  }

  FutureOr onGoBack(dynamic value) {
    futureDetailTrip = getDetailTrip(tripID);
    futureEvents = getAllEvent(tripID);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(username + "'s Trip",
                style: const TextStyle(fontSize: 20, color: Colors.white))),
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FutureBuilder(
                future: futureDetailTrip,
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(snapshot.data!.TripName,
                              style: const TextStyle(fontSize: 18)),
                          padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                          alignment: Alignment.center,
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                      "Location   : " +
                                          snapshot.data!.LocationName,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 15)),
                                  Text(
                                      "Start Date : " +
                                          snapshot.data!.StartDate,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 15)),
                                  Text("End Date   : " + snapshot.data!.EndDate,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 15))
                                ]))
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('${snapshot.error}'));
                  }
                  return const Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator());
                }),
            const Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Text("Event", style: TextStyle(fontSize: 18))),
            FutureBuilder(
                future: futureEvents,
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Flexible(
                        child: GridView.count(
                            controller: ScrollController(),
                            crossAxisCount: 3,
                            children: <Widget>[
                          for (int i = 0;
                              i < snapshot.data![0].EventID.length;
                              i++)
                            Material(
                              color: Colors.white,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailEventPage(
                                            snapshot.data![0].EventID[i],
                                            tripID,
                                            userID)),
                                  ).then(onGoBack);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: MemoryImage(snapshot.data![1][i]),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          Visibility(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: TextButton(
                                    style: ButtonStyle(
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.cyan.shade900)),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddEventPage(tripID)),
                                      ).then(onGoBack);
                                    },
                                    child: const Text('+ Event'),
                                  )),
                            ),
                            visible: _isSelfTrip,
                          ),
                        ]));
                  } else if (snapshot.hasError) {
                    return Column(
                        children: <Widget>[
                          const Center(child: Text('No Event Yet')),
                          Visibility(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: TextButton(
                                    style: ButtonStyle(
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.cyan.shade900)),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AddEventPage(tripID)),
                                      ).then(onGoBack);
                                    },
                                    child: const Text('+ Event'),
                                  )),
                            ),
                            visible: _isSelfTrip,
                          ),
                          ]
                        );
                  }
                  return const Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator());
                }),
            // button delete
            Visibility(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 40, 40),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.red.shade900)),
                      onPressed: () {
                        deleteTripDialog(tripID);
                      },
                      child: const Text('Delete Trip'),
                    )),
              ),
              visible: _isSelfTrip,
            ),
          ],
        ));
  }
}
