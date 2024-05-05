// search_screen.dart

import 'package:flutter/material.dart';
import 'package:scuffed_spotify/screens/ChartsScreen.dart';

import '../models/album_class.dart';
import '../models/song_class.dart';

class SearchScreen extends StatefulWidget {
  final Future<List<Songs>> futureData;
  final Future<List<Albums>> futureAlbumData;

  SearchScreen({
    required this.futureData,
    required this.futureAlbumData,
  });

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<Songs> filteredData = [];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white)
        )
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'Search Screen',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.black, // Set background color to black
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: searchController,
                style: TextStyle(color: Colors.white,
                fontSize: 25), // Set text color to white
                decoration: InputDecoration(
                  labelText: 'Enter Song Name',
                  labelStyle: TextStyle(color: Colors.white, fontSize: 20),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search, color: Colors.white),
                    onPressed: () {
                      filterData(searchController.text);
                    },
                  ),
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredData.length,
                  itemBuilder: (context, index) {
                    final song = filteredData[index];
                    return GestureDetector(
                      onTap: () {
                        // Navigate to another screen when the card is tapped
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChartsScreen(auto: song),
                          ),
                        );
                      },
                      child: Card(
                        color: Colors.grey[900], // Black background
                        child: ListTile(
                          leading: Image.network(
                            song.url!,
                            fit: BoxFit.cover,
                          ),
                          title: Text(
                            song.trackName,
                            style: TextStyle(color: Colors.deepPurpleAccent),
                          ),
                          subtitle: Text(
                            song.trackArtist,
                            style: TextStyle(color: Colors.white),
                          ),
                          // Add more details as needed
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void filterData(String searchText) {
    widget.futureData.then((data) {
      setState(() {
        filteredData = data
            .where((song) =>
            song.trackName.toLowerCase().contains(searchText.toLowerCase()))
            .toList();
      });
    });
  }
}

