import 'package:flutter/material.dart';

import '../models/app_info.dart';
import '../models/data_limits.dart';
import '../helpers/path_loss_computation.dart';

class SimulationView extends StatefulWidget {
  const SimulationView({super.key});

  @override
  State<SimulationView> createState() => _SimulationViewState();
}

class _SimulationViewState extends State<SimulationView> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {
    'distance': TextEditingController(),
    'cWalls': TextEditingController(),
    'wWalls': TextEditingController(),
    'co2': TextEditingController(),
    'humidity': TextEditingController(),
    'pm25': TextEditingController(),
    'pressure': TextEditingController(),
    'temperature': TextEditingController(),
    'frequency': TextEditingController(),
    'snr': TextEditingController(),
  };

  num? _result;

  void _calculate() {
    if (_formKey.currentState?.validate() ?? false) {
      final result = PathLossComputation.estimatePathLoss(
        distance: double.parse(_controllers['distance']!.text),
        cWalls: int.parse(_controllers['cWalls']!.text),
        wWalls: int.parse(_controllers['wWalls']!.text),
        co2: double.parse(_controllers['co2']!.text),
        humidity: double.parse(_controllers['humidity']!.text),
        pm25: double.parse(_controllers['pm25']!.text),
        pressure: double.parse(_controllers['pressure']!.text),
        temperature: double.parse(_controllers['temperature']!.text),
        frequency: double.parse(_controllers['frequency']!.text),
        snr: double.parse(_controllers['snr']!.text),
      );
      setState(() {
        _result = result;
      });
    }
  }

  Widget _inputField(String label, String key, {String? suffix}) {
    return SizedBox(
      width: 220,
      child: TextFormField(
        controller: _controllers[key],
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          suffixText: suffix,
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Enter a value';
          final parsed = num.tryParse(value);
          if (parsed == null) return 'Invalid number';
          return null;
        },
      ),
    );
  }

  @override
  void dispose() {
    for (var c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  'Simulated Path Loss View',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                    letterSpacing: 3.0,
                    color: AppInfo.appPrimaryColor,
                  ),
                  // style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  children: [
                    _inputField('Distance', 'distance', suffix: 'm'),
                    _inputField('Concrete Walls', 'cWalls'),
                    _inputField('Wooden Walls', 'wWalls'),
                    _inputField('CO₂', 'co2', suffix: 'ppm'),
                    _inputField('Humidity', 'humidity', suffix: '%'),
                    _inputField('PM2.5', 'pm25', suffix: 'µg/m³'),
                    _inputField('Pressure', 'pressure', suffix: 'hPa'),
                    _inputField('Temperature', 'temperature', suffix: '°C'),
                    _inputField('Frequency', 'frequency', suffix: 'Hz'),
                    _inputField('SNR', 'snr', suffix: 'dB'),
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: _calculate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade100,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppInfo.appPrimaryColor,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Colors.grey),
                      ),
                      elevation: 2,
                    ),
                    icon: const Icon(
                      Icons.calculate,
                      color: AppInfo.appPrimaryColor,
                    ),
                    label: const Text('Calculate Path Loss'),
                  ),
                ),

                if (_result != null) ...[
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: _result! > DataLimits.pathLossMax
                          ? AppInfo.opaqueColor(DataLimits.highColor, 0.1)
                          : _result! < DataLimits.pathLossMin
                          ? AppInfo.opaqueColor(DataLimits.lowColor, 0.1)
                          : AppInfo.opaqueColor(DataLimits.normalColor, 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _result! > DataLimits.pathLossMax
                            ? DataLimits.highColor
                            : _result! < DataLimits.pathLossMin
                            ? DataLimits.lowColor
                            : DataLimits.normalColor,
                      ),
                    ),
                    child: Text(
                      'Estimated Path Loss: ${_result!.toStringAsFixed(2)} dB',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: _result! > DataLimits.pathLossMax
                            ? DataLimits.highColor
                            : _result! < DataLimits.pathLossMin
                            ? DataLimits.lowColor
                            : DataLimits.normalColor,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
