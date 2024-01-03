import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:scuffed_spotify/api/apis.dart';
import 'package:scuffed_spotify/screens/SpotifyScreen.dart';
import '../../helpers/dailogs.dart';
import '../home_screen.dart';

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
    //Show Progress Bar
    Dialogs.showProgressBar(context);

  }



  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: const Text(
          "Scuffed Spotify",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ),
      body: Stack(
        children: [
          AnimatedPositioned(
              duration: const Duration(seconds: 1),
              top: mq.height * .15,
              left: _isAnimate ? mq.width * .25 : -mq.width * .5,
              width: mq.width * .5,
              child: Image.asset('images/spotify.png')),

          Positioned(
              bottom: mq.height * .15,
              left: mq.width * .15,
              width: mq.width * .7,
              height: mq.height * .06,
              child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurpleAccent,
                      shape: const StadiumBorder(),
                      elevation: 1),
                  onPressed: () {

                  },
                  icon:
                  Image.asset('images/spotify.png', height: mq.height * .03),
                  label: RichText(
                      text: TextSpan(
                          style: TextStyle(color: Colors.white, fontSize: 16,
                              wordSpacing: 1),
                          children: [
                            TextSpan(text: 'Admin Sign In'),

                          ]
                      )
                  )
              )
          ),

          Positioned(
              bottom: mq.height * .07,
              left: mq.width * .15,
              width: mq.width * .7,
              height: mq.height * .06,
              child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurpleAccent,
                      shape: const StadiumBorder(),
                      elevation: 1),
                  onPressed: () {
                    // Check().then((value) {
                    //   Navigator.push(context,
                    //   MaterialPageRoute(builder: (_) => SongScreen(accessToken: value)));
                    // });
                    String? accessToken;
                    Check().then((value) {
                      print(value);
                      accessToken = value;
                      APIs.getSongDetails(value!).then((value) {
                        print(accessToken);
                        print(value);
                        Navigator.push(context, MaterialPageRoute(builder: (_) => SongScreen(accessToken: accessToken, imageUrl: value,) ));
                      });
                    });
                  },
                  icon:
                  Image.asset('images/spotify.png', height: mq.height * .03),
                  label: RichText(
                      text: TextSpan(
                          style: TextStyle(color: Colors.white, fontSize: 16,
                          wordSpacing: 1),
                          children: [
                            TextSpan(text: 'User Sign In:'),

                          ]
                      )
                  )
              )
          )
        ],
      ),
    );
  }
}
