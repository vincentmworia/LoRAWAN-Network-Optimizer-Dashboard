import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/device_screen_adjust_obstacles.dart';
import '../widgets/device_screen_gauge_view.dart';
import '../widgets/device_screen_chart_view.dart';
import '../providers/device_provider.dart';

class DeviceScreen<T extends DeviceProvider> extends StatelessWidget {
  const DeviceScreen({super.key, required this.deviceName});

  final String deviceName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<T>(
        builder: (context, provider, _) {
          final decodedPayload =
              provider.deviceData?.uplinkMessage?.decodedPayload;
          final rxMetadata = provider.deviceData?.uplinkMessage?.rxMetadata;
          final settings = provider.deviceData?.uplinkMessage?.settings;
          final pathLoss = provider.pathLoss;

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Gauges
                const SizedBox(height: 50),
                DeviceScreenGaugeView(
                  pathLoss: pathLoss,
                  decodedPayload: decodedPayload,
                  settings: settings,
                  rxMetadata: rxMetadata,
                ),
                const SizedBox(height: 50),
                const Divider(),

                /// Charts
                DeviceScreenChartView(provider),

                /// Adjust Obstacle Parameters
                DeviceScreenAdjustObstacles(provider: provider),
                const SizedBox(height: 50),
              ],
            ),
          );
        },
      ),
    );
  }
}
