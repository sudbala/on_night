
import 'package:flutter/cupertino.dart';

class ColorSwitcher {
  // Instance variables used for the color switcher
  bool status;
  Color openColor, closedColor, returnColor;
  double opacity;

  // Constructor for the colorSwitcher
  ColorSwitcher(this.openColor, this.closedColor, this.status);


  void setStatus(bool status) {
    this.status = status;

    // Based on status, set the return color

    if (status) {
      returnColor = openColor;
      opacity = 0.35;
    } else {
      returnColor = closedColor;
      opacity = 0.5;
    }
  }

  bool getStatus() {
    return status;
  }

  Color getStatusColor() {
    return returnColor;
  }

  double getOpacity() {
    return opacity;
  }

}