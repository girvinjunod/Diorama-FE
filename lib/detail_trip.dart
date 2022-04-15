import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'detail_event.dart';
import 'model/detail_trip_model.dart';
import 'model/detail_event_model.dart';

class DetailTripPage extends StatefulWidget {
  const DetailTripPage({Key? key}) : super(key: key);

  @override
  DetailTripPageState createState() => DetailTripPageState();
}

// ketika buka page ini yang dipassing adalah username pengguna dan tripID
class DetailTripPageState extends State<DetailTripPage> {
  // Apakah event milik sendiri?
  bool _isSelfTrip = true;

  late Future<DetailTrip> futureDetailTrip;
  late Future<List> futureEvents;

  // harusnya tidak hardcode
  int tripID = 1;
  var username = "username";

  @override
  void initState() {
    super.initState();
    futureDetailTrip = getDetailTrip(tripID);
    futureEvents = getAllEvent(tripID);
  }

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
                              style: TextStyle(fontSize: 18)),
                          padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                          alignment: Alignment.center,
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(20, 15, 20, 10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                      "Location   : " +
                                          snapshot.data!.LocationName,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15)),
                                  Text(
                                      "Start Date : " +
                                          snapshot.data!.StartDate,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15)),
                                  Text("End Date   : " + snapshot.data!.EndDate,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15))
                                ]))
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Container(
                        child: Center(child: Text('${snapshot.error}')));
                  }
                  return const CircularProgressIndicator();
                }),
            Padding(
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
                                            snapshot.data![0].EventID[i])),
                                  );
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
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) => const EditProfilePage()),
                                      // );
                                    },
                                    child: const Text('+ Event'),
                                  )),
                            ),
                            visible: _isSelfTrip,
                          ),
                        ]));
                  } else if (snapshot.hasError) {
                    return Container(
                        child: Center(child: Text('${snapshot.error}')));
                  }
                  return const CircularProgressIndicator();
                }),
            // button delete
            Visibility(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 40, 40),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.red.shade900)),
                      onPressed: () {},
                      child: const Text('Delete Trip'),
                    )),
              ),
              visible: _isSelfTrip,
            ),
          ],
        ));
  }
}
