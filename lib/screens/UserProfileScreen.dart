import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  final Map<String, dynamic> userData;

  const UserProfileScreen({Key? key, required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spotify User Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(userData['images'][0]['url']),
            ),
            const SizedBox(height: 20),
            Text(
              'Display Name: ${userData['display_name']}',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Email: ${userData['email']}',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Followers: ${userData['followers']['total']}',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Add logic to navigate to another screen or perform an action
              },
              child: const Text('Custom Action'),
            ),
          ],
        ),
      ),
    );
  }
}
