// import 'package:flutter/material.dart';

// class SignLanguageDictionaryPage extends StatelessWidget {
//   final List<Map<String, String>> signs = [
//     {"image": "assets/bahagia.png", "text": "Bahagia"},
//     {"image": "assets/gembira.png", "text": "Gembira"},
//     {"image": "assets/sedih.png", "text": "Sedih"},
//     {"image": "assets/kecewa.png", "text": "Kecewa"},
//     {"image": "assets/takut.png", "text": "Takut"},
//     {"image": "assets/senang.png", "text": "Senang"},
//     {"image": "assets/marah.png", "text": "Marah"},
//     {"image": "assets/bingung.png", "text": "Bingung"},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sign Language Dictionary'),
//       ),
//       body: ListView.builder(
//         itemCount: signs.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             leading: Image.asset(signs[index]["image"]!),
//             title: Text(signs[index]["text"]!),
//           );
//         },
//       ),
//     );
//   }
// }
