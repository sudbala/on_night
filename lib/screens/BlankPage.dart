import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

/// This BlankPage Widget is a completely Blank Widget with a custom listView
/// added to it in order to serve as our 'placeholder' screens for now
class BlankPage extends StatefulWidget {
  BlankPage({Key key}) : super(key: key);

  @override
  _BlankPageState createState() => _BlankPageState();
}

class _BlankPageState extends State<BlankPage> {

  GoogleMapController _mapController;
  bool _showMapStyle = false;

  void _onMapCreated(GoogleMapController controller){
    _mapController = controller;

    setState(() {

    });

    _setMapStyle();
  }

  void _setMapStyle() async {
    String style = await DefaultAssetBundle.of(context).loadString('assets/map_style.json');
    print('mrp yes this is happening');
    _mapController.setMapStyle(style);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Maria's Screen"),
      ),
      body: GoogleMap(

        onMapCreated: _onMapCreated,
          buildingsEnabled: false,
          zoomControlsEnabled: false,
          initialCameraPosition:
              CameraPosition(target: LatLng(43.704871, -72.288735), zoom: 17, tilt: 6,
              )),

    );
  }
}
