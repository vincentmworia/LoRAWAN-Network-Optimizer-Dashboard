import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/mqtt_api.dart';
import '../models/app_info.dart';
import '../models/lora_api.dart';
import '../models/enum_my_pages.dart';
import '../widgets/my_app_bar.dart';
import '../providers/page_provider.dart';
import '../widgets/nav_bar_buttons.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  Consumer _navButton({
    required MyPage buttonPage,
    required double navigationBarWidth,
    required double bnHeight,
    required Widget icon,
  }) => Consumer<PageProvider>(
    builder: (ctx, pgProvider, child) => InkWell(
      onTap: () => pgProvider.setPage(buttonPage),
      hoverColor: AppInfo.opaquePrimaryColor(0.2),

      child: Container(
        width: navigationBarWidth,
        height: bnHeight,
        decoration: BoxDecoration(
          color: pgProvider.currentPage == buttonPage
              ? AppInfo.appSecondaryColor
              : null,
          border: buttonPage == MyPage.home
              ? null
              : Border.all(
                  color: Colors.white70, // or any color you want
                  width: 1, // thickness
                ),
        ),
        child: Tooltip(
          message: getPageString(buttonPage),
          decoration: const BoxDecoration(color: Colors.transparent),
          textStyle: const TextStyle(
            color: AppInfo.appPrimaryColor,
            fontSize: 15,
            backgroundColor: Colors.transparent,
          ),
          // padding: EdgeInsets.zero,
          child: child,
        ),
      ),
    ),
    child: Center(child: icon),
  );

  @override
  Widget build(BuildContext context) {
    // todo - Data should be of Device 1 to Device 6, to replace the current data!!!
    // final LoraApi loraData = LoraApi.fromMap(data);
    //
    // if (kDebugMode) {
    //   print(loraData);
    // }

    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            final appWidth = constraints.maxWidth;
            final appHeight = constraints.maxHeight;
            final navBarWidth = appWidth < 1850 ? 1850 * 0.04 : appWidth * 0.04;
            final appBarHeight = appHeight < 850
                ? 850 * 0.075
                : appHeight * 0.075;

            return (appHeight < 50)
                ? Center()
                : (appWidth < 650 || appHeight < 550)
                ? Center(
                    child: Text(
                      "Dimensions of width and height of the app must be greater than (700,550Px). Current value: ($appWidth,${appHeight}Px)",
                    ),
                  )
                : Column(
                    children: [
                      Container(
                        color: AppInfo.appPrimaryColor,
                        width: appWidth,
                        height: appBarHeight,
                        child: MyAppBar(
                          appBarHeight: appBarHeight,
                          navigationBarWidth: navBarWidth,
                          navButton: _navButton,
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: appWidth,
                          child: Row(
                            children: [
                              Container(
                                color: AppInfo.opaquePrimaryColor(0.5),
                                width: navBarWidth,
                                child: NavBarButtons(
                                  appBarHeight: appBarHeight,
                                  navBarWidth: navBarWidth,
                                  navButton: _navButton,
                                ),
                              ),
                              Expanded(
                                child: Consumer<PageProvider>(
                                  builder: (ctx, pgProvider, _) =>
                                      AnimatedSwitcher(
                                        duration: const Duration(
                                          milliseconds: 300,
                                        ),

                                        transitionBuilder:
                                            (
                                              Widget child,
                                              Animation<double> animation,
                                            ) => FadeTransition(
                                              opacity: animation,
                                              child: child,
                                            ),

                                        child: Container(
                                          key: ValueKey(pgProvider.currentPage),
                                          alignment: Alignment.center,
                                          // padding: const EdgeInsets.all(20),
                                          child: SizedBox.expand(
                                            child: getPageView(
                                              pgProvider.currentPage,
                                            ),
                                          ),
                                        ),
                                      ),
                                ),
                              ),
                            ],
                          ),
                          // height: appHeight*0.9,
                        ),
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }
}

// transitionBuilder: (child, anim) => SlideTransition(
// position: Tween<Offset>(
// begin: Offset(1, 0),
// end: Offset.zero,
// ).animate(anim),
// child: FadeTransition(opacity: anim, child: child),
// ),
