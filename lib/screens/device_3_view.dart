import 'package:flutter/material.dart';

import './device_screen.dart';
import '../providers/device_provider.dart';

class Device3View extends StatelessWidget {
  const Device3View({super.key});

  @override
  Widget build(BuildContext context) {
    return const DeviceScreen<Device3Provider>(deviceName: "Device 3");
  }
}
