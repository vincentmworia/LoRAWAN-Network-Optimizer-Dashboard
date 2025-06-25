import 'package:flutter/material.dart';

import '../screens/home_view.dart';
import '../screens/device_1_view.dart';
import '../screens/device_2_view.dart';
import '../screens/device_3_view.dart';
import '../screens/device_4_view.dart';
import '../screens/device_5_view.dart';
import '../screens/device_6_view.dart';
import '../screens/simulation_view.dart';

enum MyPage {
  home,
  device1,
  device2,
  device3,
  device4,
  device5,
  device6,
  simulation,
}

String getPageString(MyPage page) {
  switch (page) {
    case MyPage.home:
      return "Home";
    case MyPage.device1:
      return "Device 1";
    case MyPage.device2:
      return "Device 2";
    case MyPage.device3:
      return "Device 3";
    case MyPage.device4:
      return "Device 4";
    case MyPage.device5:
      return "Device 5";
    case MyPage.device6:
      return "Device 6";
    case MyPage.simulation:
      return "Simulation";
  }
}

Widget getPageView(MyPage currentPage) {
  switch (currentPage) {
    case MyPage.home:
      return HomeView();
    case MyPage.device1:
      return Device1View();
    case MyPage.device2:
      return Device2View();
    case MyPage.device3:
      return Device3View();
    case MyPage.device4:
      return Device4View();
    case MyPage.device5:
      return Device5View();
    case MyPage.device6:
      return Device6View();
    case MyPage.simulation:
      return SimulationView();
  }
}
