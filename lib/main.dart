import 'package:flutter/material.dart';
import 'package:getx/home_page.dart';

import 'audio_page.dart';

void main() {
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Demo',
      debugShowCheckedModeBanner:false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:const MyHomePage(),
      // home: const DetailAudioPage()
    );
  }
}