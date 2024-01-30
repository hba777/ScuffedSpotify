import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DanceabilityEnergyScatterChart extends StatelessWidget {
  final List<DanceabilityEnergyData> data;

  DanceabilityEnergyScatterChart({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Danceability vs Energy Scatter Chart'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: SfCartesianChart(
          plotAreaBackgroundColor: Colors.black,
          primaryXAxis: NumericAxis(
            title: AxisTitle(text: 'Loudness'),
            majorTickLines: MajorTickLines(color: Colors.white),
          ),
          primaryYAxis: NumericAxis(
            labelStyle: TextStyle(color: Colors.white),
            title: AxisTitle(text: 'Energy',textStyle: TextStyle(color: Colors.white)),
            majorTickLines: MajorTickLines(color: Colors.white),
          ),
          series: [
            BubbleSeries<DanceabilityEnergyData, double>(
              dataSource: data,
              minimumRadius: 7,
              maximumRadius: 7,
              xValueMapper: (DanceabilityEnergyData point, _) => point.danceability,
              yValueMapper: (DanceabilityEnergyData point, _) => point.energy,
              pointColorMapper: (DanceabilityEnergyData point, _) {
                if (point.danceability > 0.1 && point.danceability < 0.65) {
                  return Colors.blue[900];
                } else {
                  return Colors.pinkAccent;
                }
              },
              borderColor: Colors.black,
              borderWidth: 1,
              dataLabelSettings: DataLabelSettings(
                isVisible: true,
                labelAlignment: ChartDataLabelAlignment.top,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DanceabilityEnergyData {
  final double danceability;
  final double energy;

  DanceabilityEnergyData(this.danceability, this.energy);
}
