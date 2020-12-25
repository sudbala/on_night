import 'dart:ui';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'ColorSwitcher.dart';

/// Class to hold a greek space. Has a name, a list of points for the polygon
/// and a status.
class GreekSpace {
  // Instance vars/getters/setters

  String name;
  String get fratName => name;
  set fratName(String name) {
    this.name = name;
  }

  String commonNames;
  String get otherNames => commonNames;
  set otherNames(String commonNames) {
    this.commonNames = commonNames;
  }

  List<LatLng> points;
  List<LatLng> get fratPoints => points;
  set fratPoints(List<LatLng> points) {
    this.points = points;
  }

  ColorSwitcher colorSwitcher;
  ColorSwitcher get fratColorSwitcher => colorSwitcher;
  set fratColorSwitcher(ColorSwitcher colorSwitcher) {
    this.colorSwitcher = colorSwitcher;
  }

  // Constructors
  GreekSpace({this.name, this.points, this.colorSwitcher, this.commonNames});

  // toString
  String toString() {
    return this.name + " is " + this.colorSwitcher.getStatus().toString();
  }
}
