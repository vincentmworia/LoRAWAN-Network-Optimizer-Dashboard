class RxMetadata {
  String? gatewayId;
  String? eui;
  DateTime? receivedAt;
  num? rssi;
  num? channelRssi;
  num? snr;
  String? frequencyOffset;

  RxMetadata({
    required this.gatewayId,
    required this.eui,
    required this.receivedAt,
    required this.rssi,
    required this.channelRssi,
    required this.snr,
    required this.frequencyOffset,
  });

  static RxMetadata fromListOfMap(List list) => list
      .map(
        (json) => RxMetadata(
          gatewayId: json['gateway_ids']['gateway_id'],
          eui: json['gateway_ids']['eui'],
          receivedAt: DateTime.parse(json['received_at']),
          rssi: json['rssi'],
          channelRssi: json['channel_rssi'],
          snr: json['snr'],
          frequencyOffset: json['frequency_offset'],
        ),
      )
      .toList()[0];

  Map<String, dynamic> toMap() => {
    "gateway_id": gatewayId!,
    "eui": eui!,
    "received_at": receivedAt!,
    "rssi": rssi!,
    "channel_rssi": channelRssi!,
    "snr": snr!,
    "frequency_offset": frequencyOffset!,
  };
}
