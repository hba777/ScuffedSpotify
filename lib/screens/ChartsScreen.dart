import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:spotify/spotify.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:scuffed_spotify/api/apis.dart'; // Import your APIs file
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import '../models/song_class.dart'; // Import your AutoGenerate class

class ChartsScreen extends StatefulWidget {
  final Songs auto;

  ChartsScreen({required this.auto});

  @override
  _ChartsScreenState createState() => _ChartsScreenState();
}

class _ChartsScreenState extends State<ChartsScreen> {
  final player = AudioPlayer();
  bool isPlaying = false;
  Duration? duration;
  Duration? lastPosition;

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void onSliderChanged(double value) {
    setState(() {
      lastPosition = Duration(seconds: value.toInt());
      player.seek(lastPosition!);
    });
  }

  Future<void> togglePlayPause() async {
    if (isPlaying == false) {
      if (lastPosition != null) {
        player.seek(lastPosition!);
      } else {
        await _playSong();
      }
    } else {
      lastPosition = await player.getCurrentPosition();
      player.stop();
    }

    setState(() {
      isPlaying = !isPlaying;
    });
  }

  Future<void> _playSong() async {
    final yt = YoutubeExplode();
    const String clientId = 'd65f6211807049fe97cf6eb23ceea7e5';
    const String clientSecret = '101aa97ef3214b279e29c5aeee414dd0';
    final credentials = SpotifyApiCredentials(clientId, clientSecret);
    final spotify = SpotifyApi(credentials);
    final track = await spotify.tracks.get(widget.auto.trackId);
    String? songname = track.name;

    final result = (await yt.search.search(songname!)).first;
    final videoId = result.id.value;
    setState(() {
      duration = result.duration;
    });

    var manifest = await yt.videos.streamsClient.getManifest(videoId);
    var audioUrl = await manifest.audioOnly.first.url;
    player.play(UrlSource(audioUrl.toString()));
  }
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white), // Set back button color to white
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.blueGrey[900],
        appBar: AppBar(
          title: Text('Chart for ${widget.auto.trackName}', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blueGrey,
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
                  overflowMode: LegendItemOverflowMode.wrap// Set legend text color to white
                ),
                series: <DoughnutSeries<Map<String, dynamic>, String>>[
                  DoughnutSeries<Map<String, dynamic>, String>(
                    dataSource: [
                      {'metric': 'Energy', 'value': widget.auto.energy},
                      {'metric': 'Loudness', 'value': widget.auto.loudness},
                      {'metric': 'Key', 'value': widget.auto.keyValue},
                      {'metric': 'Mode', 'value': widget.auto.modeValue},
                      {'metric': 'Speechiness', 'value': widget.auto.speechiness},
                      {'metric': 'Acousticness', 'value': widget.auto.acousticness},
                      {'metric': 'Instrumentalness', 'value': widget.auto.instrumentalness},
                      {'metric': 'Liveness', 'value': widget.auto.liveness},
                      {'metric': 'Valence', 'value': widget.auto.valence},
                    ],
                    xValueMapper: (Map<String, dynamic> data, _) => data['metric'],
                    yValueMapper: (Map<String, dynamic> data, _) => double.parse(data['value'].toString()),
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
        bottomNavigationBar: BottomAppBar(
          height: 100,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(width: 8.0),
              Expanded(
                child: StreamBuilder<Duration>(
                  stream: player.onPositionChanged,
                  builder: (context, snapshot) {
                    Duration currentPosition = snapshot.data ?? Duration.zero;
                    return ProgressBar(
                      timeLabelTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      progress: currentPosition,
                      total: duration ?? const Duration(minutes: 4),
                      baseBarColor: Colors.deepPurpleAccent,
                      progressBarColor: Colors.deepPurpleAccent[100],
                      onSeek: (duration) {
                        player.seek(duration);
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.deepPurpleAccent, width: 4),
                      ),
                      child: IconButton(
                        icon: Icon(
                          isPlaying ? Icons.stop_rounded : Icons.play_arrow,
                          color: Colors.deepPurpleAccent[100],
                          size: 35,
                        ),
                        onPressed: togglePlayPause,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
