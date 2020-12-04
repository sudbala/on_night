import 'package:flutter/material.dart';
import 'package:on_night/screens/Login.dart';
import 'package:on_night/screens/Map.dart';
import 'package:on_night/widgets/NavigationBarController.dart';
// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';

/// OnNight widget is the heart of this application. Runs the app
///
/// Sets the theme, runs the NavigationBarController that will let us navigate
/// throughout our different screens.
class OnNight extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("Something Went wrong");

          return Placeholder();
        }
        return MaterialApp(
            title: 'OnNight',
            // Theme of our app!
            theme: ThemeData(
              // Primary colors, are not shown, but will probably change these just in case
              primarySwatch: darkCornColor,
              primaryColor: darkCornColor,
              brightness: Brightness.light,
              accentColor: Colors.cyan[600],
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            // Navigate via our navigationBarController
            home: LoginScreen() //NavigationBarController(),
        );
      },
    );
  }
}
