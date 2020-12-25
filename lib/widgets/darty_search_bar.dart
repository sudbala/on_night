import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_night/model/GreekSpace.dart';
import 'package:on_night/widgets/NavigationBarController.dart';
import 'dart:ui';
import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:on_night/model/ColorSwitcher.dart';

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
  Set<String> querySet = Set();
  HashMap<String, GreekSpace> queryGreekSpaces = HashMap<String, GreekSpace>();
  bool _visible = false;

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
                bool open = dataMap['Open'];
                Color openColor = Color(dataMap['OpenColor']);
                Color closeColor = Color(dataMap['ClosedColor']);
                // if we already have added this frat, don't do it again
                GreekSpace greekSpace = GreekSpace(
                    colorSwitcher: ColorSwitcher(openColor, closeColor, open),
                    name: dataMap['Common Name'],
                    commonNames: dataMap['OtherNames']);

                /// Add to the queryGreekSpace map to use for common name
                /// searching
                queryGreekSpaces[greekSpace.fratName] = greekSpace;
              })
            });

    queryGreekSpaces.forEach((key, value) {
      if (!searchItemList.contains(key)) {
        searchItemList.add(key);
      }
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
                        _visible = true;
                      });
                    },
                    onSubmitted: (value) {
                      setState(() {
                        DartySearchBarScreen.tapped = false;
                        _visible = false;
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
                        _visible = false;
                        FocusScope.of(context).unfocus();
                        _filter.clear();
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
                .contains(_searchText.toLowerCase()) ||
            queryGreekSpaces[searchItemList[i]]
                .otherNames
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
          return Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            margin:
                EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
            color: Colors.white30,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Transform.translate(
                    offset: Offset(-7, 0),
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: queryGreekSpaces[filteredList[index]]
                                  .colorSwitcher
                                  .status
                              ? AssetImage('assets/fratphotos/open/' +
                                  filteredList[index] +
                                  '.png')
                              : AssetImage('assets/fratphotos/closed/' +
                                  filteredList[index] +
                                  '.png'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(13.3),
                      ),
                    ),
                  ),
                  title: Text(filteredList[index],
                      style: GoogleFonts.comfortaa(color: Colors.white)),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Placeholder()));
                  },
                )
              ],
            ),
          );
        });
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
          return Stack(
            alignment: Alignment.topCenter,
            children: [
              /// Use an [AnimatedOpacity] to show when tapped.
              AnimatedOpacity(
                /// If the widget is visible, animate to 0.0 (invisible)
                /// if the widget is hidden, animate to 1.0 (fully visible)
                opacity: _visible ? 1.0 : 0.0,
                duration: Duration(milliseconds: 30),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 5,
                    sigmaY: 5,
                  ),
                  child: Container(
                    color: Colors.black.withOpacity(0.1),
                  ),
                ),
              ),
              AnimatedContainer(
                height: DartySearchBarScreen.tapped
                    ? 65.0 * filteredList.length +
                        AppBar().preferredSize.height +
                        MediaQuery.of(context).padding.top
                    : AppBar().preferredSize.height +
                        MediaQuery.of(context).padding.top,
                child: SizedBox(
                  height: 65.0 * filteredList.length,
                  width: MediaQuery.of(context).size.width,
                  child: Scaffold(
                    appBar: _buildBar(context),
                    body: _buildList(),
                    backgroundColor: Colors.transparent,
                    resizeToAvoidBottomPadding: false,
                  ),
                ),
                duration: Duration(milliseconds: 200),
              ),
            ],
          );
        });
  }
}
