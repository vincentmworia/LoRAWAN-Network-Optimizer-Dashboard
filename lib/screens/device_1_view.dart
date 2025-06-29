import 'package:flutter/material.dart';

import '../providers/device_provider.dart';
import './device_screen.dart';

class Device1View extends StatelessWidget {
  const Device1View({super.key});

  @override
  Widget build(BuildContext context) {
    return const DeviceScreen<Device1Provider>(deviceName: "Device 1");
  }
}
