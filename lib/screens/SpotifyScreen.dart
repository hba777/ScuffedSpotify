import 'package:flutter/material.dart';

class SongScreen extends StatefulWidget {
  final String? accessToken;
  final String? imageUrl;

  const SongScreen({Key? key, required this.accessToken, this.imageUrl}) : super(key: key);

  @override
  _SongScreenState createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  //Don't need this
  String songId = '';

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
            widget.imageUrl!.isNotEmpty
                ? Image.network(
              widget.imageUrl!,
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
