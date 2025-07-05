import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

import './screens/main_screen.dart';
import './screens/login_screen.dart';
import 'helpers/app_info.dart';
import './providers/page_provider.dart';
import './providers/mqtt_provider.dart';
import '../providers/device_provider.dart';
import '../providers/timestamp_provider.dart';

void main() {
  runApp(const MyApp());

  /// Configure window (only works on Windows/Mac)
  doWhenWindowReady(() {
    appWindow.minSize = const Size(600, 550);
    appWindow.alignment = Alignment.center;
    appWindow.title = AppInfo.appTitle;
    appWindow.maximize(); // 💥 Launch full screen
    appWindow.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PageProvider()),
        ChangeNotifierProvider(create: (_) => MqttProvider()),
        ChangeNotifierProvider(create: (_) => TimestampProvider()),
        ChangeNotifierProvider(create: (_) => Device1Provider()),
        ChangeNotifierProvider(create: (_) => Device2Provider()),
        ChangeNotifierProvider(create: (_) => Device3Provider()),
        ChangeNotifierProvider(create: (_) => Device4Provider()),
        ChangeNotifierProvider(create: (_) => Device5Provider()),
        ChangeNotifierProvider(create: (_) => Device6Provider()),
      ],
      child: MaterialApp(
        title: AppInfo.appTitle,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppInfo.appPrimaryColor,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppInfo.appPrimaryColor,
            primary: AppInfo.appPrimaryColor,
            secondary: AppInfo.appSecondaryColor,
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const LoginScreen(),
          '/main': (context) => const MainScreen(),
        },
      ),
    );
  }
}
