import 'package:flutter/material.dart';
import '../models/album_class.dart';
import '../models/song_class.dart';
import '../api/apis.dart';
import 'DanceabilityEnergyScatterChart.dart';
import 'LoudnessEnergyScatterChart.dart';
import 'LoudnessEnergyScatterChart.dart';
import 'SearchScreen.dart';
import 'YearlyChart.dart';
import 'ChartsScreen.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Songs>> futureData;
  late Future<List<Albums>> futureAlbumData;

  @override
  void initState() {
    super.initState();
    futureData = APIs.fetchData();
    futureAlbumData = APIs.fetchAlbumData();
  }

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
          backgroundColor: Colors.black, // Set the background color of the entire app bar to black
          title: Text(
            'Good Morning!',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Center(
          child: FutureBuilder<List<Songs>>(
            future: futureData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<Songs> data = snapshot.data ?? [];
      
                // Sort the data based on trackPopularity in descending order
                data.sort((a, b) => b.trackPopularity.compareTo(a.trackPopularity));
      
                // Take only the top 10 tracks
                List<Songs> top10Data = data.take(10).toList();
      
                return Container(
                  color: Colors.black, // Set the background color to purple
                  child: ListView(
                    children: [
                      // Display AutoGenerate data (Top 10 Songs)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'TOP 15 SONGS',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 4,vertical: 10),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: (top10Data.length / 2).ceil(),
                        itemBuilder: (context, index) {
                          int startIndex = index * 2;
                          int endIndex = (index + 1) * 2;
                          endIndex = endIndex > top10Data.length ? top10Data.length : endIndex;
      
                          return Row(
                            children: List.generate(endIndex - startIndex, (i) {
                              Songs tappedItem = top10Data[startIndex + i];
      
                              return Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => ChartsScreen(auto: tappedItem)),
                                    );
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
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
      
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          'Popularity: ${tappedItem.trackPopularity}',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          'Artist: ${tappedItem.trackArtist}',
                                          style: TextStyle(
                                            color: Colors.white,
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
                      FutureBuilder<List<Albums>>(
                        future: futureAlbumData,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            List<Albums> albumData = snapshot.data?.take(10).toList() ?? [];
      
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      'TOP 15 ALBUMS',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                ListView.builder(
                                  padding: EdgeInsets.symmetric(horizontal: 4,vertical: 4),
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: (albumData.length / 2).ceil(),
                                  itemBuilder: (context, index) {
                                    int startIndex = index * 2;
                                    int endIndex = (index + 1) * 2;
                                    endIndex = endIndex > albumData.length ? albumData.length : endIndex;


                                    return Row(
                                      children: List.generate(endIndex - startIndex, (i) {
                                        Albums album = albumData[startIndex + i];

                                        return Expanded(
                                          child: Card(
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
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
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                                SizedBox(height: 8),
                                                Text(
                                                  'Release Date: ${album.trackAlbumReleaseDate}',
                                                  style: TextStyle(
                                                    color: Colors.white,
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

                                Center(child: Text('Charts',
                                style: TextStyle(color: Colors.white,
                                fontSize: 30)
                                  ,)
                                  ,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        // Fetch yearly song count data before navigating
                                        List<YearlySongCount> yearlySongCount = await APIs.fetchYearlySongCount();

                                        print('Yearly Song Count: $yearlySongCount');

                                        // Navigate to the YearlyChart screen
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (_) => YearlyChart(data: yearlySongCount)),
                                        );
                                      },
                                      child: Card(
                                        color: Colors.grey[900],
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.bar_chart,
                                              color: Colors.white,
                                              size: 50.0,
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              'Yearly Song Count',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        try {
                                          // Fetch loudness and energy data before navigating
                                          List<LoudnessEnergyData> loudnessEnergyData = await APIs.fetchLoudnessEnergyData();

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (_) => LoudnessEnergyScatterChart(data: loudnessEnergyData)),
                                          );
                                        } catch (e) {
                                          print('Error fetching loudness and energy data: $e');
                                          // Handle the error as needed
                                        }
                                      },
                                      child: Card(
                                        color: Colors.grey[900],
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.scatter_plot,
                                              color: Colors.white,
                                              size: 50.0,
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              'Loudness vs Energy',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                GestureDetector(
                                  onTap: () async {
                                    // Fetch danceability and energy data before navigating
                                    List<DanceabilityEnergyData> danceabilityEnergyData = await APIs.fetchDanceabilityEnergyData();

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => DanceabilityEnergyScatterChart(data: danceabilityEnergyData)),
                                    );
                                  },
                                  child: Card(
                                    color: Colors.grey[900],
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.scatter_plot,
                                          color: Colors.white,
                                          size: 50.0,
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          'Danceability vs Energy',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                              ],
                            );
      
                          }
                        },
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
          bottomNavigationBar: BottomAppBar(
              color: Colors.black,
              shape: CircularNotchedRectangle(),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: Icon(Icons.home, color: Colors.deepPurpleAccent[100],
                          size: 35),
                      onPressed: () {
                        // Navigate to the home screen or perform home-related actions
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.search, color: Colors.deepPurpleAccent[100],
                        size: 35,),
                      onPressed: () {
                        // Navigate to the search screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SearchScreen(
                            futureData: futureData,
                            futureAlbumData: futureAlbumData,
                          )),
                        );
                      },
                    ),
                  ]
              )
          )
      ),
    );
  }
}
