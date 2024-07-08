import 'package:flutter/material.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RoadAttCircleGraph extends StatefulWidget {
  const RoadAttCircleGraph({super.key});

  @override
  State<RoadAttCircleGraph> createState() => _RoadAttCircleGraphState();
}

class _RoadAttCircleGraphState extends State<RoadAttCircleGraph> {
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;
  @override
  void initState() {
    data = [
      _ChartData('Pass', 200, const Color.fromARGB(255, 255, 166, 1)),
      _ChartData('Fail', 70, const Color.fromARGB(255, 15, 51, 255)),
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(tooltipBehavior: _tooltip, series: [
      DoughnutSeries<_ChartData, String>(
          innerRadius: '70%',
          strokeColor: cWhite,
          strokeWidth: 2,
          dataLabelSettings: const DataLabelSettings(
              isVisible: true), // Renders the data label
          dataSource: data,
          xValueMapper: (_ChartData data, _) => data.x,
          yValueMapper: (_ChartData data, _) => data.y,
          pointColorMapper: (data, index) => data.color,
          name: 'Road Attendance')
    ]);
  }
}

class _ChartData {
  _ChartData(this.x, this.y, this.color);
  final Color color;
  final String x;
  final double y;
}
