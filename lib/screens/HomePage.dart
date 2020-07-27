import 'dart:async';
import 'dart:ui';

import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

Map<int, Color> darkCorn = {
  50: Color.fromRGBO(18, 19, 31, .1),
  100: Color.fromRGBO(18, 19, 31, .2),
  200: Color.fromRGBO(18, 19, 31, .3),
  300: Color.fromRGBO(18, 19, 31, .4),
  400: Color.fromRGBO(18, 19, 31, .5),
  500: Color.fromRGBO(18, 19, 31, .6),
  600: Color.fromRGBO(18, 19, 31, .7),
  700: Color.fromRGBO(18, 19, 31, .8),
  800: Color.fromRGBO(18, 19, 31, .9),
  900: Color.fromRGBO(18, 19, 31, 1),
};

MaterialColor darkCornColor = MaterialColor(0xFF12131F, darkCorn);

class _HomePageState extends State<HomePage> {
  // WebView Controller
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  // Current selected tab
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Frackets',
      style: optionStyle,
    ),
    Text(
      'Index 1: Social',
      style: optionStyle,
    ),
    Text(
      'Index 2: Map',
      style: optionStyle,
    ),
    Text(
      'Index 3: Calendar',
      style: optionStyle,
    ),
    Text(
      'Index 4: Profile',
      style: optionStyle,
    ),
  ];

  // Gradients

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(alignment: Alignment.bottomCenter, children: <Widget>[
        WebView(
          initialUrl: 'https://onnight-1403b.web.app/',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController controller) {
            _controller.complete(controller);
          },
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: SvgPicture.asset('assets/cup.svg',
                        width: 40, height: 40, color: Colors.white70),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      height: 40,
                      child: FractionallySizedBox(
                        child: SearchBar(
                          iconActiveColor: Colors.white,
                          textStyle:
                              TextStyle(color: Colors.white, fontSize: 20),
                          searchBarStyle: SearchBarStyle(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SvgPicture.asset('assets/settings_gear.svg',
                        width: 40, height: 40, color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
