import 'dart:collection';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:on_night/model/ColorSwitcher.dart';

/// This BlankPage Widget is a completely Blank Widget with a custom listView
/// added to it in order to serve as our 'placeholder' screens for now
class NightMap extends StatefulWidget {
  NightMap({Key key}) : super(key: key);

  @override
  _NightMapState createState() => _NightMapState();
}

class _NightMapState extends State<NightMap> {
  GoogleMapController _mapController;
  bool _showMapStyle = false;
  Set<Polygon> _fratPolygons = HashSet<Polygon>();
  Map<String, ColorSwitcher> statusMap = HashMap<String, ColorSwitcher>();
  List<LatLng> trikap_points = List<LatLng>();
  List<LatLng> gdx_points = List<LatLng>();
  List<LatLng> tabard_points = List<LatLng>();

  @override
  void initState() {

    trikap_points.add(LatLng(43.70635, -72.29017));
    trikap_points.add(LatLng(43.70631, -72.28982));
    trikap_points.add(LatLng(43.7062, -72.28984));
    trikap_points.add(LatLng(43.706208, -72.28992));
    trikap_points.add(LatLng(43.70624, -72.28991));
    trikap_points.add(LatLng(43.706245, -72.28996));
    trikap_points.add(LatLng(43.70621, -72.28997));
    trikap_points.add(LatLng(43.70622, -72.29007));
    trikap_points.add(LatLng(43.7062, -72.2900735));
    trikap_points.add(LatLng(43.706207, -72.29016));
    trikap_points.add(LatLng(43.706238, -72.290156));
    trikap_points.add(LatLng(43.70624, -72.29019));

    statusMap["Kappa Kappa Kappa"] =
        ColorSwitcher(Color(0xff7F00FF), Color(0xff120024), true);

    gdx_points.add(LatLng(43.70664, -72.29013));
    gdx_points.add(LatLng(43.70661, -72.28984));
    gdx_points.add(LatLng(43.70648, -72.28987));
    gdx_points.add(LatLng(43.70651, -72.29015));

    statusMap["Gamma Delta Chi"] =
        ColorSwitcher(Color(0xffC100FF), Color(0xff1B0024), true);

    tabard_points.add(LatLng(43.70659, -72.29075));
    tabard_points.add(LatLng(43.70656, -72.29063));
    tabard_points.add(LatLng(43.70649, -72.29065));
    tabard_points.add(LatLng(43.70646, -72.29054));
    tabard_points.add(LatLng(43.70645, -72.29054));
    tabard_points.add(LatLng(43.70644, -72.29052));
    tabard_points.add(LatLng(43.70638, -72.29054));
    tabard_points.add(LatLng(43.70637, -72.2906));
    tabard_points.add(LatLng(43.70638, -72.29065));
    tabard_points.add(LatLng(43.7064, -72.29064));
    tabard_points.add(LatLng(43.70643, -72.29081));

    statusMap["The Tabard"] =
        ColorSwitcher(Color(0xffE41CFD), Color(0xff230028), true);
  }





  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;

//    setState(() {
//      _setPolygons();
//    });

    _setMapStyle();
  }

  void _setMapStyle() async {
    String style = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');
//    print('mrp yes this is happening');
    _mapController.setMapStyle(style);
  }

  Future<void> _setPolygons() async {
    // Get all data. An async call on another thread and acts as a future call
    print("in set Polygon");
    print(trikap_points.length.toString());

    // Grab result with await so we set status keys to ColorSwitchers before
    // we getStatusColor. Otherwise it will return null
    var result = await FirebaseFirestore.instance
        .collection('GreekSpaces')
        .doc('Status')
        .get()
        .then((element) => {
              element.data().forEach((key, value) {
                if (value == true) {
                  statusMap[key].setStatus(true);
                } else {
                  statusMap[key].setStatus(false);
                }
              })
            });

    // Create the polygons
    Polygon triKap = Polygon(
      geodesic: true,
      polygonId: PolygonId("triKap"),
      points: trikap_points,
      fillColor: statusMap["Kappa Kappa Kappa"]
          .getStatusColor()
          .withOpacity(statusMap["Kappa Kappa Kappa"].getOpacity()),
      strokeColor:
          statusMap["Kappa Kappa Kappa"].getStatusColor().withOpacity(0.8),
    );

    _fratPolygons.add(triKap);
    // Create the polygons
    Polygon gdx = Polygon(
      geodesic: true,
      polygonId: PolygonId("gdx"),
      points: gdx_points,
      fillColor: statusMap["Gamma Delta Chi"]
          .getStatusColor()
          .withOpacity(statusMap["Gamma Delta Chi"].getOpacity()),
      strokeColor:
      statusMap["Gamma Delta Chi"].getStatusColor().withOpacity(0.8),
    );
    // Add polygon to the fratPolygon list
    _fratPolygons.add(gdx);

    // Create the polygons
    Polygon tabard = Polygon(
      geodesic: true,
      polygonId: PolygonId("tabard"),
      points: tabard_points,
      fillColor: statusMap["The Tabard"]
          .getStatusColor()
          .withOpacity(statusMap["The Tabard"].getOpacity()),
      strokeColor:
      statusMap["The Tabard"].getStatusColor().withOpacity(0.8),
    );
    // Add polygon to the fratPolygon list
    _fratPolygons.add(tabard);
    print("We got here");
  }

  @override
  Widget build(BuildContext context) {
    // Sud learned about FutureBuilder!!! Maria will be proud of sud!
    // Maria is proud of sud! omg! :) <3 8/5/20
    return FutureBuilder(
        future: _setPolygons(),
        builder: (context, snapshot) {
          return Stack(children: <Widget>[
            GoogleMap(
              compassEnabled: false,
              onMapCreated: _onMapCreated,
              buildingsEnabled: false,
              zoomControlsEnabled: false,
              polygons: _fratPolygons,
              initialCameraPosition: CameraPosition(
                target: LatLng(43.704871, -72.288735),
                zoom: 17,
                tilt: 6,
              ),
            ),
            Positioned(
              bottom: 60,
              right: 10,
              child: FloatingActionButton(
                child: Icon(Icons.refresh),
                onPressed: _updateFrats,
                backgroundColor: Color(0xff992181),
              ),
            ),
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
//                      Container(
//                        height: 40,
//                        child: SizedBox(
//                          height: 40,
//                          width: 280,
//                          child: Container(
//                            height: 40,
//                            child: SearchBar(
//                              iconActiveColor: Colors.white,
//                              textStyle:
//                                  TextStyle(color: Colors.white, fontSize: 20),
//                              searchBarStyle: SearchBarStyle(
//                                //padding: EdgeInsets.only(top: 50),
//                                borderRadius: BorderRadius.circular(50),
//                              ),
//                            ),
//                          ),
//                        ),
//                      ),
                      Container(
                        child: SvgPicture.asset('assets/settings_gear.svg',
                            width: 40, height: 40, color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]);
        });
  }

  Future<void> _updateFrats() async {
    _fratPolygons.clear();
    setState(() {});
  }
}
