import 'package:flutter/material.dart';

import './device_screen.dart';
import '../providers/device_provider.dart';

class Device5View extends StatelessWidget {
  const Device5View({super.key});

  @override
  Widget build(BuildContext context) {
    return const DeviceScreen<Device5Provider>(deviceName: "Device 5");
  }
}
