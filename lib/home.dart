import 'package:diorama_id/comment.dart';
import 'package:diorama_id/detail_event.dart';
import 'package:diorama_id/main.dart';
import 'package:diorama_id/profile.dart';
import 'package:flutter/material.dart';
import 'detail_trip.dart';
import 'model/home.dart';

class TripFeed extends StatefulWidget {
  const TripFeed({Key? key}) : super(key: key);

  @override
  _TripFeedState createState() => _TripFeedState();
}

class _TripFeedState extends State<TripFeed>
    with SingleTickerProviderStateMixin {
  int _userID = int.parse(Holder.userID);
  Timeline timeline = Timeline(list: []);
  final timelineeWidget = <Widget>[];
  String _username = "username";

  @override
  void initState() {
    super.initState();
    asyncInitState();
  }

  void asyncInitState() async {
    await getUserData(_userID.toString()).then((value) {
      setState(() {
        _username = value["username"];
      });
    });
    await getTimeline(_userID.toString()).then((value) {
      timeline = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF1F1F1),
        body: timeline.list.isEmpty ? const Center(child: Text('Follow other users to see your timeline')) : ListView.builder(
      shrinkWrap: true,
      itemCount: timeline.list.length,
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
      itemBuilder: (context, int index) {
        return _buildRow(index);
      },
    ));
  }

  Widget _buildRow(int index) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Column(
        children: <Widget>[
          Container(
            constraints: const BoxConstraints(maxWidth: 1080),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: SizedBox(
                width: double.infinity,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfilePage(timeline.list[index]["userID"])),
                    );
                  },
                  child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 20, // Image radius
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(
                          "http://34.101.123.15:8080/getPPByID/${timeline.list[index]["userID"]}"),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(timeline.list[index]["username"]),
                    )
                  ],
                )
                )),
          ),
          Container(constraints: const BoxConstraints(maxWidth: 1080), child:
          SizedBox(
            height: 500,
            width: double.infinity,
            child: FittedBox(
              clipBehavior: Clip.hardEdge,
              fit: BoxFit.cover,
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailEventPage(timeline.list[index]["eventID"], timeline.list[index]["tripID"], timeline.list[index]["userID"])),
                    );
                  },
                  child: Image.network(
                "http://34.101.123.15:8080/getEventPictureByID/${timeline.list[index]["eventID"]}",
                fit: BoxFit.cover,
              )),
            ),
          )),
          Container(constraints: const BoxConstraints(maxWidth: 1080),child:
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("${timeline.list[index]["caption"]}"),
            ),
          )),
          Container(constraints: const BoxConstraints(maxWidth: 1080),child:
          Padding(padding: const EdgeInsets.fromLTRB(20, 0, 20, 20), child:
          Align(
              alignment: Alignment.centerLeft,
              child: 
                Row(
                  children: [
                    const Padding(padding: EdgeInsets.fromLTRB(0,0,10,0), child: Text('Trip: ',
                        style: TextStyle(color: Colors.black))),
                    TextButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(const Color(0xFF9DE2E2))
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailTripPage(timeline.list[index]["tripID"], timeline.list[index]["userID"])
                            )
                          );
                        },
                        child: Text('${timeline.list[index]["tripname"]}',
                        style: const TextStyle(
                          color: Colors.black,
                        ))),
                        ]
                      ),
                    )),
          ),
          Container(constraints: const BoxConstraints(maxWidth: 1080),child:
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
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
                          builder: (context) => CommentDetail(timeline.list[index]["eventID"])
                      )
                    );
                  },
                  child: const Text('Comment'),
                )),
          ))
        ],
      ),
    );
  }
}
