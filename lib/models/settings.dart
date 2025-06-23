class Settings {
  num bandwidth;
  num spreadingFactor;
  String codingRate;
  DateTime time;

  Settings({
    required this.bandwidth,
    required this.spreadingFactor,
    required this.codingRate,
    required this.time,
  });

  static Settings fromMap(Map<String, dynamic> json) => Settings(
    bandwidth: json['data_rate']['lora']['bandwidth'],
    spreadingFactor: json['data_rate']['lora']['spreading_factor'],
    codingRate: json['data_rate']['lora']['coding_rate'],
    time: DateTime.parse(json['time']),
  );
}