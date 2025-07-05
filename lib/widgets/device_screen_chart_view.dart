import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../helpers/app_info.dart';
import '../enum/enum_chart_metrics.dart';
import '../providers/device_provider.dart';

class _ChartData {
  final String time;
  final double value;

  _ChartData(this.time, this.value);
}

class DeviceScreenChartView extends StatefulWidget {
  const DeviceScreenChartView(this.provider, {super.key});

  final DeviceProvider provider;

  @override
  State<DeviceScreenChartView> createState() => _DeviceScreenChartViewState();
}

class _DeviceScreenChartViewState extends State<DeviceScreenChartView> {
  ChartMetric _selectedMetric = ChartMetric.pathLoss;

  List<_ChartData> _convertToChartData(List<MetricEntry> entries) {
    return entries.map((entry) {
      return _ChartData(
        '${entry.timestamp.hour}:${entry.timestamp.minute.toString().padLeft(2, '0')}',
        entry.value?.toDouble() ?? 0,
      );
    }).toList();
  }

  List<_ChartData> getMetricData(DeviceProvider provider) {
    switch (_selectedMetric) {
      case ChartMetric.temperature:
        return _convertToChartData(provider.temperatureHistory);
      case ChartMetric.humidity:
        return _convertToChartData(provider.humidityHistory);
      case ChartMetric.co2:
        return _convertToChartData(provider.co2History);
      case ChartMetric.pm25:
        return _convertToChartData(provider.pm25History);
      case ChartMetric.pressure:
        return _convertToChartData(provider.pressureHistory);
      case ChartMetric.snr:
        return _convertToChartData(provider.snrHistory);
      case ChartMetric.rssi:
        return _convertToChartData(provider.rssiHistory);
      case ChartMetric.sf:
        return _convertToChartData(provider.sfHistory);
      case ChartMetric.bw:
        return _convertToChartData(provider.bwHistory);
      case ChartMetric.freq:
        return _convertToChartData(provider.freqHistory);
      case ChartMetric.pathLoss:
        return _convertToChartData(provider.pathLossHistory);
    }
  }

  @override
  Widget build(BuildContext context) {
    final chartData = getMetricData(widget.provider);

    if (chartData.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(24.0),
        child: Center(
          child: Text(
            'No data available',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ),
      );
    }

    final yValues = chartData.map((e) => e.value).toList();
    final minDataY = yValues.reduce((a, b) => a < b ? a : b);
    final maxDataY = yValues.reduce((a, b) => a > b ? a : b);
    final range = (maxDataY - minDataY).abs();

    final buffer = range < 5 ? 2.5 : range * 0.1;
    final minY = minDataY - buffer;
    final maxY = maxDataY + buffer;

    final yInterval = ((maxY - minY) / 5).clamp(0.5, 20.0);
    final verticalInterval = (chartData.length / 12).ceilToDouble().clamp(
      1.0,
      double.infinity,
    );

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Metric Chart - For the past 1 hr",
                style: TextStyle(
                  fontSize: 20,
                  color: AppInfo.appPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              DropdownButton<ChartMetric>(
                value: _selectedMetric,
                style: TextStyle(color: AppInfo.appPrimaryColor),
                underline: Container(height: 0),
                focusColor: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                items: ChartMetric.values.map((metric) {
                  final isSelected = _selectedMetric == metric;
                  return DropdownMenuItem(
                    value: metric,
                    child: Text(
                      metric.label,
                      style: TextStyle(
                        color: isSelected
                            ? AppInfo.appSecondaryColor
                            : AppInfo.appPrimaryColor,
                        fontWeight: isSelected
                            ? FontWeight.w500
                            : FontWeight.normal,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null && _selectedMetric != val) {
                    setState(() => _selectedMetric = val);
                  }
                },
              ),
            ],
          ),
        ),
        Card(
          elevation: 2,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Text(
                  _selectedMetric.label,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppInfo.appPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 280,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LineChart(
                    LineChartData(
                      minY: minY,
                      maxY: maxY,
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: true,
                        horizontalInterval: yInterval,
                        verticalInterval: verticalInterval,
                      ),
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: verticalInterval,
                            getTitlesWidget: (value, _) {
                              final i = value.toInt();
                              return Text(
                                i >= 0 && i < chartData.length
                                    ? chartData[i].time
                                    : '',
                                style: const TextStyle(fontSize: 10),
                              );
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 36,
                            interval: yInterval,
                            getTitlesWidget: (value, _) => Text(
                              value.toStringAsFixed(1),
                              style: const TextStyle(fontSize: 10),
                            ),
                          ),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: const Border(
                          left: BorderSide(color: AppInfo.appPrimaryColor),
                          bottom: BorderSide(color: AppInfo.appPrimaryColor),
                        ),
                      ),
                      lineTouchData: LineTouchData(
                        touchTooltipData: LineTouchTooltipData(
                          getTooltipItems: (spots) {
                            return spots.map((spot) {
                              final label = chartData[spot.spotIndex].time;
                              return LineTooltipItem(
                                '$label\n${spot.y.toStringAsFixed(2)}',
                                const TextStyle(color: Colors.white),
                              );
                            }).toList();
                          },
                        ),
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          spots: chartData
                              .asMap()
                              .entries
                              .map(
                                (e) => FlSpot(e.key.toDouble(), e.value.value),
                              )
                              .toList(),
                          isCurved: true,
                          color: AppInfo.opaquePrimaryColor(0.6),
                          barWidth: 3,
                          isStrokeCapRound: true,
                          dotData: FlDotData(show: false),
                          belowBarData: BarAreaData(
                            show: true,
                            gradient: LinearGradient(
                              colors: [
                                AppInfo.opaquePrimaryColor(0.3),
                                Colors.transparent,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
