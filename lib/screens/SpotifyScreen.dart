import 'package:flutter/material.dart';
import 'package:scuffed_spotify/screens/SongData.dart';
import '../models/album_class.dart';
import '../models/song_class.dart';
import '../api/apis.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<AutoGenerate>> futureData;
  late Future<List<AutoGenerateAlbums>> futureAlbumData;

  @override
  void initState() {
    super.initState();
    futureData = APIs.fetchData();
    futureAlbumData = APIs.fetchAlbumData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Good Morning!'),
      ),
      body: Center(
        child: FutureBuilder<List<AutoGenerate>>(
          future: futureData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<AutoGenerate> data = snapshot.data ?? [];

              // Sort the data based on trackPopularity in descending order
              data.sort((a, b) => b.trackPopularity.compareTo(a.trackPopularity));

              // Take only the top 10 tracks
              List<AutoGenerate> top10Data = data.take(10).toList();

              return ListView(
                children: [
                  // Display AutoGenerate data (Top 10 Songs)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'TOP 10 SONGS',
                        style: TextStyle(
                          fontSize: 24,  // Increase font size for the heading
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: (top10Data.length / 2).ceil(),
                    itemBuilder: (context, index) {
                      int startIndex = index * 2;
                      int endIndex = (index + 1) * 2;
                      endIndex = endIndex > top10Data.length ? top10Data.length : endIndex;

                      return Row(
                        children: List.generate(endIndex - startIndex, (i) {
                          AutoGenerate tappedItem = top10Data[startIndex + i];

                          return Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => Charts(auto: tappedItem)),
                                );
                              },
                              child: Card(
                                color: Colors.grey[900],
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (tappedItem.url != null)
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          border: Border(top: BorderSide(color: Colors.black, width: 2.0)),
                                        ),
                                        child: Image.network(
                                          tappedItem.url!,
                                          width: double.infinity,
                                          height: 150,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Name: ${tappedItem.trackName}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'cursive',
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Popularity: ${tappedItem.trackPopularity}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'cursive',
                                      ),
                                    ),
                                    Text(
                                      'Artist: ${tappedItem.trackArtist}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'cursive',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      );
                    },
                  ),

                  // Leave some space before displaying the albums heading
                  SizedBox(height: 16),

                  // Display AutoGenerateAlbums data (Top 10 Albums)
                  FutureBuilder<List<AutoGenerateAlbums>>(
                    future: futureAlbumData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        List<AutoGenerateAlbums> albumData = snapshot.data?.take(10).toList() ?? [];

                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  'TOP 10 ALBUMS',
                                  style: TextStyle(
                                    fontSize: 24,  // Increase font size for the heading
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: (albumData.length / 2).ceil(),
                              itemBuilder: (context, index) {
                                int startIndex = index * 2;
                                int endIndex = (index + 1) * 2;
                                endIndex = endIndex > albumData.length ? albumData.length : endIndex;

                                return Row(
                                  children: List.generate(endIndex - startIndex, (i) {
                                    AutoGenerateAlbums album = albumData[startIndex + i];

                                    return Expanded(
                                      child: Card(
                                        color: Colors.grey[900],
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            if (album.url != null)
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  border: Border(top: BorderSide(color: Colors.black, width: 2.0)),
                                                ),
                                                child: Image.network(
                                                  album.url!,
                                                  width: double.infinity,
                                                  height: 150,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            SizedBox(height: 8),
                                            Text(
                                              'Album Name: ${album.trackAlbumName}',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'cursive',
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              'Release Date: ${album.trackAlbumReleaseDate}',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'cursive',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                );
                              },
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
