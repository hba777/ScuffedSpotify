// import 'package:flutter/material.dart';
// import 'package:scuffed_spotify/api/apis.dart';
//
// late Size mq;
//
// class Albums extends StatefulWidget {
//   const Albums({super.key});
//
//   @override
//   State<Albums> createState() => _AlbumsState();
// }
//
// class _AlbumsState extends State<Albums> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Spotify Album Images'),
//       ),
//       body: FutureBuilder(
//         future: APIs.getAlbumImages('382ObEPsp2rxGrnsizN5TX'),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text("Error: ${snapshot.error}"),
//             );
//           } else {
//             String imageUrl = snapshot.data as String;
//             return Image.network(imageUrl);
//           }
//         },
//       ),
//     );
//   }
// }
