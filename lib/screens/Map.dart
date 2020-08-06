import 'dart:collection';

import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
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

  @override
  void initState() {
    trikap_points.add(LatLng(43.706194544415595, -72.28984499162837));
    trikap_points.add(LatLng(43.70620326968381, -72.28984365052386));
    trikap_points.add(LatLng(43.70621199495077, -72.28984230941936));
    trikap_points.add(LatLng(43.706219944637354, -72.28984070009393));
    trikap_points.add(LatLng(43.706228476007134, -72.28983828610583));
    trikap_points.add(LatLng(43.70623720127042, -72.28983694500133));
    trikap_points.add(LatLng(43.70624592653244, -72.28983560389682));
    trikap_points.add(LatLng(43.70625387621452, -72.2898339945714));
    trikap_points.add(LatLng(43.706262407579466, -72.2898315805833));
    trikap_points.add(LatLng(43.70627113283784, -72.28983023947879));
    trikap_points.add(LatLng(43.70627985809492, -72.28982889837428));
    trikap_points.add(LatLng(43.706287613877926, -72.28982621616527));
    trikap_points.add(LatLng(43.70629633913261, -72.28982487506076));
    trikap_points.add(LatLng(43.70630506438603, -72.28982353395625));
    trikap_points.add(LatLng(43.70631185069336, -72.28982755726977));
    trikap_points.add(LatLng(43.7063135957437, -72.28983935898943));
    trikap_points.add(LatLng(43.706314565216076, -72.28985142892999));
    trikap_points.add(LatLng(43.70631553468845, -72.28986349887056));
    trikap_points.add(LatLng(43.706317473633135, -72.28987422770662));
    trikap_points.add(LatLng(43.70631844310549, -72.28988629764719));
    trikap_points.add(LatLng(43.70631941257776, -72.28989836758775));
    trikap_points.add(LatLng(43.706320382050066, -72.28991043752832));
    trikap_points.add(LatLng(43.706322320994595, -72.28992116636438));
    trikap_points.add(LatLng(43.70632329046684, -72.28993323630495));
    trikap_points.add(LatLng(43.70632425993907, -72.28994530624551));
    trikap_points.add(LatLng(43.70632542330573, -72.28995630330249));
    trikap_points.add(LatLng(43.70632716835568, -72.28996810502214));
    trikap_points.add(LatLng(43.706328137827825, -72.28998017496271));
    trikap_points.add(LatLng(43.7063291073, -72.28999224490327));
    trikap_points.add(LatLng(43.70633104624422, -72.29000297373933));
    trikap_points.add(LatLng(43.70633201571634, -72.2900150436799));
    trikap_points.add(LatLng(43.70633298518842, -72.29002711362047));
    trikap_points.add(LatLng(43.70633395466049, -72.29003918356103));
    trikap_points.add(LatLng(43.70633589360459, -72.2900499123971));
    trikap_points.add(LatLng(43.706336863076615, -72.29006198233766));
    trikap_points.add(LatLng(43.706337832548634, -72.29007405227823));
    trikap_points.add(LatLng(43.70633880202063, -72.2900861222188));
    trikap_points.add(LatLng(43.70634074096457, -72.29009685105486));
    trikap_points.add(LatLng(43.70634171043652, -72.29010892099542));
    trikap_points.add(LatLng(43.706342679908445, -72.29012099093599));
    trikap_points.add(LatLng(43.70634384327473, -72.29013198799296));
    trikap_points.add(LatLng(43.70634558832415, -72.29014378971262));
    trikap_points.add(LatLng(43.70634655779599, -72.29015585965318));
    trikap_points.add(LatLng(43.70634752726786, -72.29016792959375));
    trikap_points.add(LatLng(43.70634384327473, -72.29017436689539));
    trikap_points.add(LatLng(43.70633511802697, -72.2901757079999));
    trikap_points.add(LatLng(43.706326392777925, -72.2901770491044));
    trikap_points.add(LatLng(43.70631844310549, -72.29017865842981));
    trikap_points.add(LatLng(43.70630991174851, -72.29018107241792));
    trikap_points.add(LatLng(43.70630118649577, -72.29018241352243));
    trikap_points.add(LatLng(43.7062924612418, -72.29018375462694));
    trikap_points.add(LatLng(43.70628470545942, -72.29018643683595));
    trikap_points.add(LatLng(43.706275980203046, -72.29018777794046));
    trikap_points.add(LatLng(43.70626725494538, -72.29018911904497));
    trikap_points.add(LatLng(43.70625852968646, -72.29019046014947));
    trikap_points.add(LatLng(43.706250773899704, -72.29019314235849));
    trikap_points.add(LatLng(43.706242048638366, -72.290194483463));
    trikap_points.add(LatLng(43.706233517270526, -72.29019206947488));
    trikap_points.add(LatLng(43.706232547796844, -72.29017999953432));
    trikap_points.add(LatLng(43.70623157832312, -72.29016792959375));
    trikap_points.add(LatLng(43.706223628638085, -72.29016900247736));
    trikap_points.add(LatLng(43.70621490337282, -72.29017034358186));
    trikap_points.add(LatLng(43.706207341475206, -72.29016658848924));
    trikap_points.add(LatLng(43.706206372001105, -72.29015451854868));
    trikap_points.add(LatLng(43.706205208632134, -72.29014352149171));
    trikap_points.add(LatLng(43.706203463578646, -72.29013171977205));
    trikap_points.add(LatLng(43.70620249410446, -72.29011964983148));
    trikap_points.add(LatLng(43.70620152463025, -72.29010757989091));
    trikap_points.add(LatLng(43.70619958568182, -72.29009685105486));
    trikap_points.add(LatLng(43.706198616207594, -72.29008478111429));
    trikap_points.add(LatLng(43.706200555156066, -72.29007673448724));
    trikap_points.add(LatLng(43.706209086528595, -72.29007432049914));
    trikap_points.add(LatLng(43.706217036215556, -72.29007271117372));
    trikap_points.add(LatLng(43.7062158728468, -72.29006171411676));
    trikap_points.add(LatLng(43.706214127793615, -72.2900499123971));
    trikap_points.add(LatLng(43.7062131583196, -72.29003784245653));
    trikap_points.add(LatLng(43.70621218884557, -72.29002577251596));
    trikap_points.add(LatLng(43.70621024989748, -72.2900150436799));
    trikap_points.add(LatLng(43.70620928042342, -72.29000297373933));
    trikap_points.add(LatLng(43.70620831094932, -72.28999090379877));
    trikap_points.add(LatLng(43.70620714758041, -72.2899799067418));
    trikap_points.add(LatLng(43.706206178106264, -72.28996837324306));
    trikap_points.add(LatLng(43.70621393389881, -72.28996569103404));
    trikap_points.add(LatLng(43.70622265916424, -72.28996434992953));
    trikap_points.add(LatLng(43.706231384428364, -72.28996300882503));
    trikap_points.add(LatLng(43.70623914021765, -72.28996032661601));
    trikap_points.add(LatLng(43.706241273059526, -72.28995335287256));
    trikap_points.add(LatLng(43.70624030358595, -72.28994128293199));
    trikap_points.add(LatLng(43.706239334112375, -72.28992921299142));
    trikap_points.add(LatLng(43.7062333233758, -72.289924921457));
    trikap_points.add(LatLng(43.70622459811192, -72.28992626256151));
    trikap_points.add(LatLng(43.70621684232076, -72.28992894477052));
    trikap_points.add(LatLng(43.70620811705451, -72.28993028587503));
    trikap_points.add(LatLng(43.70620152463025, -72.2899251896779));
    trikap_points.add(LatLng(43.706200555156066, -72.28991311973734));
    trikap_points.add(LatLng(43.70619958568182, -72.28990104979677));
    trikap_points.add(LatLng(43.70619842231274, -72.2898900527398));
    trikap_points.add(LatLng(43.706196677259044, -72.28987825102014));
    trikap_points.add(LatLng(43.70619570778476, -72.28986618107957));
    trikap_points.add(LatLng(43.706194738310444, -72.28985411113901));

    statusMap["Kappa Kappa Kappa"] =
        ColorSwitcher(Color(0xff7F00FF), Color(0xff120024), false);
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
    var result = await Firestore.instance
        .collection("GreekSpaces")
        .getDocuments()
        .then((querySnapShot) {
      querySnapShot.documents.forEach((element) {
        //print(element.data);
        element.data.forEach((key, value) {
          if (value == true) {
            statusMap[key].setStatus(true);
          } else {
            statusMap[key].setStatus(false);
          }
        });
      });
    });

    // Create the polygons
    Polygon triKap = Polygon(
      polygonId: PolygonId("triKap"),
      points: trikap_points,
      strokeWidth: 3,
      fillColor: statusMap["Kappa Kappa Kappa"]
          .getStatusColor()
          .withOpacity(statusMap["Kappa Kappa Kappa"].getOpacity()),
      strokeColor:
          statusMap["Kappa Kappa Kappa"].getStatusColor().withOpacity(0.8),
    );

    // Add polygon to the fratPolygon list
    _fratPolygons.add(triKap);
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
                      Container(
                        height: 40,
                        child: SizedBox(
                          height: 40,
                          width: 280,
                          child: Container(
                            height: 40,
                            child: SearchBar(
                              iconActiveColor: Colors.white,
                              textStyle:
                                  TextStyle(color: Colors.white, fontSize: 20),
                              searchBarStyle: SearchBarStyle(
                                //padding: EdgeInsets.only(top: 50),
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
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
          ]);
        });
  }

  Future<void> _updateFrats() async {
    _fratPolygons.clear();
    setState(() {
    });
  }
}
