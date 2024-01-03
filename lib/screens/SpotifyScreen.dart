import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SongScreen extends StatefulWidget {
  final String? accessToken;

  const SongScreen({Key? key, required this.accessToken}) : super(key: key);

  @override
  _SongScreenState createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  String songId = '';
  String imageUrl = '';

  @override
  void initState() {
    super.initState();
    // Call the function to get the song ID and URL when the screen is initialized
    getSongDetails();
  }

  Future<void> getSongDetails() async {
    // Replace 'YOUR_SONG_NAME' with the name of the song you want to search for
    final String songName = 'The Search';

    // Spotify API endpoint to search for a track
    final String apiUrl = 'https://api.spotify.com/v1/search';

    // Make a GET request to search for the song
    final http.Response response = await http.get(
      Uri.parse('$apiUrl?q=$songName&type=track'),
      headers: {
        'Authorization': 'Bearer ${widget.accessToken}',
      },
    );

    // Parse the response
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      // Get the first track from the search results
      final Map<String, dynamic> track = jsonResponse['tracks']['items'][0];

      // Extract the song ID and image URL
      final String songId = track['id'];
      final String imageUrl = track['album']['images'][0]['url'];

      // Set the obtained values in the state
      setState(() {
        this.songId = songId;
        this.imageUrl = imageUrl;
      });
    } else {
      // Handle error, print or log the response for debugging
      print('Error getting song details: ${response.statusCode}');
      print(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Song Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the image using the obtained URL
            imageUrl.isNotEmpty
                ? Image.network(
              imageUrl,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            )
                : const CircularProgressIndicator(),
            const SizedBox(height: 20),
            // Display additional information or UI elements
            Text('Song ID: $songId'),
            // ...
          ],
        ),
      ),
    );
  }
}
