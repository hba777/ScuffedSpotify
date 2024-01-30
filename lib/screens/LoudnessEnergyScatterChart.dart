import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LoudnessEnergyScatterChart extends StatelessWidget {
  final List<LoudnessEnergyData> data;

  LoudnessEnergyScatterChart({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set the background color of the whole screen
      appBar: AppBar(
        title: Text('Loudness vs Energy Scatter Chart'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: SfCartesianChart(
          plotAreaBackgroundColor: Colors.black,
          // Set the background color of the chart
          series: [
            // Use BubbleSeries for a bubble chart
            BubbleSeries<LoudnessEnergyData, double>(
              dataSource: data,
              xValueMapper: (LoudnessEnergyData point, _) => point.loudness,
              yValueMapper: (LoudnessEnergyData point, _) => point.energy,
              sizeValueMapper: (LoudnessEnergyData point, _) => 3.0,
              pointColorMapper: (LoudnessEnergyData point, _) {

                if (point.energy > 0.1 && point.energy <0.2) {
                  return Colors.grey;
                } else if (point.energy > 0.2 && point.energy <0.3){
                  return Colors.red[400];
                } else if (point.energy > 0.3 && point.energy <0.4){
                  return Colors.blue[800];
                } else if (point.energy > 0.4 && point.energy <0.5){
                  return Colors.teal[400];
                } else if (point.energy > 0.5 && point.energy <0.6){
                  return Colors.pinkAccent;
                } else if (point.energy > 0.6 && point.energy <0.7){
                  return Colors.pink[900];
                } else if (point.energy > 0.7 && point.energy <0.8){
                  return Colors.teal[400];
                } else {
                  return Colors.blue[800];
                }
              },
              borderColor: Colors.white, // Set the border color for the bubbles
              borderWidth: 0.5, // Set the width of the border
              dataLabelSettings: DataLabelSettings(
                isVisible: true,
                labelAlignment: ChartDataLabelAlignment.top,
              ),
            ),
          ],
          primaryXAxis: NumericAxis(title: AxisTitle(text: 'Loudness')),
          primaryYAxis: NumericAxis(title: AxisTitle(text: 'Energy',
              textStyle: TextStyle(color: Colors.white)),
          labelStyle: TextStyle(color: Colors.white),),
        ),

      ),
    );
  }
}

class LoudnessEnergyData {
  final double loudness;
  final double energy;

  LoudnessEnergyData(this.loudness, this.energy);
}
