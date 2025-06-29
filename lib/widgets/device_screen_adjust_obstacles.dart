import 'package:flutter/material.dart';
import '../providers/device_provider.dart';

import '../models/app_info.dart';

class DeviceScreenAdjustObstacles extends StatefulWidget {
  const DeviceScreenAdjustObstacles({super.key, required this.provider});

  final DeviceProvider provider;

  @override
  State<DeviceScreenAdjustObstacles> createState() =>
      _DeviceScreenAdjustObstaclesState();
}

class _DeviceScreenAdjustObstaclesState
    extends State<DeviceScreenAdjustObstacles> {
  final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _cWallsController = TextEditingController();
  final TextEditingController _wWallsController = TextEditingController();

  Widget _editableField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
          SizedBox(
            width: 100,
            child: TextField(
              controller: controller,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                filled: true,
                fillColor: Colors.white12,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _distanceController.text = widget.provider.distance.toStringAsFixed(1);
    _cWallsController.text = widget.provider.cWalls.toStringAsFixed(1);
    _wWallsController.text = widget.provider.wWalls.toStringAsFixed(1);

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppInfo.opaquePrimaryColor(0.6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Adjust Obstacles",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Column(
            children: [
              _editableField("Distance (m)", _distanceController),
              _editableField("C-Walls", _cWallsController),
              _editableField("W-Walls", _wWallsController),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    final d = double.tryParse(_distanceController.text);
                    final c = double.tryParse(_cWallsController.text);
                    final w = double.tryParse(_wWallsController.text);
                    if (d != null) widget.provider.setDistance(d.toInt());
                    if (c != null) widget.provider.setCWalls(c.toInt());
                    if (w != null) widget.provider.setWWalls(w.toInt());
                  },
                  child: const Text('OK'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
