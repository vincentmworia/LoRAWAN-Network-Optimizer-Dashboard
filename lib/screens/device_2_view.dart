import 'package:flutter/material.dart';

import './device_screen.dart';
import '../providers/device_provider.dart';

class Device2View extends StatelessWidget {
  const Device2View({super.key});

  @override
  Widget build(BuildContext context) {
    return const DeviceScreen<Device2Provider>(deviceName: "Device 2");
  }
}
