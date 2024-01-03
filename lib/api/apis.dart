import 'dart:convert';
import 'package:http/http.dart' as http;

class APIs{
  //Function to get spotify api token
    static Future<String?> getAccessToken() async {
    const String clientId = 'd65f6211807049fe97cf6eb23ceea7e5';
    const String clientSecret = '101aa97ef3214b279e29c5aeee414dd0';

    // Spotify API token endpoint URL
    final String tokenUrl = 'https://accounts.spotify.com/api/token';

    // Create the authorization header
    final String basicAuth =
        'Basic ${base64Encode(utf8.encode('$clientId:$clientSecret'))}';

      // Send the POST request to get the access token
      final http.Response response = await http.post(
        Uri.parse(tokenUrl),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': basicAuth,
        },
        body: {
          'grant_type': 'client_credentials',
        },
      );
    // Parse the response
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final String accessToken = jsonResponse['access_token'];
      return accessToken;
    } else {
      // Handle error, print or log the response for debugging
      print('Error requesting access token: ${response.statusCode}');
      print(response.body);
      return null;
    }
    }

    //Function to get song details
    static Future<String?> getSongDetails(String accessToken) async {
    // Replace 'YOUR_SONG_NAME' with the name of the song you want to search for
    final String songName = 'The Search';

    // Spotify API endpoint to search for a track
    final String apiUrl = 'https://api.spotify.com/v1/search';

    // Make a GET request to search for the song
    final http.Response response = await http.get(
      Uri.parse('$apiUrl?q=$songName&type=track'),
      headers: {
        'Authorization': 'Bearer ${accessToken}',
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

      return imageUrl;
    } else {
      // Handle error, print or log the response for debugging
      print('Error getting song details: ${response.statusCode}');
      print(response.body);
    }
  }

  //This is server
  static String nodeServerUrl = '5d5e-205-164-132-73.ngrok-free.app';

  static Future<List<dynamic>> fetchData() async {
    var url = Uri.https(nodeServerUrl, '/get_data');

    // var url =
    // Uri.https('$nodeServerUrl/get_data');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      // Parse the JSON data
      List<dynamic> data = json.decode(response.body);
      // Parse the JSON data For key level so individual data can be shown
      //List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(json.decode(response.body));

      //Call the getSongDetails here and store returned value in object

      // Print the data to the console
      print('Fetched data: $data');

      return data;
    } else {
      // Log an error message to the console
      print('Failed to load data. Status code: ${response.statusCode}');
      throw Exception('Failed to load data');
    }
  }

// Future<void> updateData(int id, String newData) async {
//   final response = await http.post(
//     '$nodeServerUrl/update_data',
//     headers: {'Content-Type': 'application/json'},
//     body: jsonEncode({'id': id, 'newData': newData}),
//   );
//
//   if (response.statusCode != 200) {
//     throw Exception('Failed to update data');
//   }
// }
}