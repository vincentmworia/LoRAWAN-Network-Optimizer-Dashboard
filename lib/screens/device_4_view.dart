import 'package:flutter/material.dart';

import './device_screen.dart';
import '../providers/device_provider.dart';

class Device4View extends StatelessWidget {
  const Device4View({super.key});

  @override
  Widget build(BuildContext context) {
    return const DeviceScreen<Device4Provider>(deviceName: "Device 4");
  }
}
