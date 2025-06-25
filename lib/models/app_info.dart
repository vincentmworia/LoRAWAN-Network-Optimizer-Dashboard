import 'package:flutter/material.dart';

class AppInfo {
  static const appTitle = "Lorawan Network Optimizer";
  static const appPrimaryColor = Color(0xff003865);
  static const appSecondaryColor = Color(0xff009688);

  static Color opaquePrimaryColor(double opacity) =>
      appPrimaryColor.withAlpha((opacity * 255).toInt());

  static Color opaqueSecondaryColor(double opacity) =>
      appSecondaryColor.withAlpha((opacity * 255).toInt());

  static Color opaqueColor(Color color, double opacity) =>
      color.withAlpha((opacity * 255).toInt());
}
