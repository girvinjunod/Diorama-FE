import 'package:flutter/material.dart';
import 'model/search_model.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Search _searchList;
  TextEditingController _textcontroller = TextEditingController();
  var _noResults = true;
  final _searchWidget = <Widget>[];
  var _searchPics = [];
  var _isSearched = false;
  var success = false;

  @override
  void initState() {
    super.initState();
    // fetchSearch("g").then((list) {
    //   if (list[0].length!=0)
    //   {
    //     _noResults = false;
    //     _searchList = list[0];
    //     _searchPics = list[1];
    //     InitSearchList();
    //   }
    //   else{
    //      _noResults = true;
    //   }
    //   setState(() {});
    // });
  }

  void getSearchResults(){
    _searchWidget.clear();
    _isSearched = true;
    fetchSearch(_textcontroller.text).then((list) {
      if (list.length != 0)
      {
        _noResults = false;
        _searchList = list[0];
        _searchPics = list[1];
        InitSearchList();
      }
      else{
         _noResults = true;
      }
      setState(() {});
    });
  }

  void InitSearchList() {
    for (var i = 0; i < _searchList.list.length; i++) {
      _searchWidget.add(
        Stack(children: <Widget>[
          Container(
            height: 100,
            width: double.infinity,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
            child: CircleAvatar(
              radius: 40,
              backgroundImage: MemoryImage(_searchPics[i]),
              backgroundColor: Colors.transparent,
            ),
          ),
          Container(
            height: 100,
            width: double.infinity,
            child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed) ||
                            states.contains(MaterialState.hovered))
                          return const Color(0x10000000);
                        return Colors.transparent;
                      },
                    ),
                  ),
                  onPressed: () {},
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.fromLTRB(100, 8, 4, 8),
                    child: RichText(
                      text: TextSpan(
                        text: _searchList.list[i]['username'],
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 16.0),
                      ),
                    ),
                  ),
                )),
          ),
        ]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Enter username',
                border: InputBorder.none,
              ),
              controller: _textcontroller,
              onSubmitted: (value) {
                getSearchResults();
              },
              textInputAction: TextInputAction.search,
            ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                // Search
                getSearchResults();
              },
              child: Icon(
                Icons.search,
                size: 26.0,
              ),
            )
          )
        ],
      ),
        backgroundColor: const Color(0xFFFFFFFF),
        body: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            color: const Color(0xFFFFFFFF),
            child: Column(children: [
              Visibility(child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(18.0),
                child: Text(
                  "Search results for \"" + _textcontroller.text + "\"",
                  style: TextStyle(fontSize: 20, color: const Color(0xFF05445E)),
                ),
              ),
              visible: _isSearched,
              ),
              Visibility(
                  child: Expanded(
                      child: Stack(children: <Widget>[
                    Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
                        color: const Color(0xFFF1F1F1),
                        child: Text("No results found",
                            style: TextStyle(
                                color: const Color(0xFF05445E),
                                fontSize: 20.0))),
                    Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                        child: Image.asset("images/notfound.png"))
                  ])),
                  visible: _noResults && _isSearched),
              Visibility(
                child: Expanded(
                  child: SingleChildScrollView(
                    child: Column(children: _searchWidget),
                  ),
                ),
                visible: _noResults == false && _isSearched, 
              )
            ])));
  }
}
