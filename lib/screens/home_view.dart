import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/mqtt_provider.dart';
import '../widgets/device_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: const [
                Expanded(
                  child: _DeviceConsumer<Device1Provider>(title: 'Device 1'),
                ),
                Expanded(
                  child: _DeviceConsumer<Device2Provider>(title: 'Device 2'),
                ),
                Expanded(
                  child: _DeviceConsumer<Device3Provider>(title: 'Device 3'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: const [
                Expanded(
                  child: _DeviceConsumer<Device4Provider>(title: 'Device 4'),
                ),
                Expanded(
                  child: _DeviceConsumer<Device5Provider>(title: 'Device 5'),
                ),
                Expanded(
                  child: _DeviceConsumer<Device6Provider>(title: 'Device 6'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DeviceConsumer<T extends DeviceProvider> extends StatelessWidget {
  final String title;

  const _DeviceConsumer({required this.title});

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(
      builder: (_, provider, _) =>
          DeviceCard(title: title, data: provider.deviceData),
    );
  }
}
