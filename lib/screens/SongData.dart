import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scuffed_spotify/models/song_class.dart';

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