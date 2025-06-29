import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/app_info.dart';
import '../models/enum_my_pages.dart';

class NavBarPane extends StatelessWidget {
  const NavBarPane({
    super.key,
    required this.appBarHeight,
    required this.navBarWidth,
    required this.navButton,
  });

  final double appBarHeight;
  final double navBarWidth;
  final Consumer Function({
    required MyPage buttonPage,
    required double navigationBarWidth,
    required double bnHeight,
    required Widget icon,
  })
  navButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppInfo.opaquePrimaryColor(0.65),
      width: navBarWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          navButton(
            icon: Image.asset('assets/icons/1.png'),
            bnHeight: appBarHeight,
            navigationBarWidth: navBarWidth,
            buttonPage: MyPage.device1,
          ),
          navButton(
            icon: Image.asset('assets/icons/2.png'),
            bnHeight: appBarHeight,
            navigationBarWidth: navBarWidth,
            buttonPage: MyPage.device2,
          ),
          navButton(
            icon: Image.asset('assets/icons/3.png'),
            bnHeight: appBarHeight,
            navigationBarWidth: navBarWidth,
            buttonPage: MyPage.device3,
          ),
          navButton(
            icon: Image.asset('assets/icons/4.png'),
            bnHeight: appBarHeight,
            navigationBarWidth: navBarWidth,
            buttonPage: MyPage.device4,
          ),
          navButton(
            icon: Image.asset('assets/icons/5.png'),
            bnHeight: appBarHeight,
            navigationBarWidth: navBarWidth,
            buttonPage: MyPage.device5,
          ),
          navButton(
            icon: Image.asset(
              'assets/icons/6.png', // height: 80,
            ),
            bnHeight: appBarHeight,
            navigationBarWidth: navBarWidth,
            buttonPage: MyPage.device6,
          ),
          navButton(
            icon: Image.asset('assets/icons/S.png'),
            bnHeight: appBarHeight,
            navigationBarWidth: navBarWidth,
            buttonPage: MyPage.simulation,
          ),
        ],
      ),
    );
  }
}
