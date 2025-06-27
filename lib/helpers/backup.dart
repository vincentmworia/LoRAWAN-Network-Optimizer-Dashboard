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

  Widget _sectionTitle(String title) {
    final iconMap = {
      'Environment': Icons.thermostat,
      'Signal': Icons.network_check,
      'Obstacles': Icons.wallpaper,
      'Computed Path loss': Icons.functions,
    };
    final icon = iconMap[title] ?? Icons.info_outline;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12.0, bottom: 4.0),
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
          return Chip(
            label: Text(
              // todo This dash dash for null should be a placeholder with the actual length of the expected data!!!
              '${chip.label}: ${chip.value ?? '__'} ${chip.units ?? ''}',
              style: const TextStyle(
                fontSize: 13,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            backgroundColor: Colors.grey.shade200,
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
    final distance = deviceProvider.distance;
    final cWalls = deviceProvider.cWalls;
    final wWalls = deviceProvider.wWalls;

    final bandwidth = bandWidthCalculator(settings?.bandwidth);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: AppInfo.opaqueSecondaryColor(1),
      elevation: 4,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Chip(
              label: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.grey.shade200,
            ),

            _sectionTitle('Environment'),
            _rowOfDataChips([
              DataChipInfo(
                label: 'Temp',
                value: decoded?.temperature?.toStringAsFixed(2),
                units: '°C',
                lowerLimit: 18,
                upperLimit: 26,
              ),
              DataChipInfo(
                label: 'CO₂',
                value: decoded?.co2?.toStringAsFixed(0),
                units: 'ppm',
                lowerLimit: 400,
                upperLimit: 1000,
              ),
              DataChipInfo(
                label: 'Humidity',
                value: decoded?.humidity?.toStringAsFixed(2),
                units: '%',
                lowerLimit: 40,
                upperLimit: 60,
              ),
              DataChipInfo(
                label: 'PM2.5',
                value: decoded?.pm25?.toStringAsFixed(2),
                units: 'µg/m³',
                lowerLimit: 0,
                upperLimit: 5, // WHO air quality guideline (annual mean)
              ),
              DataChipInfo(
                label: 'Pressure',
                value: decoded?.pressure?.toStringAsFixed(2),
                units: 'hPa',
                lowerLimit: 980,
                upperLimit: 1050, // typical indoor atmospheric pressure
              ),
            ]),

            _sectionTitle('Signal'),
            _rowOfDataChips([
              DataChipInfo(
                label: 'SNR',
                value: rx?.snr?.toStringAsFixed(2),
                units: 'dB',
                lowerLimit: -20,
                upperLimit: 10,
              ),
              DataChipInfo(
                label: 'RSSI',
                value: rx?.rssi?.toStringAsFixed(2),
                units: 'dBm',
                lowerLimit: -120,
                upperLimit: -30, // typical LoRa range
              ),
              DataChipInfo(
                label: 'SF',
                value: settings?.spreadingFactor?.toStringAsFixed(2),
                lowerLimit: 7,
                upperLimit: 12,
              ),
              DataChipInfo(
                label: 'Bandwidth',

                value: bandwidth?['value'],
                units: bandwidth?['units'],
                lowerLimit: 125000,
                upperLimit: 500000,
              ),
            ]),

            _sectionTitle('Obstacles'),
            _rowOfDataChips([
              DataChipInfo(
                label: 'Distance',
                value: distance.toStringAsFixed(1),
              ),
              DataChipInfo(label: 'C-walls', value: cWalls.toStringAsFixed(1)),
              DataChipInfo(label: 'W-walls', value: wWalls.toStringAsFixed(1)),
            ]),

            _sectionTitle('Computed Path loss'),
            _rowOfDataChips([
              DataChipInfo(
                label: 'Path loss',
                value: deviceProvider.pathLoss?.toStringAsFixed(1),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
