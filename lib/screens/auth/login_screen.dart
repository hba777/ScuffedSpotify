import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:scuffed_spotify/screens/SpotifyScreen.dart';
import '../../main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  bool _isAnimate = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isAnimate = true;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: const Text(
          "Scuffed Spotify",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white,
          fontSize: 35,
          fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          AnimatedPositioned(
              duration: const Duration(seconds: 1),
              top: mq.height * .15,
              left: _isAnimate ? mq.width * .25 : -mq.width * .5,
              width: mq.width * .5,
              child: Image.asset('images/spotify.png',height: mq.height * .3,)),
          Positioned(
              bottom: mq.height * .15,
              left: mq.width * .17,
              width: mq.width * .7,
              height: mq.height * .06,
              child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurpleAccent[100],
                      shape: const StadiumBorder(),
                      elevation: 1),
                  onPressed: () {
                    Navigator.push(context,
                    MaterialPageRoute(builder: (_) => MyHomePage()));
                  },
                  icon:
                  Image.asset('images/spotify.png', height: mq.height * .03),
                  label: RichText(
                      text: const TextSpan(
                          style: TextStyle(color: Colors.white, fontSize: 16),
                          children: [
                            TextSpan(text: 'Get Started',style: TextStyle(fontSize: 25)),
                          ]))))
        ],
      ),
    );
  }
}
