import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../providers/timestamp_provider.dart';
import '../models/app_info.dart';
import '../enum/enum_my_pages.dart';

// Ensure timezone is initialized only once
bool _tzInitialized = false;

String formatGermanTime(DateTime? time) {
  if (!_tzInitialized) {
    tz.initializeTimeZones();
    _tzInitialized = true;
  }
  final berlin = tz.getLocation('Europe/Berlin');
  final germanTime = tz.TZDateTime.from(time ?? DateTime.now(), berlin);
  return DateFormat('hh:mm:ss a').format(germanTime); // Your original format
}

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
          icon: const Icon(Icons.home, size: 40, color: Colors.white),
          bnHeight: appBarHeight,
          navigationBarWidth: navigationBarWidth,
          buttonPage: MyPage.home,
        ),
        SizedBox(width: navigationBarWidth * 3),
        const Spacer(),
        if (deviceWidth > 900)
          Text(
            AppInfo.appTitle,
            style: const TextStyle(color: Colors.white, fontSize: 30.0),
          ),
        const Spacer(),
        Padding(
          padding: EdgeInsets.only(right: navigationBarWidth / 4),
          child: Consumer<TimestampProvider>(
            builder: (_, timestampProvider, _) {
              final time = timestampProvider.lastUpdated;
              final isFlashing = timestampProvider.justUpdated;

              return Row(
                children: [
                  Text(
                    formatGermanTime(time),
                    style: const TextStyle(color: Colors.white, fontSize: 25.0),
                  ),
                  SizedBox(width: navigationBarWidth / 4),
                  Container(
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
