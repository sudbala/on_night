import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:on_night/widgets/NavigationBarController.dart';
import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';

class DartySearchBarScreen extends StatefulWidget {
  // this stores what type of search bar we need, for now the only option is map
  // in the future, this may be friends or other data types
  // trying to make it modularizable :)

  final String type;
  static bool tapped = false;
  // passed in from calling screen
  DartySearchBarScreen({this.type});

  @override
  _DartySearchBarScreenState createState() => _DartySearchBarScreenState();
}

class _DartySearchBarScreenState extends State<DartySearchBarScreen>
    with TickerProviderStateMixin {
  // Text editing controller for the text field
  final TextEditingController _filter = TextEditingController();

  // list of common search terms (gdx, tri-kap, tabard; not the nicknames)
  // these are the ones visible in the UI
  List<String> searchItemList = List();

  // Search text
  String _searchText = "";

  // filtered list of Strings
  List filteredList = List();

  // Constructor
  _DartySearchBarScreenState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredList = searchItemList;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  // this is the future of the search terms! We want them before people can search :)
  Future<void> _setSearch() async {
    // Get all data. An async call on another thread and acts as a future call
    Map<String, dynamic> dataMap = new HashMap<String, dynamic>();

    var result = await FirebaseFirestore.instance
        .collection('GreekSpaces')
        .get()
        .then((element) => {
              element.docs.forEach((result) async {
                dataMap = result.data();
                // if we already have added this frat, don't do it again
                if (searchItemList.contains(dataMap['Common Name'])) {
                } else {
                  searchItemList.add(dataMap['Common Name']);
                }
              })
            });
  }

  void _getList() async {
    setState(() {
      filteredList = searchItemList;
    });
  }

  @override
  void initState() {
    // Initialize I want to have the original list of things to query, and the
    // super initstate
    _getList();
    super.initState();
  }

  Widget _buildBar(BuildContext context) {
    final widthMax = MediaQuery.of(context).size.width;
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              height: AppBar().preferredSize.height,
              alignment: Alignment.center,
              child: SvgPicture.asset('assets/cup.svg',
                  width: 40, height: 40, color: Colors.white70),
            ),
          ),
          Spacer(flex: 1),
          Expanded(
            flex: 12,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              height: 50,
              width: 255,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                color: const Color.fromRGBO(142, 142, 147, .15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Theme(
                  child: TextField(
                    onTap: () {
                      setState(() {
                        DartySearchBarScreen.tapped = true;
                      });
                    },
                    onSubmitted: (value) {
                      setState(() {
                        DartySearchBarScreen.tapped = false;
                      });
                    },
                    controller: _filter,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      icon: const Icon(Icons.search),
                      border: InputBorder.none,
                      hintText: "Where would you like to go?",
                      hintStyle: const TextStyle(
                          color: Color.fromRGBO(142, 142, 147, 1)),
                    ),
                  ),
                  data: Theme.of(context).copyWith(
                    primaryColor: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Spacer(flex: 1),
          Container(
            height: AppBar().preferredSize.height,
            child: DartySearchBarScreen.tapped
                ? CloseButton(
                    color: Colors.white70,
                    onPressed: () {
                      setState(() {
                        DartySearchBarScreen.tapped = false;
                        FocusScope.of(context).unfocus();
                      });
                    })
                : SvgPicture.asset('assets/settings_gear.svg',
                    width: 40, height: 40, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildList() {


    // Build the filtered list of things we want to display
    // If searchText is not empty
    if (_searchText.length != 0) {
      List tempList = List();
      for (int i = 0; i < searchItemList.length; i++) {
        if (searchItemList[i]
            .toString()
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          tempList.add(searchItemList[i]);
        }
      }
      filteredList = tempList;
    }

    return ListView.builder(
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title:
              Text(filteredList[index], style: TextStyle(color: Colors.white)),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Placeholder()));
          },
        );
      },
    );
  }

  @override
  // Similar to Sud, Maria converted this to a FutureBuilder
  // Sud is a m a z i n g <3
  // 12/19/20 *hug*
  Widget build(BuildContext context) {
    print(_searchText);
    print(filteredList);

    return FutureBuilder(
        future: _setSearch(),
        builder: (context, snapshot) {
          return AnimatedContainer(
            height: DartySearchBarScreen.tapped
                ? 60.0 * filteredList.length +
                    AppBar().preferredSize.height +
                    MediaQuery.of(context).padding.top
                : AppBar().preferredSize.height +
                    MediaQuery.of(context).padding.top,
            child: SizedBox(
              height: 60.0 * filteredList.length,
              width: MediaQuery.of(context).size.width,
              child: Scaffold(
                appBar: _buildBar(context),
                body: _buildList(),
                backgroundColor: darkCornColor,
                resizeToAvoidBottomPadding: false,
              ),
            ),
            duration: Duration(milliseconds: 400),
          );
        });
  }
}
