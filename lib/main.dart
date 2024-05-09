import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ChartWidget(),
      ),
    );
  }
}

class ChartWidget extends StatelessWidget {
  ChartWidget({super.key});

  final List<ChartData> chartData = [
    ChartData('David', 25, const Color.fromARGB(255, 168, 214, 16),
        trackColor: const Color.fromARGB(255, 196, 226, 183)),
    ChartData('Steve', 38, const Color.fromARGB(255, 32, 247, 43),
        trackColor: Colors.grey),
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 300,
        child: SfCircularChart(
          series: <CircularSeries>[
            RadialBarSeries<ChartData, String>(
              onCreateRenderer: (series) {
                return _CustomRadialBarSeriesRenderer(chartData: chartData);
              },
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              pointColorMapper: (ChartData data, _) => data.color,
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomRadialBarSeriesRenderer
    extends RadialBarSeriesRenderer<ChartData, String> {
  _CustomRadialBarSeriesRenderer({required this.chartData});

  final List<ChartData> chartData;

  @override
  void customizeSegment(ChartSegment segment) {
    super.customizeSegment(segment);
    final RadialBarSegment radialBarSegment = segment as RadialBarSegment;
    segment.trackFillPaint.color =
        chartData[radialBarSegment.currentSegmentIndex]
            .trackColor!
            .withOpacity(trackOpacity);
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color, {this.trackColor});
  final String x;
  final double y;
  final Color color;
  final Color? trackColor;
}
