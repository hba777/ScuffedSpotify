import 'package:scuffed_spotify/screens/SongData.dart';

import '../models/song_class.dart';
import '../api/apis.dart';

import 'package:flutter/material.dart';
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<AutoGenerate>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = APIs.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data from API'),
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
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  AutoGenerate tappedItem = data[index]; // Get the specific item for the tapped widget

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => Charts(auto: tappedItem)),
                      );
                    },
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ID: ${tappedItem.empID}'),
                          Text('Name: ${tappedItem.empName}'),
                          // Display the image from the empUrl if not null
                          if (tappedItem.empUrl != null)
                            Image.network(tappedItem.empUrl!),
                        ],
                      ),
                    ),
                  );
                },
              );

            }
          },
        ),
      ),
    );
  }


}
