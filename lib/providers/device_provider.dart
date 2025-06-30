import 'package:flutter/foundation.dart';

import '../helpers/path_loss_computation.dart';
import '../models/lora_api.dart';
import '../widgets/device_card.dart';

class MetricEntry {
  final DateTime timestamp;
  final num? value;

  MetricEntry(this.timestamp, this.value);
}

class DeviceProvider with ChangeNotifier {
  LoraApi? _deviceData;

  LoraApi? get deviceData => _deviceData;

  num? _pathLoss;
  num _distance = 5;
  num _cWalls = 6;
  num _wWalls = 7;

  num? get pathLoss => _pathLoss;

  num get distance => _distance;

  num get cWalls => _cWalls;

  num get wWalls => _wWalls;

  static const Duration historyWindow = Duration(hours: 1);

  // Metric histories
  final List<MetricEntry> pathLossHistory = [];
  final List<MetricEntry> temperatureHistory = [];
  final List<MetricEntry> co2History = [];
  final List<MetricEntry> humidityHistory = [];
  final List<MetricEntry> pm25History = [];
  final List<MetricEntry> pressureHistory = [];
  final List<MetricEntry> snrHistory = [];
  final List<MetricEntry> rssiHistory = [];
  final List<MetricEntry> sfHistory = [];
  final List<MetricEntry> bwHistory = [];
  final List<MetricEntry> freqHistory = [];

  void setDistance(int newDistance) {
    _distance = newDistance;
    notifyListeners();
  }

  void setCWalls(int newCWalls) {
    _cWalls = newCWalls;
    notifyListeners();
  }

  void setWWalls(int newWWalls) {
    _wWalls = newWWalls;
    notifyListeners();
  }

  void _prune(List<MetricEntry> list) {
    final cutoff = DateTime.now().subtract(historyWindow);
    list.removeWhere((entry) => entry.timestamp.isBefore(cutoff));
  }

  void _addEntry(List<MetricEntry> list, num? value) {
    list.add(MetricEntry(DateTime.now(), value));
    _prune(list);
  }

  void updateData(LoraApi newData) {
    _deviceData = newData;

    final decodedPayload = _deviceData!.uplinkMessage!.decodedPayload!;
    final rxMetadata = _deviceData!.uplinkMessage!.rxMetadata!;
    final settings = _deviceData!.uplinkMessage!.settings!;

    _pathLoss = PathLossComputation.estimatePathLoss(
      distance: _distance,
      cWalls: _cWalls,
      wWalls: _wWalls,
      co2: decodedPayload.co2!,
      humidity: decodedPayload.humidity!,
      pm25: decodedPayload.pm25!,
      pressure: decodedPayload.pressure!,
      temperature: decodedPayload.temperature!,
      snr: rxMetadata.snr!,
      frequency: num.parse(settings.frequency!),
    );

    final bandwidth = DeviceCard.freqCalculator(settings.bandwidth)!['value'];
    final frequency = DeviceCard.freqCalculator(
      num.parse(settings.frequency!),
    )!['value'];
    // Save to history & access via graphs
    _addEntry(pathLossHistory, _pathLoss);
    _addEntry(temperatureHistory, decodedPayload.temperature);
    _addEntry(co2History, decodedPayload.co2);
    _addEntry(humidityHistory, decodedPayload.humidity);
    _addEntry(pm25History, decodedPayload.pm25);
    _addEntry(pressureHistory, decodedPayload.pressure);
    _addEntry(snrHistory, rxMetadata.snr);
    _addEntry(rssiHistory, rxMetadata.rssi);
    _addEntry(sfHistory, settings.spreadingFactor);
    _addEntry(bwHistory, num.tryParse(bandwidth ?? '0'));

    _addEntry(freqHistory, num.tryParse(frequency ?? '0'));

    notifyListeners();
  }
}

// Extendable per device
class Device1Provider extends DeviceProvider {}

class Device2Provider extends DeviceProvider {}

class Device3Provider extends DeviceProvider {}

class Device4Provider extends DeviceProvider {}

class Device5Provider extends DeviceProvider {}

class Device6Provider extends DeviceProvider {}
