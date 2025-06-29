import 'package:flutter/material.dart';

import './app_info.dart';

class DataLimits {
  static const tempMin = 18.0;
  static const tempMax = 26.0;

  static const humidityMin = 40.0;
  static const humidityMax = 60.0;

  static const co2Min = 400.0;
  static const co2Max = 1000.0;

  static const pm25Min = 0.0;
  static const pm25Max = 5.0;

  static const pressureMin = 980.0;
  static const pressureMax = 1050.0;

  static const snrMin = -20.0;
  static const snrMax = 10.0;

  static const rssiMin = -120.0;
  static const rssiMax = -30.0;

  static const sfMin = 8.0;
  static const sfMax = 11.0;

  static const bwMin = 125.0;
  static const bwMax = 500.0;

  static const freqMin = 125.0;
  static const freqMax = 500.0;

  static const pathLossMin = 0.0;
  static const pathLossMax = 500.0;

  static const nullColor = Color(0xFFA0A0A0);
  static const normalColor = AppInfo.appSecondaryColor;
  static const lowColor = Color(0xFFFFC107);
  static const highColor = Colors.red;
}
