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
                  return ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ID: ${data[index].empID}'),
                        Text('Name: ${data[index].empName}'),
                        // Display the image from the empUrl if not null
                        if (data[index].empUrl != null)
                          Image.network(data[index].empUrl!),
                      ],
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
