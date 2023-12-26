import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import '../../api/apis.dart';
import '../../helpers/dailogs.dart';
import '../home_screen.dart';

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

    //APIs.ConnectSql().then((value) => Dialogs.showSnackBar(context, 'Connection Successful'));

    APIs.ConnectSql().then((value) => {
      Dialogs.showSnackBar(context, 'Connection Successful')
    });
  }

  _handleGoogleBtnClick() {
    //Show Progress Bar
    Dialogs.showProgressBar(context);

  //   _signInWithGoogle().then((user) async {
  //     //Hiding Progress bar
  //     Navigator.pop(context);
  //
  //     ;
  //   });
  }



  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blueGrey,
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
                      backgroundColor: Colors.green,
                      shape: const StadiumBorder(),
                      elevation: 1),
                  onPressed: () {
                    _handleGoogleBtnClick();
                  },
                  icon:
                  Image.asset('images/spotify.png', height: mq.height * .03),
                  label: RichText(
                      text: const TextSpan(
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
                      backgroundColor: Colors.green,
                      shape: const StadiumBorder(),
                      elevation: 1),
                  onPressed: () {
                    _handleGoogleBtnClick();
                  },
                  icon:
                  Image.asset('images/spotify.png', height: mq.height * .03),
                  label: RichText(
                      text: const TextSpan(
                          style: TextStyle(color: Colors.white, fontSize: 16,
                          wordSpacing: 1),
                          children: [
                            TextSpan(text: 'User Sign In'),

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
