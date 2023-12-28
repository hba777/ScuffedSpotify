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
  String? mail ='';
  var db = new APIs();

  // void _getData(){
  //   db.ConnectSql().then((conn) {
  //     String sql = 'select name from lab.users where id = 1;';
  //     conn.query(sql).then((results) {
  //       for (var row in results){
  //         setState(() {
  //           print('dOOdo');
  //           log('RowData: $row');
  //           mail = row[0];
  //         });
  //       }
  //     });
  //   });
  // }
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isAnimate = true;
      });
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
                      backgroundColor: Colors.green,
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
