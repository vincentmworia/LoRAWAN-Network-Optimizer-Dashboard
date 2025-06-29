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

  static LoraApi fromMap(Map<String, dynamic> json) => LoraApi(
    receivedAt: DateTime.parse(json['received_at']),
    endDeviceId: json['end_device_ids']['device_id'] as String,
    uplinkMessage: UplinkMessage.fromMap(json['uplink_message']),
  );

  Map<String, dynamic> toMap() => {
    "end_device_ids": endDeviceId,
    "received_at": receivedAt?.toIso8601String(),
    "uplink_message": {
      "session_key_id": uplinkMessage?.sessionKeyId!,
      "f_port": uplinkMessage?.fPort,
      "f_cnt": uplinkMessage?.fCnt,
      "frm_payload": uplinkMessage?.frmPayload!,
      "decoded_payload": uplinkMessage?.decodedPayload?.toMap(),
      "rx_metadata": uplinkMessage?.rxMetadata?.toMap(),
      "settings": {
        "bandwidth": uplinkMessage?.settings?.bandwidth,
        "spreading_factor": uplinkMessage?.settings?.spreadingFactor!,
        "coding_rate": uplinkMessage?.settings?.codingRate!,
        "frequency": uplinkMessage?.settings?.frequency!,
      },
    },
  };
}
