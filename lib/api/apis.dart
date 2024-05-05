import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:scuffed_spotify/models/album_class.dart';
import '../models/song_class.dart';
import '../screens/DanceabilityEnergyScatterChart.dart';
import '../screens/LoudnessEnergyScatterChart.dart';
import '../screens/YearlyChart.dart';

class APIs{
  //This is server url
  static String nodeServerUrl = 'https://abd0-205-164-131-4.ngrok-free.app';

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
  static Future<void> getSongDetailsAndUpdateModel(String accessToken, Songs autoGenerate) async {
    final String songName = autoGenerate.trackName;
    final String apiUrl = 'https://api.spotify.com/v1/search';

    final http.Response response = await http.get(
      Uri.parse('$apiUrl?q=$songName&type=track'),
      headers: {
        'Authorization': 'Bearer ${accessToken}',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final Map<String, dynamic> track = jsonResponse['tracks']['items'][0];
      final String imageUrl = track['album']['images'][0]['url'];

      // Update the empUrl attribute in the AutoGenerate instance
      autoGenerate.setUrl(imageUrl);
    } else {
      print('Error getting song details: ${response.statusCode}');
      print(response.body);
    }
  }

  static Future<List<YearlySongCount>> fetchYearlySongCount() async {
    var url = Uri.parse('$nodeServerUrl/get_yearly_song_count');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      List<YearlySongCount> data = jsonData.map((item) => YearlySongCount(item['year'], item['count'])).toList();

      return data;
    } else {
      print('Failed to load yearly song count data. Status code: ${response.statusCode}');
      throw Exception('Failed to load data');
    }
  }
  static Future<List<LoudnessEnergyData>> fetchLoudnessEnergyData() async {
    var url = Uri.parse('$nodeServerUrl/get_loudness_enerygy');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      List<LoudnessEnergyData> data = jsonData.map((item) {
        return LoudnessEnergyData(
          item['loudness'],
          item['energy'],
        );
      }).toList();

      return data;
    } else {
      print('Failed to load loudness and energy data. Status code: ${response.statusCode}');
      throw Exception('Failed to load data');
    }
  }


  static Future<List<DanceabilityEnergyData>> fetchDanceabilityEnergyData() async {
    var url = Uri.parse('$nodeServerUrl/get_danceability_energy');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      List<DanceabilityEnergyData> data = jsonData.map((item) {
        return DanceabilityEnergyData(
          item['danceability'], // Replace with the actual key for danceability in your response
          item['energy'],       // Replace with the actual key for energy in your response
        );
      }).toList();

      return data;
    } else {
      print('Failed to load danceability and energy data. Status code: ${response.statusCode}');
      throw Exception('Failed to load data');
    }
  }


  //Get Sql Song Data
  static Future<List<Songs>> fetchData() async {
    var url = Uri.parse('$nodeServerUrl/get_top_tracks/:count');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      // Parse the JSON data
      print('Response data: ${response.body}');

      List<dynamic> jsonData = json.decode(response.body);

      // Map the data to your model
      List<Songs> data = jsonData.map((item) => Songs.fromJson(item)).toList();

      // Fetch song details and update empUrl for each AutoGenerate instance
      String? accessToken = await getAccessToken();
      for (Songs autoGenerate in data) {
        await getSongDetailsAndUpdateModel(accessToken!, autoGenerate);
      }

      // Print the data to the console
      print('Fetched data: $data');

      return data;
    } else {
      // Log an error message to the console
      print('Failed to load data. Status code: ${response.statusCode}');
      throw Exception('Failed to load data');
    }
  }

  //Get Sql Album Data
  static Future<List<Albums>> fetchAlbumData() async {
    var url = Uri.parse('$nodeServerUrl/get_albums');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      // Parse the JSON data
      print('Response data: ${response.body}');

      List<dynamic> jsonData = json.decode(response.body);

      // Map the data to your model
      List<Albums> data = jsonData.map((item) => Albums.fromJson(item)).toList();
      // Fetch song details and update empUrl for each AutoGenerate instance
      String? accessToken = await getAccessToken();
      for (Albums autoGenerateAlbums in data) {
        await getAlbumDetailsAndUpdateModel(accessToken!, autoGenerateAlbums);
      }

      // Print the data to the console
      print('Fetched data: $data');

      return data;
    } else {
      // Log an error message to the console
      print('Failed to load data. Status code: ${response.statusCode}');
      throw Exception('Failed to load data');
    }
  }

  //Get Album Image Data
  static Future<void> getAlbumDetailsAndUpdateModel(String accessToken, Albums autoGenerateAlbums) async {
    final String albumName = autoGenerateAlbums.trackAlbumName; // Assuming you have an 'albumName' property in your AutoGenerateAlbums class
    final String apiUrl = 'https://api.spotify.com/v1/search';

    final http.Response response = await http.get(
      Uri.parse('$apiUrl?q=$albumName&type=album'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final Map<String, dynamic> album = jsonResponse['albums']['items'][0];
      final String imageUrl = album['images'][0]['url'];

      // Update the empUrl attribute in the AutoGenerate instance
      autoGenerateAlbums.setUrl(imageUrl);
    } else {
      print('Error getting album details: ${response.statusCode}');
      print(response.body);
    }
  }


  //Get PlayList Image Data
  static Future<String?> fetchPlaylistImage(String playlistId) async {
    String? accessToken = await getAccessToken();

    try {
      final response = await http.get(
        Uri.parse("https://api.spotify.com/v1/playlists/$playlistId"),
        headers: {"Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final String imageUrl = data['images'][0]['url'];

        return imageUrl;
      } else {
        print('Failed to load playlist image');
      }
    } catch (e) {
      print('Error: $e');
    }
    return null;
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