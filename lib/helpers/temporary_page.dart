import 'package:flutter/material.dart';

import '../models/app_info.dart';

class TemporaryPage extends StatelessWidget {
  const TemporaryPage(this.pageTitle, {super.key});

  final String pageTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppInfo.opaqueColor(Colors.yellow, 0.5),
      child: Center(child: Text(pageTitle)),
    );
  }
}
