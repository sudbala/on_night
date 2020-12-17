import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DartySearchBarScreen extends StatefulWidget {
  final List<String> fratList = [
    "Tri-Kap",
    "Kappa",
    "BG",
    "Chi-Delt",
    "Tabard",
    "GDX",
    "TDX",
    "Maria Roodnitsky",
    "Sudharsan Balasubramani"
  ];
  @override
  _DartySearchBarScreenState createState() => _DartySearchBarScreenState();
}

class _DartySearchBarScreenState extends State<DartySearchBarScreen> {
  // Text editing controller for the text field
  final TextEditingController _filter = TextEditingController();
  bool tapped = false;

  // Search text
  String _searchText = "";

  // Widget that acts as the title of an appbar.
  Widget _appBarTitle;

  // filtered list of Strings
  List filteredList = List();

  // Constructor
  _DartySearchBarScreenState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredList = widget.fratList;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  void _getList() async {
    setState(() {
      filteredList = widget.fratList;
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
                Spacer(
                  flex: 1
                ),
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
                              tapped = true;
                            });
                          },
                          onSubmitted: (value) {
                            setState(() {
                              tapped = false;
                            });
                          },
                          controller: _filter,
                          style: const TextStyle(color: Colors.black),
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
                      child: SvgPicture.asset('assets/settings_gear.svg',
                          width: 40, height: 40, color: Colors.white70),
                    ),
              ],
      ),
    );
  }

  Widget _buildList() {
    // Build the filtered list of things we want to display
    print(_searchText);
    // If searchText is not empty
    if (_searchText.length != 0) {
      List tempList = List();
      for (int i = 0; i < widget.fratList.length; i++) {
        if (widget.fratList[i]
            .toString()
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          tempList.add(widget.fratList[i]);
        }
      }
      filteredList = tempList;
    }

    return ListView.builder(
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(filteredList[index]),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Placeholder()));
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (tapped) {
      return SizedBox(
        height: 300,
        width: MediaQuery.of(context).size.width,
        child: Scaffold(
          appBar: _buildBar(context),
          body: tapped ? _buildList() : null,
          backgroundColor: Colors.red,
          resizeToAvoidBottomPadding: false,
        ),
      );
    } else {
      return SizedBox(
          height: AppBar().preferredSize.height +
              MediaQuery.of(context).padding.top,
          width: MediaQuery.of(context).size.width,
          child: _buildBar(context));
    }
  }
}
