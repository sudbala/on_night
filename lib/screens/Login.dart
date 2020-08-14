import 'dart:ui';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:on_night/widgets/NavigationBarController.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Initialize animation controls
  FlareControls flareController = FlareControls();
  String animation = "Login Idle";

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  Future navigateToMainPage(context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NavigationBarController(),
      ),
    );
  }

  Widget LoginPage() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: constraints.maxHeight,
          decoration: BoxDecoration(
              image: DecorationImage(
            // Filter color for a dark vibrance
            colorFilter: ColorFilter.matrix(<double>[
              1,
              0,
              .1,
              0,
              0,
              0,
              1,
              0,
              0,
              0,
              0,
              0,
              1,
              0,
              0,
              0,
              0,
              0,
              1,
              0,
            ]),
            image: AssetImage('assets/login_background.png'),
            fit: BoxFit.cover,
          )),
          child: Stack(children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Container(
//                color: Colors.red,
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                child: FlareActor(
                  'assets/animations/login (3).flr',
                  controller: flareController,
                  animation: animation,
                  callback: (String animationName) {
                    if (animationName == "Ball Break") {
                      navigateToMainPage(context);
                    }
                  },
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: constraints.maxHeight / 2.8),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/cup.svg',
                      color: Colors.white,
                      width: constraints.maxWidth / 3,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: constraints.maxHeight / 7),
                  child: Center(
                    child: SizedBox(
                      width: constraints.maxWidth / 2.2,
                      height: constraints.maxHeight / 14,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          side: BorderSide(
                            color: Color(0xffC71585),
                          ),
                        ),
                        highlightColor: Colors.white,
                        color: Colors.white10,
                        onPressed: () {
                          setState(() {
                            animation = "Ball Break";
                          });
                        },
                      ),
                    ),
//                child: OutlineButton(
//                  shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.circular(50.0)
//                  ),
//
//                  color: Colors.white,
//                  disabledBorderColor: Colors.white,
//                  focusColor: Colors.white,
//                  highlightColor: Colors.white,
//                  highlightedBorderColor: Colors.white,
//                  onPressed: (){},
//                ),
                  ),
                ),
              ],
            ),
          ]),
        );
      },
    );

//    return new Container(
//      height: MediaQuery.of(context).size.height,
//      decoration: BoxDecoration(
//        image: DecorationImage(
//          colorFilter: ColorFilter.matrix(<double>[
//            1,  0, .1, 0, 0,
//            0, 1,  0, 0, 0,
//            0,  0, 1, 0, 0,
//            0,  0,  0, 1,  0,
//          ]),
//          image: AssetImage('assets/login_background.png'),
//          fit: BoxFit.cover,
//        ),
//      ),
//      child: Column(
//
//        children: <Widget>[],
//      ),
//        child: Container(
////          color: Color(0xff000128).withOpacity(0.5),
//          child: Column(
//
//            children: <Widget>[
//              Container(
//                padding: EdgeInsets.only(top: 250.0),
//                child: SizedBox(
//                  child: Center(
//                    child: SvgPicture.asset('assets/cup.svg',
//                      color: Colors.white,
//                      width: MediaQuery.of(context).size.width/4,
//                      //height: 500,
//
//
//                    ),
//                  ),
//                ),
//              ),
//              Container(
//                padding: EdgeInsets.only(top: 20.0),
//                child: new Row(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>[
//
//                  ],
//                ),
//              ),
//              new Container(
//                width: MediaQuery.of(context).size.width,
//                margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 150.0),
//                alignment: Alignment.center,
//                child: new Row(
//                  children: <Widget>[
//                    new Expanded(
//                      child: new OutlineButton(
//                        shape: new RoundedRectangleBorder(
//                            borderRadius: new BorderRadius.circular(30.0)),
//                        color: Colors.redAccent,
//                        highlightedBorderColor: Colors.white,
////                    onPressed: () => gotoSignup(),
//                        child: new Container(
//                          padding: const EdgeInsets.symmetric(
//                            vertical: 20.0,
//                            horizontal: 20.0,
//                          ),
//                          child: new Row(
//                            mainAxisAlignment: MainAxisAlignment.center,
//                            children: <Widget>[
//                              new Expanded(
//                                child: Text(
//                                  "SIGN UP",
//                                  textAlign: TextAlign.center,
//                                  style: TextStyle(
//                                      color: Colors.white,
//                                      fontWeight: FontWeight.bold),
//                                ),
//                              ),
//                            ],
//                          ),
//                        ),
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//              new Container(
//                width: MediaQuery.of(context).size.width,
//                margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
//                alignment: Alignment.center,
//                child: new Row(
//                  children: <Widget>[
//                    new Expanded(
//                      child: new FlatButton(
//                        shape: new RoundedRectangleBorder(
//                            borderRadius: new BorderRadius.circular(30.0)),
//                        color: Colors.white,
////                    onPressed: () => gotoLogin(),
//                        child: new Container(
//                          padding: const EdgeInsets.symmetric(
//                            vertical: 20.0,
//                            horizontal: 20.0,
//                          ),
//                          child: new Row(
//                            mainAxisAlignment: MainAxisAlignment.center,
//                            children: <Widget>[
//                              new Expanded(
//                                child: Text(
//                                  "LOGIN",
//                                  textAlign: TextAlign.center,
//                                  style: TextStyle(
//                                      color: Colors.redAccent,
//                                      fontWeight: FontWeight.bold),
//                                ),
//                              ),
//                            ],
//                          ),
//                        ),
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//            ],
//          ),
//        ),
//    );
  }

//
//  gotoLogin() {
//    //controller_0To1.forward(from: 0.0);
//    _controller.animateToPage(
//      0,
//      duration: Duration(milliseconds: 800),
//      curve: Curves.bounceOut,
//    );
//  }
//
//  gotoSignup() {
//    //controller_minus1To0.reverse(from: 0.0);
//    _controller.animateToPage(
//      2,
//      duration: Duration(milliseconds: 800),
//      curve: Curves.bounceOut,
//    );
//  }

  PageController _controller =
      new PageController(initialPage: 1, viewportFraction: 1.0);

  @override
  Widget build(BuildContext context) {
    return LoginPage();
//    return Container(
//        height: MediaQuery.of(context).size.height,
//
//        child: PageView(
//          controller: _controller,
//          physics: new AlwaysScrollableScrollPhysics(),
//          children: <Widget>[ HomePage(),],
//          scrollDirection: Axis.horizontal,
//        ));
  }
}
