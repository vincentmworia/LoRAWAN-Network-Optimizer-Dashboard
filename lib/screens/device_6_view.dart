import 'package:flutter/material.dart';

import './device_screen.dart';
import '../providers/device_provider.dart';

class Device6View extends StatelessWidget {
  const Device6View({super.key});

  @override
  Widget build(BuildContext context) {
    return const DeviceScreen<Device6Provider>(deviceName: "Device 6");
  }
}
