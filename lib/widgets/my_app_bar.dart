import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/timestamp_provider.dart';
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
    final deviceWidth = MediaQuery.of(context).size.width;
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
        SizedBox(width: navigationBarWidth * 3),
        Spacer(),
        if (deviceWidth > 900)
          Text(
            AppInfo.appTitle,
            style: TextStyle(color: Colors.white, fontSize: 30.0),
          ),
        Spacer(),
        Padding(
          padding: EdgeInsets.only(right: navigationBarWidth / 4),
          child: Consumer<TimestampProvider>(
            builder: (_, timestampProvider, __) {
              final time = timestampProvider.lastUpdated;
              final isFlashing = timestampProvider.justUpdated;

              return Row(
                children: [
                  Text(
                    DateFormat('hh:mm:ss a').format(time ?? DateTime.now()),
                    style: const TextStyle(color: Colors.white, fontSize: 25.0),
                  ),
                  SizedBox(width: navigationBarWidth / 4),
                  Container(
                    // duration: const Duration(milliseconds: 300),
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      color: isFlashing ? Colors.red : Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white),
                    ),
                    margin: const EdgeInsets.only(right: 12),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
