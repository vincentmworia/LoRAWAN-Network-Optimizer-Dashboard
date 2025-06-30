import 'package:flutter/material.dart';
import 'package:lorawan/widgets/device_small_info.dart';
import 'package:lorawan/widgets/disconnected_view.dart';
import 'package:provider/provider.dart';

import '../models/app_info.dart';
import '../enum/enum_my_pages.dart';
import '../providers/page_provider.dart';
import '../providers/mqtt_provider.dart';
import '../widgets/my_app_bar.dart';
import '../widgets/nav_bar_pane.dart';
import '../providers/device_provider.dart';
import '../providers/timestamp_provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final mqttProvider = context.read<MqttProvider>();
      mqttProvider.initializeMqttClient(
        deviceProviders: [
          context.read<Device1Provider>(),
          context.read<Device2Provider>(),
          context.read<Device3Provider>(),
          context.read<Device4Provider>(),
          context.read<Device5Provider>(),
          context.read<Device6Provider>(),
        ],
        timestampProvider: context.read<TimestampProvider>(),
      );
    });
  }

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
              : Border.all(color: Colors.white70, width: 1),
        ),
        child: Tooltip(
          message: getPageString(buttonPage),
          decoration: const BoxDecoration(color: Colors.transparent),
          textStyle: const TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
          child: child,
        ),
      ),
    ),
    child: Center(child: icon),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<MqttProvider>(
          builder: (context, mqttProvider, _) {
            if (mqttProvider.connectionStatus ==
                ConnectionStatus.disconnected) {
              return DisconnectedView(mqttProvider: mqttProvider);
            }
            return LayoutBuilder(
              builder: (context, constraints) {
                final appWidth = constraints.maxWidth;
                final appHeight = constraints.maxHeight;
                final navBarWidth = appWidth < 1850
                    ? 1850 * 0.04
                    : appWidth * 0.04;
                final appBarHeight = appHeight < 850
                    ? 850 * 0.075
                    : appHeight * 0.075;

                if (appHeight < 50) return const Center();
                if (appWidth < 600 || appHeight < 550) {
                  return DeviceSmallInfo(appWidth: appWidth, appHeight: appHeight);
                }
                return Column(
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
                      child: Row(
                        children: [
                          NavBarPane(
                            appBarHeight: appBarHeight,
                            navBarWidth: navBarWidth,
                            navButton: _navButton,
                          ),
                          Expanded(
                            child: Consumer<PageProvider>(
                              builder: (ctx, pgProvider, _) => AnimatedSwitcher(
                                duration: const Duration(milliseconds: 500),
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
                                  padding: const EdgeInsets.all(10.0),
                                  child: SizedBox.expand(
                                    child: getPageView(pgProvider.currentPage),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
