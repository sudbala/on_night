import 'dart:ui';

import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {



  Widget HomePage() {
    return new Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          colorFilter: ColorFilter.matrix(<double>[
            2,  0,  0, 0, 0,
            0, 2,  0, 0, 0,
            0,  0, 2, 0, 0,
            0,  0,  0, 2,  0,
          ]),
          image: AssetImage('assets/on_night_background_10.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(

        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
//          color: Color(0xff000128).withOpacity(0.5),
          child: Column(

            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 250.0),
                child: Center(
                  child: Icon(
                    Icons.headset_mic,
                    color: Colors.white,
                    size: 40.0,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Awesome",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    Text(
                      "App",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              new Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 150.0),
                alignment: Alignment.center,
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new OutlineButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        color: Colors.redAccent,
                        highlightedBorderColor: Colors.white,
//                    onPressed: () => gotoSignup(),
                        child: new Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20.0,
                            horizontal: 20.0,
                          ),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Expanded(
                                child: Text(
                                  "SIGN UP",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              new Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
                alignment: Alignment.center,
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new FlatButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        color: Colors.white,
//                    onPressed: () => gotoLogin(),
                        child: new Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20.0,
                            horizontal: 20.0,
                          ),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Expanded(
                                child: Text(
                                  "LOGIN",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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

  PageController _controller = new PageController(initialPage: 1, viewportFraction: 1.0);

  @override
  Widget build(BuildContext context) {
    return HomePage();
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