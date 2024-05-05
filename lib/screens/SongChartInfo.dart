import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/song_class.dart';

class SongInfo extends StatefulWidget {
  final Songs auto;

  const SongInfo({super.key, required this.auto});

  @override
  State<SongInfo> createState() => _SongInfoState();
}

class _SongInfoState extends State<SongInfo> {
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
                color: Colors.white,), // Set back button color to white
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: Row(
              children: [
                Text('${widget.auto.trackName}',
                  style: TextStyle(color: Colors.white), maxLines: 1,),
                IconButton(onPressed: () {}, icon: Icon(Icons.info),
                  padding: EdgeInsets.only(left: 40),)
              ],
            ),
            backgroundColor: Colors.deepPurple.shade700
            ,
          ),

          body: Column(
            children: [
              // Add other UI elements if needed
              Expanded(
                child: SfCircularChart(
                  title: ChartTitle(
                    text: 'Song Properties',
                    textStyle: TextStyle(color: Colors.white,
                        fontSize: 20), // Set title text color to white
                  ),
                  legend: Legend(
                      isVisible: true,
                      textStyle: TextStyle(color: Colors.white,
                          fontSize: 20),
                      overflowMode: LegendItemOverflowMode
                          .wrap // Set legend text color to white
                  ),
                  series: <DoughnutSeries<Map<String, dynamic>, String>>[
                    DoughnutSeries<Map<String, dynamic>, String>(
                      dataSource: [
                        {'metric': 'Energy', 'value': widget.auto.energy},
                        {'metric': 'Loudness', 'value': widget.auto.loudness},
                        {'metric': 'Key', 'value': widget.auto.keyValue},
                        {'metric': 'Mode', 'value': widget.auto.modeValue},
                        {
                          'metric': 'Speechiness',
                          'value': widget.auto.speechiness
                        },
                        {
                          'metric': 'Acousticness',
                          'value': widget.auto.acousticness
                        },
                        {
                          'metric': 'Instrumentalness',
                          'value': widget.auto.instrumentalness
                        },
                        {'metric': 'Liveness', 'value': widget.auto.liveness},
                        {'metric': 'Valence', 'value': widget.auto.valence},
                      ],
                      xValueMapper: (Map<String, dynamic> data,
                          _) => data['metric'],
                      yValueMapper: (Map<String, dynamic> data, _) =>
                          double.parse(data['value'].toString()),
                      dataLabelSettings: DataLabelSettings(
                        isVisible: true,
                        textStyle: TextStyle(color: Colors.white,
                            fontSize: 10), // Set data label text color to white
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
