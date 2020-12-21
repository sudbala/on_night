import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:on_night/model/ColorSwitcher.dart';
import 'package:on_night/model/GreekSpace.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:on_night/widgets/darty_search_bar.dart';

/// The NightMap is the Google Maps page that is displayed as the main page in
/// OnNight
class NightMap extends StatefulWidget {
  NightMap({Key key}) : super(key: key);

  @override
  _NightMapState createState() => _NightMapState();
}

/// Initializes the state of the stateful widget NightMap
class _NightMapState extends State<NightMap> {
  // Instance vars, our map controller, set of polygons, and our GreekSpaceMap
  GoogleMapController _mapController;
  Set<Polygon> _fratPolygons = HashSet<Polygon>();
  Map<String, GreekSpace> greekSpaceMap = HashMap<String, GreekSpace>();
  String _mapStyle;
  double mapBottomPadding = 0;

  @override
  void initState() {
    // Get the style into a string
    rootBundle
        .loadString('assets/map_style.json')
        .then((style) => {_mapStyle = style});
  }

  // When the map is created, we set the map's style.
  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _mapController.setMapStyle(_mapStyle);
    setState(() {
      mapBottomPadding = 50;
    });
  }

  // Initializes the map of GreekSpaces from the databases
  void initializeGreekSpaceMap(
      String docID, Map<String, dynamic> dataMap) async {
    // Grab all data from the database: the list of points for a frat, the open
    // color, the closed color, whether it is open
    List<dynamic> points = dataMap['Points'];
    bool open = dataMap['Open'];
    Color openColor = Color(dataMap['OpenColor']);
    Color closeColor = Color(dataMap['ClosedColor']);

    // Convert GeoPoints to LatLngs to put inside a GreekSpace object
    List<LatLng> greekSpacePoints = List<LatLng>();
    for (dynamic point in points) {
      greekSpacePoints.add(LatLng(point.latitude, point.longitude));
    }

    // Add all data to a GreekSpace object and then to greek space map
    greekSpaceMap[docID] = GreekSpace(
        name: docID,
        points: greekSpacePoints,
        colorSwitcher: ColorSwitcher(openColor, closeColor, open));
  }

  // The future of the Map. We want to set the polygons before we make the map
  // so we can see the shapes on the map as it loads.
  Future<void> _setPolygons() async {
    // Get all data. An async call on another thread and acts as a future call
    Map<String, dynamic> dataMap = new HashMap<String, dynamic>();

    // Grab result with await so we set status keys to ColorSwitchers before
    // we getStatusColor. Otherwise it will return null
    var result = await FirebaseFirestore.instance
        .collection('GreekSpaces')
        .get()
        .then((element) => {
              element.docs.forEach((result) async {
                dataMap = result.data();
                initializeGreekSpaceMap(result.id, dataMap);
              })
            });

    print("the size of polygons: " + _fratPolygons.length.toString());
    // Create the polygons
    for (GreekSpace greekSpace in greekSpaceMap.values) {
      // Create a polygon
      Polygon greekSpacePolygon = Polygon(
        geodesic: true,
        polygonId: PolygonId(greekSpace.name),
        points: greekSpace.points,
        fillColor: greekSpace.colorSwitcher
            .getStatusColor()
            .withOpacity(greekSpace.colorSwitcher.getOpacity()),
        strokeColor: greekSpace.colorSwitcher.getStatusColor().withOpacity(0.8),
        strokeWidth: 2,
      );
      // Now we add the polygon to the fratPolygons
      _fratPolygons.add(greekSpacePolygon);
    }
    greekSpaceMap.clear();
  }

  @override
  Widget build(BuildContext context) {
    // Sud learned about FutureBuilder!!! Maria will be proud of sud!
    // Maria is proud of sud! omg! :) <3 8/5/20
    bool tapped = false;
    bool _isVisible = false;

    return FutureBuilder(
        future: _setPolygons(),
        builder: (context, snapshot) {
          return GestureDetector(
            onTap: () {
              setState(() {
                FocusScope.of(context).requestFocus(FocusNode());
                DartySearchBarScreen.tapped = false;
              });
            },
            child: Stack(children: <Widget>[
              GoogleMap(
                padding: EdgeInsets.only(
                    bottom: mapBottomPadding, top: 0, right: 0, left: 0),
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
              Visibility(
                visible: _isVisible,
                child: Placeholder(),
              ),
              DartySearchBarScreen(type: "map"),
              Positioned(
                bottom: 60,
                right: 10,
                child: FloatingActionButton(
                  child: Icon(Icons.refresh),
                  onPressed: _updateFrats,
                  backgroundColor: Color(0xff992181),
                ),
              ),
            ]),
          );
        });
  }

  Future<void> _updateFrats() async {
    _fratPolygons.clear();
    setState(() {});
  }
}
