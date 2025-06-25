import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  // List<DeviceData> device 1 to device 6 = ?; They are variable instances?
  // obtained from LoraAPI; Listen to MQTT; If it is of a certain device, get the lora API and feed it in the "Device * Data"

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, cons) {
          final width = cons.maxWidth;
          final height = cons.maxHeight;

          return Column(
            children: [
              Expanded(
                child: Row(
                  children: List.generate(3, (index) {
                    return Expanded(
                      child: _buildDeviceCard(index + 1),
                    );
                  }),
                ),
              ),
              Expanded(
                child: Row(
                  children: List.generate(3, (index) {
                    return Expanded(
                      child: _buildDeviceCard(index + 4),
                    );
                  }),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDeviceCard(int deviceNumber) {
    final List<Color> cardColors = [
      Colors.green, Colors.black, Colors.yellow,
      Colors.red, Colors.brown, Colors.grey,
    ];

    // todo Replace with device card and the data; Should be the same format
    return Container(
      margin: const EdgeInsets.all(8.0),
      color: cardColors[deviceNumber - 1],
      child: Center(
        child: Text(
          'Device $deviceNumber',
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
