import './uplink_message.dart';

class LoraApi {
  DateTime? receivedAt;
  String? endDeviceId;
  UplinkMessage? uplinkMessage;
  int? distance;
  int? cWalls;
  int? wWalls;

  LoraApi({
    required this.receivedAt,
    required this.endDeviceId,
    required this.uplinkMessage,
  });

  // todo set the values of distance, cwalls and wwalls of the different instances; update in the providers in MQTT or here?
  // void setDistance(int val) {
  //   distance = val;
  // }
  // void setCWalls(int val) {
  //   cWalls = val;
  // }
  // void setWWalls(int val) {
  //   wWalls = val;
  // }

  static LoraApi fromMap(Map<String, dynamic> json) => LoraApi(
    receivedAt: DateTime.parse(json['received_at']),
    endDeviceId: json['end_device_ids']['device_id'] as String,
    uplinkMessage: UplinkMessage.fromMap(json['uplink_message']),
  );

  Map<String, dynamic> toMap() => {
    "end_device_ids": endDeviceId!,
    "received_at": receivedAt!.toIso8601String(),
    "uplink_message": {
      "session_key_id": uplinkMessage!.sessionKeyId!,
      "f_port": uplinkMessage!.fPort!,
      "f_cnt": uplinkMessage!.fCnt!,
      "frm_payload": uplinkMessage!.frmPayload!,
      "decoded_payload": uplinkMessage!.decodedPayload!.toMap(),
      "rx_metadata": uplinkMessage!.rxMetadata!.toMap(),
      "settings": {
        "bandwidth": uplinkMessage!.settings!.bandwidth!,
        "spreading_factor": uplinkMessage!.settings!.spreadingFactor!,
        "coding_rate": uplinkMessage!.settings!.codingRate!,
      },
    },
  };
}
