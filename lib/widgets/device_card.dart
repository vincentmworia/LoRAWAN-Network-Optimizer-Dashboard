import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../enum/enum_my_pages.dart';
import '../providers/page_provider.dart';
import '../helpers/app_info.dart';
import '../models/data_limits.dart';
import '../models/data_chips_info.dart';
import '../providers/device_provider.dart';

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
        Container(
          color: Colors.white70,
          width: double.infinity,
          height: 0.5,
          margin: EdgeInsets.only(top: 5),
        ),
      ],
    );
  }

  Widget chip(String data) => Chip(
    label: Text(
      data,
      style: const TextStyle(fontSize: 13, overflow: TextOverflow.ellipsis),
    ),
    backgroundColor: Colors.grey.shade200,
  );

  Color getChipValueColor(DataChipInfo chip) {
    double? parsedValue = double.tryParse(chip.value ?? '');
    if (parsedValue == null) {
      return DataLimits.nullColor;
    }
    if (chip.lowerLimit != null && parsedValue < chip.lowerLimit!) {
      return DataLimits.lowColor;
    }
    if (chip.upperLimit != null && parsedValue > chip.upperLimit!) {
      return DataLimits.highColor;
    }
    return DataLimits.normalColor;
  }

  Widget _rowOfDataChips(List<DataChipInfo> chips) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Wrap(
        spacing: 12,
        runSpacing: 8,
        children: chips.map((chip) {
          final valueColor = getChipValueColor(chip);

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  chip.label,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFFD3D3D3),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 4),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${chip.value ?? chip.placeholder ?? '__'} ${chip.units ?? ''}',
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontWeight: chip.value == null
                          ? FontWeight.normal
                          : FontWeight.bold,
                      fontStyle: chip.value == null
                          ? FontStyle.italic
                          : FontStyle.normal,
                      fontSize: 13,
                      color: valueColor,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  static Map<String, String>? freqCalculator(num? bandwidth) {
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

    final bandwidth = DeviceCard.freqCalculator(settings?.bandwidth);
    final frequency = DeviceCard.freqCalculator(
      settings == null ? null : num.parse(settings.frequency!),
    );
    return Consumer<PageProvider>(
      builder: (_, pgProvider, child) => InkWell(
        onTap: () => pgProvider.setPage(getPageEnum(title)),
        borderRadius: BorderRadius.circular(20.0),
        hoverColor: AppInfo.opaquePrimaryColor(0.15),
        child: child,
      ),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: AppInfo.opaquePrimaryColor(0.6),
        elevation: 2,
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
                  const SizedBox(width: 6),
                  Text(
                    title,
                    style: const TextStyle(
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
                  lowerLimit: DataLimits.tempMin,
                  upperLimit: DataLimits.tempMax,
                ),
                DataChipInfo(
                  label: 'RH',
                  value: decoded?.humidity?.toStringAsFixed(2),
                  units: '%',
                  placeholder: '__.__',
                  lowerLimit: DataLimits.humidityMin,
                  upperLimit: DataLimits.humidityMax,
                ),
                DataChipInfo(
                  label: 'CO₂',
                  value: decoded?.co2?.toStringAsFixed(0),
                  units: 'ppm',
                  placeholder: '____',
                  lowerLimit: DataLimits.co2Min,
                  upperLimit: DataLimits.co2Max,
                ),
                DataChipInfo(
                  label: 'PM2.5',
                  value: decoded?.pm25?.toStringAsFixed(2),
                  units: 'µg/m³',
                  placeholder: '__.__',
                  lowerLimit: DataLimits.pm25Min,
                  upperLimit: DataLimits.pm25Max,
                ),
                DataChipInfo(
                  label: 'Pres',
                  value: decoded?.pressure?.toStringAsFixed(2),
                  units: 'hPa',
                  placeholder: '___._',
                  lowerLimit: DataLimits.pressureMin,
                  upperLimit: DataLimits.pressureMax,
                ),
              ]),
              _sectionTitle('Signal', Icons.network_check),
              _rowOfDataChips([
                DataChipInfo(
                  label: 'SNR',
                  value: rx?.snr?.toStringAsFixed(2),
                  units: 'dB',
                  placeholder: '__.__',
                  lowerLimit: DataLimits.snrMin,
                  upperLimit: DataLimits.snrMax,
                ),
                DataChipInfo(
                  label: 'RSSI',
                  value: rx?.rssi?.toStringAsFixed(2),
                  units: 'dBm',
                  placeholder: '___.__',
                  lowerLimit: DataLimits.rssiMin,
                  upperLimit: DataLimits.rssiMax,
                ),
                DataChipInfo(
                  label: 'SF',
                  value: settings?.spreadingFactor?.toStringAsFixed(2),
                  placeholder: '__.__',
                  lowerLimit: DataLimits.sfMin,
                  upperLimit: DataLimits.sfMax,
                ),
                DataChipInfo(
                  label: 'BW',
                  value: bandwidth?['value'],
                  units: bandwidth?['units'],
                  placeholder: '___._ KHz',
                  lowerLimit: DataLimits.bwMin,
                  upperLimit: DataLimits.bwMax,
                ),
                DataChipInfo(
                  label: 'Freq',
                  value: frequency?['value'],
                  units: frequency?['units'],
                  placeholder: '___._ MHz',
                  lowerLimit: DataLimits.freqMin,
                  upperLimit: DataLimits.freqMax,
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
                  units: 'dB',
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
