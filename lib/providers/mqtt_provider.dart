import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:lorawan/models/lora_api.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import '../private_info.dart';

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

        try {
          final loraApi = LoraApi.fromMap(json.decode(message));
          final deviceId = loraApi.endDeviceId;

          print(loraApi.toMap());
          // print(loraApi.endDeviceId);

          final deviceMap = {
            'pilotdevice': deviceProviders[0],
            'pilotdevice01': deviceProviders[1],
            'pilotdevice02': deviceProviders[2],
            'pilotdevice03': deviceProviders[3],
            'pilotdevice04': deviceProviders[4],
            'pilotdevice05': deviceProviders[5],
          };

          if (deviceMap.containsKey(deviceId)) {
            deviceMap[deviceId]?.updateData(loraApi);
            timestampProvider.update(loraApi.receivedAt ?? DateTime.now());
          }
        } catch (e) {
          if (kDebugMode) print("JSON Decode Error: $e");
        }
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

  DateTime? get lastUpdated => _lastUpdated;

  void update(DateTime? timestamp) {
    _lastUpdated = timestamp;
    notifyListeners();
  }
}

class DeviceProvider with ChangeNotifier {
  LoraApi? _deviceData;

  LoraApi? get deviceData => _deviceData;

  void updateData(LoraApi newData) {
    print(newData.endDeviceId);
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
