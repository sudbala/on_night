import 'dart:async';
import 'dart:ui';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// HomePage widget houses the current home page, the mapView! Currently in the
/// process of being changed by M a r i a :)
class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}



/// This holds the current state of our homePage
class _HomePageState extends State<HomePage> {
  // WebView Controller
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  /// Building of the HomePage Widget!
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Stack to hold webView and top View in place
      body: Stack(alignment: Alignment.bottomCenter, children: <Widget>[
        WebView(
          initialUrl: 'https://onnight-1403b.web.app/',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController controller) {
            _controller.complete(controller);
          },
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: SvgPicture.asset('assets/cup.svg',
                        width: 40, height: 40, color: Colors.white70),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      height: 40,
                      child: FractionallySizedBox(
                        child: SearchBar(
                          iconActiveColor: Colors.white,
                          textStyle:
                              TextStyle(color: Colors.white, fontSize: 20),
                          searchBarStyle: SearchBarStyle(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
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
