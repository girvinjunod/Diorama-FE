import 'package:diorama_id/profile.dart';
import 'package:flutter/material.dart';
import 'model/search_model.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Search _searchList = const Search(list: []);
  final TextEditingController _textcontroller = TextEditingController();
  var _noResults = true;
  var _isSearched = false;
  var success = false;
  var currsearchdone = false;

  @override
  void initState() {
    super.initState();
  }

  void getSearchResults() {
    _isSearched = true;
    currsearchdone = false;
    fetchSearch(_textcontroller.text).then((list) {
      if (list.isNotEmpty) {
        if (currsearchdone == false) {
          _noResults = false;
          _searchList = list[0];
          currsearchdone = true;
        }
      } else {
        _noResults = true;
      }
      setState(() {});
    });
  }

  Widget initSearchList(int i) {
      return
        Stack(children: <Widget>[
          Container(
            height: 100,
            width: double.infinity,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
            child: CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage("http://34.101.123.15:8080/getPPByID/${_searchList.list[i]['id']}"),
              backgroundColor: Colors.transparent,
            ),
          ),
          SizedBox(
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
                            states.contains(MaterialState.hovered)) {
                          return const Color(0x10000000);
                        }
                        return Colors.transparent;
                      },
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProfilePage(_searchList.list[i]['id'])));
                  },
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(100, 8, 4, 8),
                    child: RichText(
                      text: TextSpan(
                        text: _searchList.list[i]['username'],
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 16.0),
                      ),
                    ),
                  ),
                )),
          ),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TextField(
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
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
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    // Search
                    getSearchResults();
                  },
                  child: const Icon(
                    Icons.search,
                    size: 26.0,
                  ),
                ))
          ],
        ),
        backgroundColor: const Color(0xFFFFFFFF),
        body: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            color: const Color(0xFFFFFFFF),
            child: (_isSearched) ? Column(children:
            [
              Visibility(
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    "Search results for \"" + _textcontroller.text + "\"",
                    style:
                        const TextStyle(fontSize: 20, color: Color(0xFF05445E)),
                  ),
                ),
                visible: _isSearched,
              ),
              (_noResults)?Expanded(
                      child: Stack(children: <Widget>[
                    Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                        color: const Color(0xFFF1F1F1),
                        child: const Text("No results found",
                            style: TextStyle(
                                color: Color(0xFF05445E), fontSize: 20.0))),
                    Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
                        child: Image.asset("images/notfound.png"))
                  ])):
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _searchList.list.length,
                    padding:
                        const EdgeInsets.fromLTRB(0, 0, 0, 100),
                    itemBuilder: (context, int index) {
                      return initSearchList(index);
                    })
              )
            ]) : const Text("")));
  }
}
