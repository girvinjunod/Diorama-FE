import 'package:flutter/material.dart';

class TripFeed extends StatefulWidget {
  const TripFeed({Key? key}) : super(key: key);

  @override
  _TripFeedState createState() => _TripFeedState();
}

class _TripFeedState extends State<TripFeed> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 5,
      padding: const EdgeInsets.all(20),
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
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
      child: Column(
        children: <Widget>[
          SizedBox(
            width: double.infinity,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: const Text(
                "Profile Name + PP",
                textAlign: TextAlign.left,
              ),
            ),
          ),
          FittedBox(
            fit: BoxFit.contain,
            child: Image.asset("images/car.png"),
          ),
        ],
      ),
    );
  }
}
