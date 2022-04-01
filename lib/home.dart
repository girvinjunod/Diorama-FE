import 'package:flutter/material.dart';
import 'model/home.dart';

class TripFeed extends StatefulWidget {
  const TripFeed({Key? key}) : super(key: key);

  @override
  _TripFeedState createState() => _TripFeedState();
}

class _TripFeedState extends State<TripFeed> 
  with SingleTickerProviderStateMixin {
  int _userID = 2;
  late Timeline timeline;
  final timelineeWidget = <Widget>[];
  var eventPic = [];
  String _username = "username";

  @override
  void initState(){
    super.initState();
    getUserData(_userID.toString()).then((value) {
      setState(() {
        _username = value["username"];
      });
    });
    getTimeline(_userID.toString()).then((value) {
      print(value[0].list);
      timeline = value[0];
      eventPic = value[1];
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: timeline.list.length,
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
      itemBuilder: (context, int index) {
        // final index = i ~/ 2;
        // print("$i $index");
        // if (index >= _suggestions.length) {
        //   _suggestions.addAll(generateWordPairs().take(10));
        // }
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
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 20, // Image radius
                      backgroundImage: MemoryImage(eventPic[index]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(timeline.list[index]["username"]),
                    )
                  ],
                )
                // child: const Text(
                //   "Profile Name + PP",
                //   textAlign: TextAlign.left,
                // ),

                ),
          ),
          SizedBox(
            height: 350,
            width: double.infinity,
            child: FittedBox(
              clipBehavior: Clip.hardEdge,
              fit: BoxFit.cover,
              child: Image.network(
                timeline.list[index]["eventPicture"],
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
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
        ],
      ),
    );
  }
}
