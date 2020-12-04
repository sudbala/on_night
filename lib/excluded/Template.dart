//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_svg/svg.dart';
//import 'file:///C:/Users/Maria/AndroidStudioProjects/FlutterProjects/on_night/lib/excluded/User.dart';
//import 'package:on_night/widgets/NavigationBarController.dart';
//import 'package:google_fonts/google_fonts.dart';
//
///// This BlankPage Widget is a completely Blank Widget with a custom listView
///// added to it in order to serve as our 'placeholder' screens for now
//class Template extends StatefulWidget {
//  Template({Key key}) : super(key: key);
//
//  @override
//  _TemplateState createState() => _TemplateState();
//}
//
//class _TemplateState extends State<Template> {
////  User user = User("F003MP3");
//  User user = User("F003KGM");
//
//  Future<void> _getData() async {
//    await Firestore.instance
//        .collection("Users")
//        .document(user.netID)
//        .get()
//        .then((value) {
//      user.affiliation = value.data["Affiliation"];
//      user.classYear = value.data["Class Year"];
//      user.displayName = value.data["Display Name"];
//      user.dormRoom = value.data["Dorm Room"];
//      user.email = value.data["Email"];
//      user.legalName = value.data["Legal Name"];
//      user.phoneNumber = value.data["Phone Number"];
////          print("Success!");
//    });
//    print(user);
//  }
//
//  String __displayYear(int intYear) {
//    int lastDig = intYear % 100;
//    return "'" + lastDig.toString();
//  }
//
////  void _onPressed() async {
////    var firebaseUser = await FirebaseAuth.instance.currentUser();
////    Firestore.instance
////    .collection("Users")
////    .document(firebaseUser.uid)
////    .updateData({"Affiliation": "KDE"}).then((_) {
////      print("Woohoo");
////    });
////  }
//
//  VoidCallback onPressed() {
//    print("hehe sud button");
//  }
//
//  List<Color> _colors = [Colors.deepPurple, Colors.purple];
//  List<double> _stops = [0.0, 0.7];
//
//  @override
//  Widget build(BuildContext context) {
//    return FutureBuilder(
//        future: _getData(),
//        builder: (context, snapshot) {
//          return Scaffold(
//            body: Stack(children: <Widget>[
//              ListView(children: <Widget>[
//                Stack(
//                  children: <Widget>[
//                    Image.asset('assets/maria_profile_pic.jpg'),
//                  ],
//                ),
//                DefaultTabController(
//                  length: 2,
//                  child: SizedBox(
//                    height: 400,
//                    child: Column(
//                      children: <Widget>[
//                        Material(
//                          color: darkCornColor,
//                          child: TabBar(
//                            unselectedLabelColor: Colors.white,
//                            labelColor: Colors.pink,
//                            indicatorColor: Colors.purple,
//                            tabs: [
//                              Tab(icon: Icon(Icons.person)),
//                              Tab(icon: Icon(Icons.home)),
//                            ],
//                          ),
//                        ),
//                        Expanded(
//                          child: TabBarView(
//                            children: <Widget>[
//                              Container(
//                                decoration: BoxDecoration(
//                                    gradient: LinearGradient(
//                                  colors: _colors,
//                                  stops: _stops,
//                                )),
//                                child: Column(children: <Widget>[
//                                  Padding(
//                                    padding: const EdgeInsets.only(top: 10.0),
//                                    child: Text(
//                                      user.displayName == null
//                                          ? ''
//                                          : user.displayName,
//                                      style: GoogleFonts.comfortaa(
//                                          textStyle: TextStyle(
//                                              color: Colors.white,
//                                              fontSize: 23)),
//                                    ),
//                                  ),
//                                  Text(
//                                      user.classYear.toString() == null
//                                          ? ''
//                                          : __displayYear(user.classYear),
//                                      style: GoogleFonts.comfortaa(
//                                          textStyle: TextStyle(
//                                              color: Colors.white,
//                                              fontSize: 19,
//                                              letterSpacing: .15))),
//                                  Padding(
//                                    padding: const EdgeInsets.only(top: 40.0),
//                                    child: Row(
//                                      children: <Widget>[
//                                        Expanded(
//                                          flex: 1,
//                                          child: Icon(Icons.home,
//                                              color: Colors.white, size: 24),
//                                        ),
//                                        Expanded(
//                                          flex: 3,
//                                          child: Text(
//                                              user.dormRoom == null
//                                                  ? ''
//                                                  : user.dormRoom,
//                                              style: GoogleFonts.comfortaa(
//                                                  textStyle: TextStyle(
//                                                      color: Colors.white,
//                                                      fontSize: 19,
//                                                      letterSpacing: .15))),
//                                        ),
//                                        Expanded(
//                                          flex: 1,
//                                          child: Icon(Icons.help,
//                                              color: Colors.white, size: 24),
//                                        ),
//                                      ],
//                                    ),
//                                  ),
//                                  Padding(
//                                    padding: const EdgeInsets.only(
//                                        top: 20.0, bottom: 20.0),
//                                    child: Row(
//                                      mainAxisAlignment:
//                                          MainAxisAlignment.spaceAround,
//                                      children: <Widget>[
//                                        Expanded(
//                                          flex: 1,
//                                          child: Icon(Icons.phone_iphone,
//                                              color: Colors.white, size: 24),
//                                        ),
//                                        Expanded(
//                                          flex: 3,
//                                          child: Text(
//                                              user.phoneNumber == null
//                                                  ? ''
//                                                  : user.phoneNumber,
//                                              style: GoogleFonts.comfortaa(
//                                                  textStyle: TextStyle(
//                                                      color: Colors.white,
//                                                      fontSize: 19,
//                                                      letterSpacing: .15))),
//                                        ),
//                                        Expanded(
//                                          flex: 1,
//                                          child: Icon(Icons.help,
//                                              color: Colors.white, size: 24),
//                                        ),
//                                      ],
//                                    ),
//                                  ),
//                                  FlatButton(
//                                      shape: RoundedRectangleBorder(
//                                        borderRadius:
//                                            BorderRadius.circular(50.0),
//                                        side: BorderSide(
//                                          color: Colors.purpleAccent,
//                                        ),
//                                      ),
//                                      highlightColor: Colors.orange,
//                                      color: Colors.white10,
//                                      splashColor: Colors.lightBlue,
//                                      colorBrightness: Brightness.dark,
//                                      onPressed: () {},
//                                      child: Text("Edit",
//                                          style: GoogleFonts.openSans(
//                                              textStyle: TextStyle(
//                                                  color: Colors.white,
//                                                  fontSize: 14,
//                                                  fontWeight: FontWeight.w500,
//                                                  letterSpacing: 1.25)))),
//                                ]),
//                              ),
//                              Container(
//                                color: Colors.yellow,
//                              ),
//                            ],
//                          ),
//                        )
//                      ],
//                    ),
//                  ),
//                )
//              ]),
//              SafeArea(
//                child: Padding(
//                  padding: const EdgeInsets.all(5.0),
//                  child: Align(
//                    alignment: Alignment.topCenter,
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceAround,
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      children: <Widget>[
//                        Container(
//                          child: SvgPicture.asset('assets/cup.svg',
//                              width: 40, height: 40, color: Colors.white70),
//                        ),
//                        Container(
//                          height: 40,
//                          child: SizedBox(
//                            height: 40,
//                            width: 280,
//                            child: Container(height: 40),
//                          ),
//                        ),
//                        Container(
//                          child: SvgPicture.asset('assets/settings_gear.svg',
//                              width: 40, height: 40, color: Colors.white70),
//                        ),
//                      ],
//                    ),
//                  ),
//                ),
//              ),
//            ]),
//          );
//        });
//  }
//}
