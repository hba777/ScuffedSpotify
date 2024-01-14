import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/song_class.dart';

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
    static Future<void> getSongDetailsAndUpdateModel(String accessToken, AutoGenerate autoGenerate) async {
      final String songName = autoGenerate.empName;
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
        autoGenerate.setEmpUrl(imageUrl);
      } else {
        print('Error getting song details: ${response.statusCode}');
        print(response.body);
      }
    }


    //This is server
    static String nodeServerUrl = 'https://366c-38-7-191-75.ngrok-free.app';

    static Future<List<AutoGenerate>> fetchData() async {
      var url = Uri.parse('$nodeServerUrl/get_data');

      final response = await http.get(url);
      if (response.statusCode == 200) {
        // Parse the JSON data
        print('Response data: ${response.body}');

        List<dynamic> jsonData = json.decode(response.body);

        // Map the data to your model
        List<AutoGenerate> data = jsonData.map((item) => AutoGenerate.fromJson(item)).toList();

        // Fetch song details and update empUrl for each AutoGenerate instance
        String? accessToken = await getAccessToken();
        for (AutoGenerate autoGenerate in data) {
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