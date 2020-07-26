import 'package:flutter/material.dart';
import 'package:on_night/widgets/NavigationBarController.dart';

import 'HomePage.dart';

class OnNight extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OnNight',
      // Theme of our app!
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: NavigationBarController(),
    );
  }
}
