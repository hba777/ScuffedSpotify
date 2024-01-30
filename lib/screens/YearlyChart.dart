import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class YearlySongCount {
  final int year;
  final int count;

  YearlySongCount(this.year, this.count);
}

class YearlyChart extends StatelessWidget {
  final List<YearlySongCount> data;

  YearlyChart({required this.data}) {
    print('YearlyChart Data: $data');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yearly Song Count'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container( // Wrap the body with a Container
        color: Colors.black, // Set the background color to black
        child: Center(
          child: SfCartesianChart(
            series: <CartesianSeries<dynamic, dynamic>>[
              // Use BarSeries for a bar chart
              BarSeries<YearlySongCount, int>(
                dataSource: data,
                xValueMapper: (YearlySongCount count, _) => count.year,
                yValueMapper: (YearlySongCount count, _) => count.count,
                pointColorMapper: (YearlySongCount count, _) {
                  // Customize color based on count value
                  if (count.count > 100) {
                    return Colors.teal[900];
                  } else if (count.count > 2) {
                    return Colors.red[900];
                  } else {
                    return Colors.indigo[600];
                  }
                },
                dataLabelSettings: DataLabelSettings(
                  isVisible: true, // Enable data labels
                  labelAlignment: ChartDataLabelAlignment.top, // Position labels
                ),
              ),
            ],
            primaryXAxis: CategoryAxis(
              interval: 1,
              labelStyle: TextStyle(color: Colors.white),
            ),
            primaryYAxis: NumericAxis(
              labelStyle: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
