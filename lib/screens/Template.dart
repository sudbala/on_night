import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:on_night/widgets/NavigationBarController.dart';

/// This BlankPage Widget is a completely Blank Widget with a custom listView
/// added to it in order to serve as our 'placeholder' screens for now
class Template extends StatefulWidget {
  Template({Key key}) : super(key: key);

  @override
  _TemplateState createState() => _TemplateState();
}

class _TemplateState extends State<Template> {
   _getData() async {
    Firestore.instance
        .collection("Users")
        .document("F003KGM")
        .get()
        .then((value) {
      String name = value.data["Display Name"];
    });
  }

//  void _onPressed() async {
//    var firebaseUser = await FirebaseAuth.instance.currentUser();
//    Firestore.instance
//    .collection("Users")
//    .document(firebaseUser.uid)
//    .updateData({"Affiliation": "KDE"}).then((_) {
//      print("Woohoo");
//    });
//  }

  @override
  Widget build(BuildContext context) {
//    _getData();
    _getData();
    print("We working hehe :)");
    return Scaffold(
      body: Stack(children: <Widget>[
        ListView(children: <Widget>[
          Stack(
            children: <Widget>[
              Image.asset('assets/strawberry.jpg'),
            ],
          ),
          DefaultTabController(
            length: 2,
            child: SizedBox(
              height: 400,
              child: Column(
                children: <Widget>[
                  Material(
                    color: darkCornColor,
                    child: TabBar(
                      unselectedLabelColor: Colors.white,
                      labelColor: Colors.pink,
                      indicatorColor: Colors.purple,
                      tabs: [
                        Tab(icon: Icon(Icons.person)),
                        Tab(icon: Icon(Icons.home)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: <Widget>[
                        Container(
                          child: Column(children: <Widget>[
                            Text("Maria Roodnitsky"),
                            Text("'22"),
                            Row(
                              children: <Widget>[
                                Icon(Icons.home),
                                Text('McCulloch 109'),
                                Icon(Icons.help)
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Icon(Icons.phone_iphone),
                                Text('515-441-1974'),
                                Icon(Icons.help)
                              ],
                            ),
                            RaisedButton(
                              onPressed: () {},
                              textColor: Colors.white,
                              padding: const EdgeInsets.all(0.0),
                              child: Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: <Color>[
                                      Color(0xFF0D47A1),
                                      Color(0xFF1976D2),
                                      Color(0xFF42A5F5),
                                    ],
                                  ),
                                ),
                                padding: const EdgeInsets.all(30.0),
                                child: const Text('Edit',
                                    style: TextStyle(fontSize: 20)),
                              ),
                            ),
                          ]),
                        ),
                        Container(
                          color: Colors.yellow,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ]),
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
                      child: Container(height: 40),
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
      ]),
    );
  }
}
