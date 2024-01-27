import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scuffed_spotify/models/song_class.dart';
import 'package:scuffed_spotify/models/album_class.dart';

class Charts extends StatefulWidget {
  final AutoGenerate auto;

  Charts({Key? key, required this.auto}) : super(key: key);

  @override
  State<Charts> createState() => _ChartsState();
}

class _ChartsState extends State<Charts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Received object with ID: ${widget.auto.trackId}'),
      ),
    );
  }
}

class AlbumDetails extends StatefulWidget {
  final AutoGenerateAlbums album;

  AlbumDetails({Key? key, required this.album}) : super(key: key);

  @override
  State<AlbumDetails> createState() => _AlbumDetailsState();
}

class _AlbumDetailsState extends State<AlbumDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Album Name: ${widget.album.trackAlbumName}'),
            SizedBox(height: 16),
            Text('Release Date: ${widget.album.trackAlbumReleaseDate}'),
            SizedBox(height: 16),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}