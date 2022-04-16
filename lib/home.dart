import 'package:flutter/material.dart';
import 'detail_trip.dart';

class TripFeed extends StatefulWidget {
  const TripFeed({Key? key}) : super(key: key);

  @override
  _TripFeedState createState() => _TripFeedState();
}

class _TripFeedState extends State<TripFeed> {
  //ini tidak hardcode
  int tripID = 1;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 5,
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
      itemBuilder: (context, i) {
        // final index = i ~/ 2;
        // print("$i $index");
        // if (index >= _suggestions.length) {
        //   _suggestions.addAll(generateWordPairs().take(10));
        // }
        return _buildRow();
      },
    );
  }

  Widget _buildRow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: SizedBox(
                width: double.infinity,
                child: Row(
                  children: const <Widget>[
                    CircleAvatar(
                      radius: 20, // Image radius
                      backgroundImage: AssetImage('images/pp-temp.jpg'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text("username"),
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
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailTripPage(tripID)),
                    );
                  },
                  child: Image.asset("images/car.png")),
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
