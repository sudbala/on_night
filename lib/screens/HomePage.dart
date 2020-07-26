import 'dart:async';

import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:on_night/animated_gradient_box.dart';
import 'package:google_fonts/google_fonts.dart';

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
      body: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
//        AnimatedBackground(),
        WebView(
          initialUrl: 'https://onnight-1403b.web.app/',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController controller) {
            _controller.complete(controller);
          },
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: SvgPicture.asset('assets/cup.svg',
                          width: 40, height: 40, color: Colors.white70),
                    ),
                  Container(
                      height: 40,
                      child: SizedBox(
                        height: 40,
                        width: 280,
                        child: Container(
                              height: 40,
                              child: SearchBar(
                                iconActiveColor: Colors.white,
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20
                                ),
                                searchBarStyle: SearchBarStyle(
                                  //padding: EdgeInsets.only(top: 50),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                            ),
                      ),
                    ),
                    Container(
                        child: SvgPicture.asset('assets/settings_gear.svg',
                            width: 40, height: 40, color: Colors.white70),
                      ),
                  ],
              ),
            ),
          ),
        ),

        Align(
            alignment: Alignment.bottomCenter,
            child: CurvedNavigationBar(
              height: 50,
              backgroundColor: Colors.transparent,
              buttonBackgroundColor: Colors.transparent,
              color: darkCornColor,
              items: <Widget>[
                Container(
                  child: SvgPicture.asset('assets/fracket.svg',
                      width: 40, height: 40, color: Colors.white70),
                ),
                Container(
                  child: SvgPicture.asset('assets/DartmouthSocial.svg',
                      width: 35, height: 35, color: Colors.white70),
                ),
                Container(
                  child: SvgPicture.asset('assets/Map.svg',
                      width: 32, height: 32, color: Colors.white70),
                ),
                Container(
                  child: SvgPicture.asset('assets/Calendar.svg',
                      width: 32, height: 32, color: Colors.white70),
                ),
                Container(
                  child: SvgPicture.asset(
                    'assets/profile.svg',
                    width: 32,
                    height: 32,
                    color: Colors.white70,
                  ),
                )
              ],
              onTap: (index) {
                //Handle button tap
              },
            ))
      ]),
    );
  }
}

class AnimatedBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("color1").add(Duration(seconds: 3),
          ColorTween(begin: Color(0xffD38312), end: Colors.lightBlue.shade900)),
      Track("color2").add(Duration(seconds: 3),
          ColorTween(begin: Color(0xffA83279), end: Colors.blue.shade600))
    ]);

    return ControlledAnimation(
      playback: Playback.MIRROR,
      tween: tween,
      duration: tween.duration,
      builder: (context, animation) {
        return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [animation["color1"], animation["color2"]])),
        );
      },
    );
  }
}
