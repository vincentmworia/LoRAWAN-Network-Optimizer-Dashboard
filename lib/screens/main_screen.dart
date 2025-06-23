import 'package:flutter/material.dart';

import '../helpers/mqtt_api.dart';
import '../models/lora_api.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoraApi loraData = LoraApi.fromMap(data);
    return Center(
      child: Scaffold(
        body: Center(
          child: Text(loraData.uniqueId),
        ),
      ),
    );
  }
}
