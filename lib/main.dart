import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:on_night/on_night_icons_icons.dart';

void main() {
  runApp(OnNight());
}

class OnNight extends StatelessWidget {
  // This widget is the root of your application.
  //https://svgsilh.com/svg/868813.svg
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OnNight',
      // Theme of our app!
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(title: 'OnNight'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    // This method is rerun every time setState is called, for instance as done
    // by the _onItemTapped method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Center(
          child: SvgPicture.asset(
            'assets/DartmouthSocial.svg',
            width: 200,
            height: 200,
            semanticsLabel: 'Fracket',
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
    );
  }
}
