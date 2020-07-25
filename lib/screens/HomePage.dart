import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Stack(
        children: <Widget>[
          WebView(
            initialUrl: 'https://onnight-1403b.web.app/',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController controller) {
              _controller.complete(controller);
            },
          ),
          BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Container(
                  child: SvgPicture.asset(
                    'assets/fracket.svg',
                    width: 24,
                    height: 24,
                  ),
                ),
                title: Text('Frackets'),
              ),
              BottomNavigationBarItem(
                  icon: Container(
                    child: SvgPicture.asset(
                      'assets/DartmouthSocial.svg',
                      width: 24,
                      height: 24,
                    ),
                  ),
                  title: Text('Social')),
              BottomNavigationBarItem(
                icon: Container(
                  child: SvgPicture.asset(
                    'assets/Map.svg',
                    width: 24,
                    height: 24,
                  ),
                ),
                title: Text('Map'),
              ),
              BottomNavigationBarItem(
                icon: Container(
                  child: SvgPicture.asset(
                    'assets/Calendar.svg',
                    width: 24,
                    height: 24,
                  ),
                ),
                title: Text('Calendar'),
              ),
              BottomNavigationBarItem(
                icon: Container(
                  child: SvgPicture.asset(
                    'assets/profile.svg',
                    width: 24,
                    height: 24,
                  ),
                ),
                title: Text('Profile'),
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber[800],
            onTap: _onItemTapped,
          ),
        ],
      ),
    );
  }
}
