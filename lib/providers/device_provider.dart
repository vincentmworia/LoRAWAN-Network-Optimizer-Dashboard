import 'package:flutter/foundation.dart';

import '../helpers/path_loss_computation.dart';
import '../models/lora_api.dart';

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

  /// Estimates indoor LoRa path loss using environmental and signal factors.
  /// Note: This is a placeholder until the actual ML model (.tflite) is integrated.

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

  void updateData(LoraApi newData) {
    // todo get the lora
    // todo If all data is present,  calculate path loss using the data;
    // todo Use a function, that can be utilized when simulation in the simulation page

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
    notifyListeners();
  }
}

class Device1Provider extends DeviceProvider {}

class Device2Provider extends DeviceProvider {}

class Device3Provider extends DeviceProvider {}

class Device4Provider extends DeviceProvider {}

class Device5Provider extends DeviceProvider {}

class Device6Provider extends DeviceProvider {}
