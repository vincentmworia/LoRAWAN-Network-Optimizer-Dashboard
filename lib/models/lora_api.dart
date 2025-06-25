import './uplink_message.dart';

class LoraApi {
  String name;
  String uniqueId;
  DateTime time;
  DateTime receivedAt;
  String endDeviceId;
  UplinkMessage uplinkMessage;

  LoraApi({
    required this.name,
    required this.uniqueId,
    required this.time,
    required this.receivedAt,
    required this.endDeviceId,
    required this.uplinkMessage,
  });

  // todo Return API with the device name!!!! <From endDeviceId>
  static LoraApi fromMap(Map<String, dynamic> json) => LoraApi(
    name: json['name'] as String,
    uniqueId: json['unique_id'] as String,
    time: DateTime.parse(json['time']),
    receivedAt: DateTime.parse(json['data']['received_at']),
    endDeviceId: json['data']['end_device_ids']['device_id'] as String,
    uplinkMessage: UplinkMessage.fromMap(json['data']['uplink_message']),
  );
}
