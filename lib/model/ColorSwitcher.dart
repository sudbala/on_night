import 'package:flutter/cupertino.dart';

class ColorSwitcher {
  // Instance variables used for the color switcher
  bool status;
  Color openColor, closedColor, returnColor;
  double opacity;

  // Constructor for the colorSwitcher
  ColorSwitcher(this.openColor, this.closedColor, this.status) {
    // Based on status, change up the opacity
    if (this.status) {
      returnColor = openColor;
      opacity = 0.35;
    } else {
      returnColor = closedColor;
      opacity = 0.5;
    }
  }

  void setStatus(bool status) {
    this.status = status;
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
