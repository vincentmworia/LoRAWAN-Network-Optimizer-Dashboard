class DecodedPayload {
  num? co2;
  num? humidity;
  num? packetCount;
  num? pm25;
  num? pressure;
  num? temperature;

  DecodedPayload({
    required this.co2,
    required this.humidity,
    required this.packetCount,
    required this.pm25,
    required this.pressure,
    required this.temperature,
  });

  static DecodedPayload fromMap(Map<String, dynamic> json) => DecodedPayload(
    co2: json['co2'] as num,
    humidity: json['humidity'] as num,
    packetCount: json['packetCount'] as num,
    pm25: json['pm25'] as num,
    pressure: json['pressure'] as num,
    temperature: json['temperature'] as num,
  );

  Map<String, dynamic> toMap() => {
    "co2": co2,
    "humidity": humidity,
    "packetCount": packetCount,
    "pm25": pm25,
    "pressure": pressure,
    "temperature": temperature,
  };
}
