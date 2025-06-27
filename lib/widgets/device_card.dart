import 'package:flutter/material.dart';
import 'package:lorawan/models/app_info.dart';
import '../providers/mqtt_provider.dart';
import '../models/data_chips_info.dart';

class DeviceCard extends StatelessWidget {
  final String title;
  final DeviceProvider deviceProvider;

  const DeviceCard({
    super.key,
    required this.title,
    required this.deviceProvider,
  });

  Widget _sectionTitle(String title, IconData icon) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Row(
            children: [
              Icon(icon, size: 18, color: Colors.white70),
              const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
        const Divider(thickness: 0.5, color: Colors.white70),
      ],
    );
  }

  Widget _rowOfDataChips(List<DataChipInfo> chips) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Wrap(
        spacing: 12,
        runSpacing: 8,
        children: chips.map((chip) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                chip.label,
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
              Text(
                //todo Work on here. Also, logic to see when the color is low or high, act accordingly
                '${chip.value ?? chip.placeholder ?? '__'} ${chip.units ?? ''}',
                style: TextStyle(
                  fontWeight: chip.value == null
                      ? FontWeight.normal
                      : FontWeight.bold,
                  color: chip.value == null ? Colors.grey : Colors.black87,
                  fontStyle: chip.value == null
                      ? FontStyle.italic
                      : FontStyle.normal,
                  fontSize: 13,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Map<String, String>? bandWidthCalculator(num? bandwidth) {
    if (bandwidth == null) return null;
    if (bandwidth >= 1e9) {
      return {'value': (bandwidth / 1e9).toStringAsFixed(1), 'units': 'GHz'};
    } else if (bandwidth >= 1e6) {
      return {'value': (bandwidth / 1e6).toStringAsFixed(1), 'units': 'MHz'};
    } else if (bandwidth >= 1e3) {
      return {'value': (bandwidth / 1e3).toStringAsFixed(1), 'units': 'kHz'};
    } else {
      return {'value': bandwidth.toStringAsFixed(0), 'units': 'Hz'};
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = deviceProvider.deviceData;
    final decoded = data?.uplinkMessage?.decodedPayload;
    final settings = data?.uplinkMessage?.settings;
    final rx = data?.uplinkMessage?.rxMetadata;
    final bandwidth = bandWidthCalculator(settings?.bandwidth);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      // todo primary or secondary opacity?
      color: AppInfo.opaquePrimaryColor(0.6),
      // color: AppInfo.opaqueSecondaryColor(0.8),
      elevation: 0,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.sensors, color: Colors.white70, size: 18),
                SizedBox(width: 6),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
            _sectionTitle('Environment', Icons.thermostat),
            _rowOfDataChips([
              DataChipInfo(
                label: 'Temp',
                value: decoded?.temperature?.toStringAsFixed(2),
                units: '°C',
                placeholder: '__.__',
                lowerLimit: 18,
                upperLimit: 26,
              ),
              DataChipInfo(
                label: 'RH',
                value: decoded?.humidity?.toStringAsFixed(2),
                units: '%',
                placeholder: '__.__',
                lowerLimit: 40,
                upperLimit: 60,
              ),
              DataChipInfo(
                label: 'CO₂',
                value: decoded?.co2?.toStringAsFixed(0),
                units: 'ppm',
                placeholder: '____',
                lowerLimit: 400,
                upperLimit: 1000,
              ),

              DataChipInfo(
                label: 'PM2.5',
                value: decoded?.pm25?.toStringAsFixed(2),
                units: 'µg/m³',
                placeholder: '__.__',
                lowerLimit: 0,
                upperLimit: 5,
              ),
              DataChipInfo(
                label: 'Pres',
                value: decoded?.pressure?.toStringAsFixed(2),
                units: 'hPa',
                placeholder: '___._',
                lowerLimit: 980,
                upperLimit: 1050,
              ),
            ]),

            _sectionTitle('Signal', Icons.network_check),
            _rowOfDataChips([
              DataChipInfo(
                label: 'SNR',
                value: rx?.snr?.toStringAsFixed(2),
                units: 'dB',
                placeholder: '__.__',
                lowerLimit: -20,
                upperLimit: 10,
              ),
              DataChipInfo(
                label: 'RSSI',
                value: rx?.rssi?.toStringAsFixed(2),
                units: 'dBm',
                placeholder: '___.__',
                lowerLimit: -120,
                upperLimit: -30,
              ),
              DataChipInfo(
                label: 'SF',
                value: settings?.spreadingFactor?.toStringAsFixed(2),
                placeholder: '__.__',
                lowerLimit: 7,
                upperLimit: 12,
              ),
              DataChipInfo(
                label: 'BW',
                value: bandwidth?['value'],
                units: bandwidth?['units'],
                placeholder: '___._ KHz',
                lowerLimit: 125000,
                upperLimit: 500000,
              ),
            ]),

            _sectionTitle('Obstacles', Icons.wallpaper),
            _rowOfDataChips([
              DataChipInfo(
                label: 'Distance',
                value: deviceProvider.distance.toStringAsFixed(1),
                placeholder: '_._',
              ),
              DataChipInfo(
                label: 'C-walls',
                value: deviceProvider.cWalls.toStringAsFixed(1),
                placeholder: '_._',
              ),
              DataChipInfo(
                label: 'W-walls',
                value: deviceProvider.wWalls.toStringAsFixed(1),
                placeholder: '_._',
              ),
            ]),

            _sectionTitle('Computed', Icons.functions),
            _rowOfDataChips([
              DataChipInfo(
                label: 'Path loss',
                value: deviceProvider.pathLoss?.toStringAsFixed(1),
                placeholder: '__._',
              ),
            ]),
          ],
        ),
      ),
    );
  }
}

/*
  static final _chipBackgroundColor = Colors.grey.shade200;
          Old Chip Data Display
Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: _chipBackgroundColor,
              // color: AppInfo.opaqueColor(Colors.white,0.95),
              borderRadius: BorderRadius.circular(20),
            ),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 13),
                children: [
                  TextSpan(
                    text: '${chip.label}: ',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: '$displayValue ${chip.units ?? ''}',
                    style: TextStyle(
                      color: chip.value == null ? Colors.grey : Colors.black87,
                      fontStyle: chip.value == null
                          ? FontStyle.italic
                          : FontStyle.normal,
                      fontWeight: chip.value == null
                          ? FontWeight.normal
                          : FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );

*/
