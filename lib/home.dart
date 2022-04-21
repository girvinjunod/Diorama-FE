import 'package:diorama_id/comment.dart';
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
    return timeline.list.isEmpty ? const Center(child: Text('Follow other users to see your timeline')) :ListView.builder(
      shrinkWrap: true,
      itemCount: timeline.list.length,
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
      itemBuilder: (context, int index) {
        return _buildRow(index);
      },
    );
  }

  Widget _buildRow(int index) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Column(
        children: <Widget>[
          Container(
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
                      backgroundImage: NetworkImage(
                          "https://diorama-id.herokuapp.com/getPPByID/${timeline.list[index]["userID"]}"),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(timeline.list[index]["username"]),
                    )
                  ],
                )
                )),
          ),
          SizedBox(
            height: 350,
            width: double.infinity,
            child: FittedBox(
              clipBehavior: Clip.hardEdge,
              fit: BoxFit.cover,
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailTripPage(timeline.list[index]["tripID"], timeline.list[index]["userID"])),
                    );
                  },
                  child: Image.network(
                "https://diorama-id.herokuapp.com/getEventPictureByID/${timeline.list[index]["eventID"]}",
                fit: BoxFit.cover,
              )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text("${timeline.list[index]["caption"]}"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
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
          )
        ],
      ),
    );
  }
}
