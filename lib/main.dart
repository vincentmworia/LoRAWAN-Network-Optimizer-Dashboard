import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/main_screen.dart';
import './models/app_info.dart';
import './providers/page_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: ChangeNotifierProvider(
        create: (_) => PageProvider(),
        child: MainScreen(),
      ),
    );
  }
}
