import 'package:flutter/material.dart';

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
    return TextFormField(
      controller: _controllers[key],
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        suffixText: suffix,
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Enter a value';
        final parsed = num.tryParse(value);
        if (parsed == null) return 'Invalid number';
        return null;
      },
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
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            const Text(
              'Path Loss Simulation',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                SizedBox(
                  width: 220,
                  child: _inputField('Distance', 'distance', suffix: 'm'),
                ),
                SizedBox(
                  width: 220,
                  child: _inputField('Concrete Walls', 'cWalls'),
                ),
                SizedBox(
                  width: 220,
                  child: _inputField('Wooden Walls', 'wWalls'),
                ),
                SizedBox(
                  width: 220,
                  child: _inputField('CO₂', 'co2', suffix: 'ppm'),
                ),
                SizedBox(
                  width: 220,
                  child: _inputField('Humidity', 'humidity', suffix: '%'),
                ),
                SizedBox(
                  width: 220,
                  child: _inputField('PM2.5', 'pm25', suffix: 'µg/m³'),
                ),
                SizedBox(
                  width: 220,
                  child: _inputField('Pressure', 'pressure', suffix: 'hPa'),
                ),
                SizedBox(
                  width: 220,
                  child: _inputField(
                    'Temperature',
                    'temperature',
                    suffix: '°C',
                  ),
                ),
                SizedBox(
                  width: 220,
                  child: _inputField('Frequency', 'frequency', suffix: 'Hz'),
                ),
                SizedBox(
                  width: 220,
                  child: _inputField('SNR', 'snr', suffix: 'dB'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton.icon(
                onPressed: _calculate,
                icon: const Icon(Icons.calculate),
                label: const Text('Calculate Path Loss'),
              ),
            ),
            if (_result != null) ...[
              const SizedBox(height: 30),
              Center(
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
    );
  }
}
