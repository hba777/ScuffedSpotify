import 'dart:convert';
import 'package:http/http.dart' as http;

class APIs{
  static String nodeServerUrl = '8404-38-7-184-186.ngrok-free.app';

  static Future<List<dynamic>> fetchData() async {
    var url = Uri.https(nodeServerUrl, '/get_data');

    // var url =
    // Uri.https('$nodeServerUrl/get_data');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      // Parse the JSON data
      List<dynamic> data = json.decode(response.body);
      // Parse the JSON data For key level so indiviual data can be shown
      //List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(json.decode(response.body));


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