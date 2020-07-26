import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:on_night/screens/BlankPage.dart';
import 'package:on_night/screens/HomePage.dart';

class NavigationBarController extends StatefulWidget {
  @override
  _NavigationBarControllerState createState() =>
      _NavigationBarControllerState();
}

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

  final PageStorageBucket bucket = PageStorageBucket();

  // Selected Index of page
  int _selectedIndex = 0;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        PageStorage(
          child: pages[_selectedIndex],
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
