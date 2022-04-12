import 'package:diorama_id/home_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'model/home.dart';
import 'dart:convert';

class TripFeed extends StatefulWidget {
  const TripFeed({Key? key}) : super(key: key);

  @override
  _TripFeedState createState() => _TripFeedState();
}

class _TripFeedState extends State<TripFeed>
    with SingleTickerProviderStateMixin {
  int _userID = 2;
  late Timeline timeline;
  final timelineWidget = <Widget>[];
  var eventPic = [];
  String _username = "username";

  // @override
  // void initState() {
  //   super.initState();
  //   getData = getTimeline(_userID.toString()).then((value) {
  //     print(value);
  //     timeline = value;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ProjectList'),
        ),
        body: Container(
            child: FutureBuilder(
          future: getTimeline(_userID.toString()),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text("Loading..."),
                ),
              );
            } else {
              // print(snapshot);
              return _postListView(context, snapshot);
            }
          },
        )));
  }

  Widget _postAuthorRow(
      BuildContext context, AsyncSnapshot snapshot, int index) {
    const double avatarDiameter = 44;
    Feed _feed = Feed.fromJson(snapshot.data[0].list[index]);
    return GestureDetector(
        onTap: () => BlocProvider.of<HomeCubit>(context).showProfile(),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: CircleAvatar(
                radius: avatarDiameter / 2,
                backgroundImage: NetworkImage(
                  'https://picsum.photos/id/237/200/200',
                ),
              ),
            ),
            Text(
              _feed.username,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ));
  }

  Widget _postImage(BuildContext context, AsyncSnapshot snapshot, int index) {
    var _image = snapshot.data[1][index];
    var bytes = MemoryImage(_image);
    return AspectRatio(
      aspectRatio: 1,
      child: Image.memory(
        _image,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _postCaption(BuildContext context, AsyncSnapshot snapshot, int index) {
    Feed _feed = Feed.fromJson(snapshot.data[0].list[index]);
    var _caption = _feed.caption;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      child: Text(
        _caption,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _postTripInfo(
      BuildContext context, AsyncSnapshot snapshot, int index) {
    Feed _feed = Feed.fromJson(snapshot.data[0].list[index]);
    var _tripname = _feed.tripname;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      child: Text(
        'Trip Info : $_tripname',
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _postCommentsButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () {}, //=> BlocProvider.of<HomeCubit>(context).showComments(),
        child: Text(
          'View Comments',
          style: TextStyle(fontWeight: FontWeight.w200),
        ),
      ),
    );
  }

  Widget _postView(BuildContext context, AsyncSnapshot snapshot, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _postAuthorRow(context, snapshot, index),
        _postImage(context, snapshot, index),
        _postCaption(context, snapshot, index),
        _postTripInfo(context, snapshot, index),
        _postCommentsButton(context)
      ],
    );
  }

  Widget _postListView(BuildContext context, AsyncSnapshot snapshot) {
    return ListView.builder(
      itemCount: snapshot.data[0].list.length,
      itemBuilder: (context, index) {
        return _postView(context, snapshot, index);
      },
    );
  }
  // return ListView.builder(
  //   shrinkWrap: true,
  //   itemCount: timeline.list.length,
  //   padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
  //   itemBuilder: (context, int index) {
  //     // final index = i ~/ 2;
  //     // print("$i $index");
  //     // if (index >= _suggestions.length) {
  //     //   _suggestions.addAll(generateWordPairs().take(10));
  //     // }
  //     return _buildRow(index);
  //   },
  // );
  // }

  // }
}
