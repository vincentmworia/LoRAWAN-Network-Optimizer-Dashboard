class Settings {
  num? bandwidth;
  num? spreadingFactor;
  String? codingRate;
  String? frequency;

  Settings({
    required this.bandwidth,
    required this.spreadingFactor,
    required this.codingRate,
    required this.frequency,
  });

  static Settings fromMap(Map<String, dynamic> json) => Settings(
    bandwidth: json['data_rate']['lora']["bandwidth"],
    spreadingFactor: json['data_rate']['lora']['spreading_factor'],
    codingRate: json['data_rate']['lora']['coding_rate'],
    frequency: json['frequency'],
  );

  Map<String, dynamic> toMap() => {
    "bandwidth": bandwidth,
    "spreading_factor": spreadingFactor,
    "coding_rate": codingRate,
    "frequency": frequency,
  };
}
