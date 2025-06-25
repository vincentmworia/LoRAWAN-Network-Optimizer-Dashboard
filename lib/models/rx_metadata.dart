class RxMetadata {
  String gatewayId;
  String eui;
  DateTime receivedAt;
  num rssi;
  num channelRssi;
  num snr;

  RxMetadata({
    required this.gatewayId,
    required this.eui,
    required this.receivedAt,
    required this.rssi,
    required this.channelRssi,
    required this.snr,
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
        ),
      )
      .toList()
      .firstWhere((e) => e.gatewayId == "kerlink001");
}
