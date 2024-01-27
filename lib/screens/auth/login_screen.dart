import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:scuffed_spotify/api/apis.dart';
import 'package:scuffed_spotify/screens/Albums_Screen.dart';
import 'package:scuffed_spotify/screens/Playlist.dart';
import 'package:scuffed_spotify/screens/SpotifyScreen.dart';
import '../../helpers/dailogs.dart';
import 'package:scuffed_spotify/models/song_class.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  bool _isAnimate = false;
  String? mail ='';

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isAnimate = true;
      });
    });
  }

  Future<String?> Check() async {
    String? accessToken = await APIs.getAccessToken();
    if (accessToken != null) {
      // Use the access token for authenticated requests
      print('Access Token: $accessToken');
    } else {
      // Handle the case where obtaining the access token failed
      print('Failed to get the access token');
    }
    return accessToken;
  }

  _handleGoogleBtnClick() {
    // Show Progress Bar
    Dialogs.showProgressBar(context);
  }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: const Text(
          "Scuffed Spotify",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(seconds: 1),
            alignment: Alignment.center,
            child: Image.asset('images/spotify.png'),
          ),
          SizedBox(height: 40),  // Increase the height for more spacing
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purpleAccent[100],
              shape: const StadiumBorder(),
              elevation: 1,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),  // Adjust padding for a larger button
            ),
            onPressed: () {
              // Your logic for user login here
              // For example, navigate to MyHomePage
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => MyHomePage()),
              );
            },
            icon: Image.asset('images/spotify.png', height: mq.height * .03),
            label: RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.white, fontSize: 32, wordSpacing: 1),  // Adjust the fontSize as needed
                children: [
                  TextSpan(text: 'Get Started'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
