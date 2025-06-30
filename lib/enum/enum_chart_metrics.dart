enum ChartMetric {
  temperature,
  humidity,
  co2,
  pm25,
  pressure,
  snr,
  rssi,
  sf,
  bw,
  freq,
  pathLoss,
}

extension ChartMetricLabel on ChartMetric {
  String get label {
    switch (this) {
      case ChartMetric.temperature:
        return "Temperature (°C)";
      case ChartMetric.humidity:
        return "Humidity (%)";
      case ChartMetric.co2:
        return "CO₂ (ppm)";
      case ChartMetric.pm25:
        return "PM2.5 (µg/m³)";
      case ChartMetric.pressure:
        return "Pressure (hPa)";
      case ChartMetric.snr:
        return "SNR (dB)";
      case ChartMetric.rssi:
        return "RSSI (dBm)";
      case ChartMetric.sf:
        return "Spreading Factor";
      case ChartMetric.bw:
        return "Bandwidth (kHz)";
      case ChartMetric.freq:
        return "Frequency (MHz)";
      case ChartMetric.pathLoss:
        return "Path Loss (dB)";
    }
  }
}
