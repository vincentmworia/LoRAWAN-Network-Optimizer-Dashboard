import 'package:flutter/material.dart';

class DeviceSmallInfo extends StatelessWidget {
  const DeviceSmallInfo({
    super.key,
    required this.appWidth,
    required this.appHeight,
  });

  final double appWidth;
  final double appHeight;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "Dimensions of width and height of the app must be greater than (600,550Px). Current value: ($appWidth,${appHeight}Px)",
        ),
      ),
    );
  }
}
