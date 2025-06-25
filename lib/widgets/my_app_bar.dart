import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/app_info.dart';
import '../models/enum_my_pages.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    super.key,
    required this.appBarHeight,
    required this.navigationBarWidth,
    required this.navButton,
  });

  final double appBarHeight;
  final double navigationBarWidth;
  final Consumer Function({
    required MyPage buttonPage,
    required double navigationBarWidth,
    required double bnHeight,
    required Widget icon,
  })
  navButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        navButton(
          icon: Icon(Icons.home, size: 40, color: Colors.white),
          bnHeight: appBarHeight,
          navigationBarWidth: navigationBarWidth,
          buttonPage: MyPage.home,
        ),

        Spacer(),
        Text(
          AppInfo.appTitle,
          style: TextStyle(color: Colors.white, fontSize: 30.0),
        ),
        Spacer(),
        // todo a circle with a flashing when we have data update
        Padding(
          // todo consume the current time with dash dash in case of null
          padding: EdgeInsets.only(right: navigationBarWidth / 4),
          child: Text(
            DateFormat('hh:mm:ss a').format(DateTime.now()),
            style: TextStyle(color: Colors.white, fontSize: 25.0),
          ),
        ),
      ],
    );
  }
}
