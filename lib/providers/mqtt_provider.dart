import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import '../private_info.dart';
import '../models/lora_api.dart';

enum ConnectionStatus { disconnected, connected }

class MqttProvider with ChangeNotifier {
  late MqttServerClient _mqttClient;

  MqttServerClient get mqttClient => _mqttClient;

  var _connStatus = ConnectionStatus.disconnected;

  ConnectionStatus get connectionStatus => _connStatus;

  List<DeviceProvider>? _cachedDeviceProviders;
  TimestampProvider? _cachedTimestampProvider;

  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  Future<ConnectionStatus> initializeMqttClient({
    required List<DeviceProvider> deviceProviders,
    required TimestampProvider timestampProvider,
  }) async {
    _cachedDeviceProviders = deviceProviders;
    _cachedTimestampProvider = timestampProvider;

    _setupConnectivityListener();

    final connMessage = MqttConnectMessage()
      ..authenticateAs(mqttUsername, mqttPassword)
      ..startClean()
      ..withWillQos(MqttQos.exactlyOnce);

    _mqttClient =
        MqttServerClient.withPort(
            mqttHost,
            'Lorawan Network Optimizer - UniqueId - ${DateTime.now().toIso8601String()}',
            mqttPort,
          )
          ..secure = false
          ..keepAlivePeriod = 60
          ..connectionMessage = connMessage
          ..onConnected = onConnected
          ..onDisconnected = onDisconnected;

    try {
      await _mqttClient.connect();
    } catch (e) {
      if (kDebugMode) {
        print('\n\nMQTT Connection Exception: $e');
      }
      _mqttClient.disconnect();
      _connStatus = ConnectionStatus.disconnected;
      notifyListeners();
      return _connStatus;
    }

    if (_mqttClient.connectionStatus?.state == MqttConnectionState.connected) {
      _mqttClient.subscribe(mqttTopic, MqttQos.exactlyOnce);

      _mqttClient.updates?.listen((List<MqttReceivedMessage<MqttMessage>> c) {
        final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
        final message = MqttPublishPayload.bytesToStringAsString(
          recMess.payload.message,
        );

        // try {
        final loraApi = LoraApi.fromMap(json.decode(message));
        final deviceId = loraApi.endDeviceId;

        print(loraApi.toMap());

        final deviceMap = {
          'pilotdevice': deviceProviders[0],
          'pilotdevice01': deviceProviders[1],
          'pilotdevice02': deviceProviders[2],
          'pilotdevice03': deviceProviders[3],
          'pilotdevice04': deviceProviders[4],
          'pilotdevice05': deviceProviders[5],
        };
        if (deviceMap.containsKey(deviceId)) {
          // todo distance, cwalls and wwalls info is there <From UI, but with default values>?
          // todo  Other info is there calculate the path loss from tensor flow model. Convert .pkl to tflite and link the model to flutter. In the meantime, dash it.
          deviceMap[deviceId]?.updateData(loraApi);
          timestampProvider.updateTime(loraApi.receivedAt ?? DateTime.now());
        }
        // } catch (e) {
        //   if (kDebugMode) print("JSON Decode Error: $e");
        // }
      });
    } else {
      _connStatus = ConnectionStatus.disconnected;
      notifyListeners();
    }
    return _connStatus;
  }

  void _setupConnectivityListener() {
    _connectivitySubscription?.cancel();
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
      result,
    ) async {
      final current = result.isNotEmpty
          ? result.first
          : ConnectivityResult.none;

      if (current == ConnectivityResult.none) {
        if (_connStatus == ConnectionStatus.connected) {
          _mqttClient.disconnect();
          onDisconnected();
        }
      } else {
        if (_connStatus == ConnectionStatus.disconnected &&
            _cachedDeviceProviders != null &&
            _cachedTimestampProvider != null) {
          await Future.delayed(const Duration(seconds: 2));
          initializeMqttClient(
            deviceProviders: _cachedDeviceProviders!,
            timestampProvider: _cachedTimestampProvider!,
          );
        }
      }
    });
  }

  void refresh() {
    notifyListeners();
  }

  void onConnected() {
    _connStatus = ConnectionStatus.connected;
    notifyListeners();
  }

  void onDisconnected() {
    _connStatus = ConnectionStatus.disconnected;
    notifyListeners();
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }
}

class TimestampProvider with ChangeNotifier {
  DateTime? _lastUpdated;
  bool _justUpdated = false;

  DateTime? get lastUpdated => _lastUpdated;

  bool get justUpdated => _justUpdated;

  void updateTime(DateTime? timestamp) {
    _lastUpdated = timestamp;
    _justUpdated = true;
    notifyListeners();

    Future.delayed(const Duration(seconds: 1), () {
      _justUpdated = false;
      notifyListeners();
    });
  }
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

  // todo This will change the static parameters at runtime, but reset when we restart the app
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
    // todo If all data is present,  calculate path loss using the data;
    // todo Use a function, that can be utilized when simulation in the simulation page

    _deviceData = newData;
    notifyListeners();
  }
}

class Device1Provider extends DeviceProvider {}

class Device2Provider extends DeviceProvider {}

class Device3Provider extends DeviceProvider {}

class Device4Provider extends DeviceProvider {}

class Device5Provider extends DeviceProvider {}

class Device6Provider extends DeviceProvider {}
