import 'package:flutter/material.dart';

import '../models/app_info.dart';

class TemporaryPage extends StatelessWidget {
  const TemporaryPage(this.pageTitle, {super.key});

  final String pageTitle;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(pageTitle,style: TextStyle(fontSize: 30),),);
  }
}
