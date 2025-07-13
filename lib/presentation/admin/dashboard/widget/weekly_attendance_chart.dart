import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:my_presensi/data/models/response/admin/admin_dashboard_response_model.dart';

class WeeklyAttendanceChart extends StatelessWidget {
  final List<WeeklyAttendance>? data;

  const WeeklyAttendanceChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    if (data == null || data!.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Text('Tidak ada data grafik.'),
      );
    }

    return Container(
      height: 220,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 4)),
        ],
      ),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          barTouchData: BarTouchData(enabled: true),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, _) {
                  final index = value.toInt();
                  if (index < data!.length) {
                    return Text(data![index].date?.substring(0, 3) ?? '',
                        style: const TextStyle(fontSize: 10));
                  }
                  return const Text('');
                },
                reservedSize: 28,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 32),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
          barGroups: data!.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: (item.count ?? 0).toDouble(),
                  color: Colors.blue,
                  width: 16,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
