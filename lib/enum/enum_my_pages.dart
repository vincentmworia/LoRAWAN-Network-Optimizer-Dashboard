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

class PageNameString {
  static const home = 'Home';
  static const device1 = 'Device 1';
  static const device2 = 'Device 2';
  static const device3 = 'Device 3';
  static const device4 = 'Device 4';
  static const device5 = 'Device 5';
  static const device6 = 'Device 6';
  static const simulation = 'Simulation';
}

String getPageString(MyPage page) {
  switch (page) {
    case MyPage.home:
      return PageNameString.home;
    case MyPage.device1:
      return PageNameString.device1;
    case MyPage.device2:
      return PageNameString.device2;
    case MyPage.device3:
      return PageNameString.device3;
    case MyPage.device4:
      return PageNameString.device4;
    case MyPage.device5:
      return PageNameString.device5;
    case MyPage.device6:
      return PageNameString.device6;
    case MyPage.simulation:
      return PageNameString.simulation;
  }
}

MyPage getPageEnum(String page) {
  switch (page) {
    case PageNameString.home:
      return MyPage.home;
    case PageNameString.device1:
      return MyPage.device1;
    case PageNameString.device2:
      return MyPage.device2;
    case PageNameString.device3:
      return MyPage.device3;
    case PageNameString.device4:
      return MyPage.device4;
    case PageNameString.device5:
      return MyPage.device5;
    case PageNameString.device6:
      return MyPage.device6;
    case PageNameString.simulation:
      return MyPage.simulation;
    default:
      return MyPage.home;
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
