import 'dart:math';

class PathLossComputation {
  // todo later access data from machine learning model or local server;

  static num estimatePathLossNahshon(num rssi) => 14 - 0.14 + 0.4 + 3 - rssi;

  static num estimatePathLossVincent({
    required num distance, // meters
    required num cWalls, // number of concrete walls
    required num wWalls, // number of wooden walls
    required num co2, // ppm
    required num humidity, // percentage
    required num pm25, // µg/m³
    required num pressure, // hPa
    required num temperature, // °C
    required num frequency, // Hz
    required num snr, // dB
  }) =>
      40 + // base constant (e.g., free space loss offset)
      10 *
          log(distance) /
          ln10 + // logarithmic effect of distance (converted to log10)
      9.74 * cWalls + // effect per concrete wall
      2.64 * wWalls + // effect per wooden wall
      0.001 * co2 + // slight contribution from CO₂ levels
      0.02 * humidity + // relative humidity impact
      0.03 * pm25 + // particulate matter impact
      0.01 *
          (pressure - 1000)
              .abs() + // pressure deviation from baseline (1000 hPa)
      0.1 *
          (temperature - 22)
              .abs() + // temperature deviation from baseline (22°C)
      0.1 * (frequency / 1e6) + // frequency in MHz (scaled realistically)
      (-1.2) * snr; // SNR improvement reduces path loss
}
