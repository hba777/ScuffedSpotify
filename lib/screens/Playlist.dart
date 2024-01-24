import 'package:flutter/material.dart';
import 'package:scuffed_spotify/api/apis.dart';

late Size mq;

class Playlists extends StatefulWidget {
  const Playlists({super.key});

  @override
  State<Playlists> createState() => _PlaylistsState();
}

class _PlaylistsState extends State<Playlists> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spotify Playlist Images'),
      ),
      body: FutureBuilder(
        future: APIs.fetchPlaylistImage('3cEYpjA9oz9GiPac4AsH4n'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else {
            String imageUrl = snapshot.data as String;
            return Image.network(imageUrl);
          }
        },
      ),
    );
  }
}