import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scuffed_spotify/api/apis.dart';
import 'package:scuffed_spotify/screens/auth/login_screen.dart';

late Size mq;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  // void main() async {
  //   final String? accessToken = await APIs.getAccessToken();
  //   if (accessToken != null) {
  //     // Use the access token for authenticated requests
  //     print('Access Token: $accessToken');
  //   } else {
  //     // Handle the case where obtaining the access token failed
  //     print('Failed to get the access token');
  //   }
  // }

  @override
  initState(){
    super.initState();
    //Navigate to HomeScreen
    Future.delayed(const Duration(seconds:2),() {

      //Newer Android Issues Fix fullscreen and Nav Bar Color
      //Exit FullScreen
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
          statusBarColor: Colors.white
      ));

      Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (_) => LoginScreen()));
    });

    APIs.fetchData();

  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: const Text("Scuffed Spotify",textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white,)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
              top: mq.height * .15,
              right: mq.width * .25,
              width: mq.width * .5,
              child: Image.asset('images/spotify.png')),
          Positioned(
              bottom: mq.height * .15,
              width: mq.width * 1,
              child: const Text('Scuffed Spotify',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ))
        ],
      ),
    );
  }
}
