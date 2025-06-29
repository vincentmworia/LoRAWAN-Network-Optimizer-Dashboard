import 'package:flutter/material.dart';
import 'package:lorawan/models/decoded_payload.dart';
import 'package:lorawan/models/rx_metadata.dart';
import 'package:lorawan/models/settings.dart';

import 'device_card.dart';
import '../models/data_limits.dart';

class DeviceScreenGaugeView extends StatelessWidget {
  const DeviceScreenGaugeView({
    super.key,
    required this.decodedPayload,
    required this.rxMetadata,
    required this.settings,
    required this.pathLoss,
  });

  final DecodedPayload? decodedPayload;
  final RxMetadata? rxMetadata;
  final Settings? settings;
  final num? pathLoss;

  Color _getGaugeColor(num? value, double min, double max) {
    if (value == null || value.isNaN) return DataLimits.nullColor;
    if (value < min) return DataLimits.lowColor;
    if (value > max) return DataLimits.highColor;
    return DataLimits.normalColor;
  }

  @override
  Widget build(BuildContext context) {
    final bandwidth = DeviceCard.freqCalculator(settings?.bandwidth);
    final frequency = DeviceCard.freqCalculator(
      settings == null ? null : num.parse(settings!.frequency!),
    );

    animatedGauge({
      required String label,
      required num? rawValue,
      required String unit,
      required double min,
      required double max,
    }) {
      final value = rawValue ?? double.nan;
      final percentage = value.isFinite
          ? ((value - min) / (max - min)).clamp(0.0, 1.0)
          : 0.0;
      final gaugeColor = _getGaugeColor(value, min, max);

      return TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: percentage),
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeOutCubic,
        builder: (context, animatedVal, _) {
          final displayValue = value.isFinite ? value : null;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: CircularProgressIndicator(
                      value: value.isFinite ? animatedVal : null,
                      strokeWidth: 8,
                      backgroundColor: Colors.grey.shade300,
                      valueColor: AlwaysStoppedAnimation<Color>(gaugeColor),
                    ),
                  ),
                  Text(
                    value.isFinite
                        ? '${displayValue!.toStringAsFixed(1)} $unit'
                        : '__',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: gaugeColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          );
        },
      );
    }

    return LayoutBuilder(
      builder: (context, cons) {
        final width = cons.maxWidth;
        return SizedBox(
          width: width,
          child: Wrap(
            alignment: WrapAlignment.spaceEvenly,
            runSpacing: 20,
            spacing: 20,
            children: [
              animatedGauge(
                label: 'Temp',
                rawValue: decodedPayload?.temperature,
                unit: '°C',
                min: DataLimits.tempMin,
                max: DataLimits.tempMax,
              ),
              animatedGauge(
                label: 'Humidity',
                rawValue: decodedPayload?.humidity,
                unit: '%',
                min: DataLimits.humidityMin,
                max: DataLimits.humidityMax,
              ),
              animatedGauge(
                label: 'CO₂',
                rawValue: decodedPayload?.co2?.toDouble(),
                unit: 'ppm',
                min: DataLimits.co2Min,
                max: DataLimits.co2Max,
              ),
              animatedGauge(
                label: 'PM2.5',
                rawValue: decodedPayload?.pm25,
                unit: 'µg/m³',
                min: DataLimits.pm25Min,
                max: DataLimits.pm25Max,
              ),
              animatedGauge(
                label: 'Pressure',
                rawValue: decodedPayload?.pressure,
                unit: 'hPa',
                min: DataLimits.pressureMin,
                max: DataLimits.pressureMax,
              ),
              animatedGauge(
                label: 'SNR',
                rawValue: rxMetadata?.snr,
                unit: 'dB',
                min: DataLimits.snrMin,
                max: DataLimits.snrMax,
              ),
              animatedGauge(
                label: 'RSSI',
                rawValue: rxMetadata?.rssi,
                unit: 'dBm',
                min: DataLimits.rssiMin,
                max: DataLimits.rssiMax,
              ),
              animatedGauge(
                label: 'SF',
                rawValue: settings?.spreadingFactor?.toDouble(),
                unit: '',
                min: DataLimits.sfMin,
                max: DataLimits.sfMax,
              ),
              animatedGauge(
                label: 'Freq',
                rawValue: frequency == null
                    ? null
                    : double.tryParse(frequency['value']!),
                unit: frequency?['units'] ?? '',
                min: DataLimits.freqMin,
                max: DataLimits.freqMax,
              ),
              animatedGauge(
                label: 'BW',
                rawValue: bandwidth == null
                    ? null
                    : double.tryParse(bandwidth['value']!),
                unit: bandwidth?['units'] ?? '',
                min: DataLimits.bwMin,
                max: DataLimits.bwMax,
              ),
              animatedGauge(
                label: 'Path Loss',
                rawValue: pathLoss?.toDouble(),
                unit: 'dB',
                min: DataLimits.pathLossMin,
                max: DataLimits.pathLossMax,
              ),
            ],
          ),
        );
      },
    );
  }
}
