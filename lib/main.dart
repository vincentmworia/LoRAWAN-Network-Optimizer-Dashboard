import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/main_screen.dart';
import './models/app_info.dart';
import './providers/page_provider.dart';
import './providers/mqtt_provider.dart';

void main() {
  runApp(const MyApp());
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
        home: const MainScreen(),
      ),
    );
  }
}
