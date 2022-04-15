import 'package:flutter/material.dart';
import 'model/detail_event_model.dart';

class DetailEventPage extends StatefulWidget {
  final int eventID;
  const DetailEventPage(this.eventID, {Key? key}) : super(key: key);

  @override
  DetailEventPageState createState() => DetailEventPageState(this.eventID);
}

// ketika buka page ini yang dipassing adalah username pengguna, dan eventID
class DetailEventPageState extends State<DetailEventPage> {
  // Apakah event milik sendiri?
  bool _isSelfEvent = true;

  late DetailEvent _detailEvent;
  var ImgEvent = [];
  late Future<DetailEvent> futureDetailEvent;
  late Future<List> futureImgEvent;

  //ini harusnya tidak hardcode
  int eventID;
  DetailEventPageState(this.eventID);
  var username = "username";

  @override
  void initState() {
    super.initState();
    futureDetailEvent = getDetailEvent(eventID);
    futureImgEvent = getEventPicture(eventID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(username + "'s Event",
                style: TextStyle(fontSize: 20, color: Colors.white))),
        backgroundColor: const Color(0xFFF1F1F1),
        body: Center(
          child: ListView(shrinkWrap: true, children: <Widget>[
            // untuk gambar
            Container(
              child: FutureBuilder(
                  future: futureImgEvent,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
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
                      return Container(
                          child: Center(child: Text('${snapshot.error}')));
                    }
                    return const CircularProgressIndicator();
                  }),
            ),

            // untuk detail
            Container(
              child: FutureBuilder(
                  future: futureDetailEvent,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
                              child: Text(snapshot.data!.Caption,
                                  style: TextStyle(fontSize: 15))),
                          Padding(
                              padding: EdgeInsets.fromLTRB(20, 5, 10, 5),
                              child: Text("Date : " + snapshot.data!.EventDate,
                                  style: TextStyle(fontSize: 15))),
                          Padding(
                              padding: EdgeInsets.fromLTRB(20, 5, 10, 5),
                              child: Text(snapshot.data!.PostTime,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black.withOpacity(0.6)))),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Container(
                          child: Center(child: Text('${snapshot.error}')));
                    }

                    return const CircularProgressIndicator();
                  }),
            ),
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
                      onPressed: () {},
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
                        onPressed: () {},
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
