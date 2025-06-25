class Settings {
  num? bandwidth;
  num? spreadingFactor;
  String? codingRate;

  Settings({
    required this.bandwidth,
    required this.spreadingFactor,
    required this.codingRate,
  });

  static Settings fromMap(Map<String, dynamic> json) => Settings(
    bandwidth: json['bandwidth'],
    spreadingFactor: json['spreading_factor'],
    codingRate: json['coding_rate'],
  );

  Map<String, dynamic> toMap() => {
    "bandwidth": bandwidth!,
    "spreading_factor": spreadingFactor!,
    "coding_rate": codingRate!,
  };
}
