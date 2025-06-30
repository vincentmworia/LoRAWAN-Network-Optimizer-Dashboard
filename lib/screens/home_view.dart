import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/device_card.dart';
import '../enum/enum_my_pages.dart';
import '../providers/device_provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceConsumers = const [
      _DeviceConsumer<Device1Provider>(title: PageNameString.device1),
      _DeviceConsumer<Device2Provider>(title: PageNameString.device2),
      _DeviceConsumer<Device3Provider>(title: PageNameString.device3),
      _DeviceConsumer<Device4Provider>(title: PageNameString.device4),
      _DeviceConsumer<Device5Provider>(title: PageNameString.device5),
      _DeviceConsumer<Device6Provider>(title: PageNameString.device6),
    ];

    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Wrap(
            spacing: width / 50,
            runSpacing: width / 50,
            children: deviceConsumers,
          ),
        ),
      ),
    );
  }
}

class _DeviceConsumer<T extends DeviceProvider> extends StatelessWidget {
  final String title;

  const _DeviceConsumer({required this.title});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Consumer<T>(
      builder: (_, dvProvider, _) => SizedBox(
        width:
            width /
            (width < 800
                ? 1.5
                : width < 1000
                ? 2
                : width < 1450
                ? 3
                : 3.6),
        child: DeviceCard(title: title, deviceProvider: dvProvider),
      ),
    );
  }
}
