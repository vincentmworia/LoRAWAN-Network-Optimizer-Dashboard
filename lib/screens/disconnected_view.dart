import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/mqtt_provider.dart';
import '../providers/device_provider.dart';
import '../models/app_info.dart';
import '../providers/timestamp_provider.dart';

class DisconnectedView extends StatelessWidget {
  const DisconnectedView({super.key, required this.mqttProvider});

  final MqttProvider mqttProvider;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.cloud_off,
            size: 80,
            color: AppInfo.appSecondaryColor,
          ),
          const SizedBox(height: 20),
          const Text(
            'Disconnected from MQTT Broker',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 10),
          const CircularProgressIndicator(),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              mqttProvider.initializeMqttClient(
                deviceProviders: [
                  context.read<Device1Provider>(),
                  context.read<Device2Provider>(),
                  context.read<Device3Provider>(),
                  context.read<Device4Provider>(),
                  context.read<Device5Provider>(),
                  context.read<Device6Provider>(),
                ],
                timestampProvider: context.read<TimestampProvider>(),
              );
            },
            child: const Text(
              'Retry',
              style: TextStyle(color: AppInfo.appPrimaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
