import 'package:flutter/material.dart';
import 'package:lorawan/models/app_info.dart';
import 'package:lorawan/models/lora_api.dart';

class DeviceCard extends StatelessWidget {
  final String title;
  final LoraApi? data;

  const DeviceCard({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    final decoded = data?.uplinkMessage?.decodedPayload;
    final settings = data?.uplinkMessage?.settings;
    final rx = data?.uplinkMessage?.rxMetadata;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: AppInfo.opaqueSecondaryColor(1),
      elevation: 4,
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Chip(
              label: Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.grey.shade200,
            ),
            // todo show the data well here; account for distance; cwalls and wwalls;

            /* const SizedBox(height: 12),
            if (decoded != null)
              Wrap(
                spacing: 12,
                runSpacing: 8,
                children: [
                  _buildChip("Temp", "${decoded.temperature}°C"),
                  _buildChip("CO₂", "${decoded.co2} ppm"),
                  _buildChip("Humidity", "${decoded.humidity}%"),
                  _buildChip("PM2.5", "${decoded.pm25} μg/m³"),
                  _buildChip("Pressure", "${decoded.pressure} hPa"),
                  _buildChip("Packets", "${decoded.packetCount}"),
                ],
              ),
            const SizedBox(height: 8),
            if (rx != null || settings != null)
              Wrap(
                spacing: 12,
                runSpacing: 8,
                children: [
                  if (rx != null) ...[
                    _buildChip("RSSI", "${rx.rssi} dBm"),
                    _buildChip("SNR", "${rx.snr}"),
                    _buildChip("Gateway", rx.gatewayId ?? "-"),
                  ],
                  if (settings != null) ...[
                    _buildChip("SF", "${settings.spreadingFactor}"),
                    _buildChip("BW", "${settings.bandwidth}"),
                    _buildChip("CR", settings.codingRate ?? "-"),
                  ],
                ],
              ),*/
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String label, String value) {
    return Chip(
      label: Text("$label: $value"),
      backgroundColor: Colors.grey.shade200,
    );
  }
}

/*Red for CO₂ > threshold

Yellow for weak RSSI

Green for healthy packets*/
