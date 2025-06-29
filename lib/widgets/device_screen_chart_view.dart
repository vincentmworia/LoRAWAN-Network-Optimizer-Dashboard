import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../models/app_info.dart';
import '../models/decoded_payload.dart';

enum ChartMetric { pathLoss, temperature, co2 }

class _ChartData {
  final String time;
  final double value;

  _ChartData(this.time, this.value);
}

class DeviceScreenChartView extends StatefulWidget {
  const DeviceScreenChartView({
    super.key,
    required this.pathLoss,
    required this.decodedPayload,
  });

  final DecodedPayload? decodedPayload;
  final num? pathLoss;

  @override
  State<DeviceScreenChartView> createState() => _DeviceScreenChartViewState();
}

class _DeviceScreenChartViewState extends State<DeviceScreenChartView> {
  ChartMetric _selectedMetric = ChartMetric.pathLoss;

  List<_ChartData> _generateDummyGraph(num? latest) {
    final base = latest?.toDouble() ?? 90.0;
    return List.generate(10, (i) => _ChartData("T-\$i", base + i * 0.5));
  }

  List<_ChartData> getMetricData() {
    switch (_selectedMetric) {
      case ChartMetric.temperature:
        return _generateDummyGraph(widget.decodedPayload?.temperature);
      case ChartMetric.co2:
        return _generateDummyGraph(widget.decodedPayload?.co2);
      case ChartMetric.pathLoss:
        return _generateDummyGraph(widget.pathLoss);
    }
  }

  String getMetricTitle() {
    switch (_selectedMetric) {
      case ChartMetric.temperature:
        return "Temperature (°C)";
      case ChartMetric.co2:
        return "CO₂ (ppm)";
      case ChartMetric.pathLoss:
        return "Path Loss (dB)";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Chart Metric + Dropdown
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
                focusColor: Colors.transparent,
                // dropdownColor: Colors.white,
                underline: Container(height: 1, color: Colors.transparent),
                borderRadius: BorderRadius.circular(12),
                // elevation: 8,
                items: ChartMetric.values.map((metric) {
                  final isSelected = _selectedMetric == metric;

                  String metricLabel(ChartMetric metric) {
                    switch (metric) {
                      case ChartMetric.pathLoss:
                        return 'Path Loss';
                      case ChartMetric.temperature:
                        return 'Temperature';
                      case ChartMetric.co2:
                        return 'CO₂';
                    }
                  }

                  return DropdownMenuItem(
                    value: metric,
                    child: Text(
                      metricLabel(metric),
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
                  if (val != null) {
                    setState(() => _selectedMetric = val);
                  }
                },
              ),
            ],
          ),
        ),

        /// Chart
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
                  getMetricTitle(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 250,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: true,
                        horizontalInterval: 10,
                        verticalInterval: 1,
                        getDrawingHorizontalLine: (_) =>
                            FlLine(color: Colors.grey.shade300, strokeWidth: 1),
                        getDrawingVerticalLine: (_) =>
                            FlLine(color: Colors.grey.shade300, strokeWidth: 1),
                      ),
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 1,
                            getTitlesWidget: (value, _) {
                              final data = getMetricData();
                              final i = value.toInt();
                              return Text(
                                i >= 0 && i < data.length ? data[i].time : '',
                                style: const TextStyle(fontSize: 10),
                              );
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 36,
                            interval: 10,
                            getTitlesWidget: (value, _) => Text(
                              value.toStringAsFixed(0),
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
                          left: BorderSide(color: Colors.grey),
                          bottom: BorderSide(color: Colors.grey),
                        ),
                      ),
                      lineTouchData: LineTouchData(
                        touchTooltipData: LineTouchTooltipData(
                          getTooltipItems: (spots) {
                            final data = getMetricData();
                            return spots.map((spot) {
                              final label = data[spot.spotIndex].time;
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
                          spots: getMetricData()
                              .asMap()
                              .entries
                              .map(
                                (e) => FlSpot(e.key.toDouble(), e.value.value),
                              )
                              .toList(),
                          isCurved: true,
                          color: Colors.blueAccent,
                          barWidth: 3,
                          isStrokeCapRound: true,
                          dotData: FlDotData(show: false),
                          belowBarData: BarAreaData(
                            show: true,
                            gradient: LinearGradient(
                              colors: [
                                AppInfo.opaquePrimaryColor(0.3),
                                AppInfo.opaquePrimaryColor(0.3),
                                // AppInfo.opaquePrimaryColor(0.2),
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
