import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:on_night/screens/BlankPage.dart';
import 'package:on_night/screens/HomePage.dart';

/// The NavigationBarController navigates throughout different pages of the app
///
/// Currently we have BlankPage and the HomePage :) More pages will be added
class NavigationBarController extends StatefulWidget {
  @override
  _NavigationBarControllerState createState() =>
      _NavigationBarControllerState();
}

/// Coloring of the Bottom Navigation Bar
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

/// The NavigationBarControllerState holds the the current state and builds the
/// widget based on that state.
class _NavigationBarControllerState extends State<NavigationBarController> {
  final List<Widget> pages = [
    BlankPage(
      key: PageStorageKey('Page 1'),
    ),
    BlankPage(
      key: PageStorageKey('Page 2'),
    ),
    HomePage(
      key: PageStorageKey('Page 3'),
    ),
    BlankPage(
      key: PageStorageKey('Page 4'),
    ),
    BlankPage(
      key: PageStorageKey('Page 5'),
    ),
  ];

  /// PageStorage for a given state
  final PageStorageBucket bucket = PageStorageBucket();

  /// Selected Index of page
  int _selectedIndex = 0;

  /// The navigationBar Widget, which is really our CurvedNavigationBar
  Widget _navigationBar(int selectedIndex) => CurvedNavigationBar(
        height: 50,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.purple,
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
        onTap: (int tappedPage) {
          setState(() {
            _selectedIndex = tappedPage;
          });
        },
      );

  // The building of the NavigationBar!
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            PageStorage(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 1000),
                child: pages[_selectedIndex],
              ),
              bucket: bucket,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: _navigationBar(_selectedIndex),
            ),
          ],
        ));
  }
}
