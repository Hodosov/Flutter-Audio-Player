import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:getx/utils/app_colors.dart' as AppColors;

import 'audio_file.dart';

class DetailAudioPage extends StatefulWidget {
  const DetailAudioPage({Key? key}) : super(key: key);

  @override
  _DetailAudioPageState createState() => _DetailAudioPageState();
}

class _DetailAudioPageState extends State<DetailAudioPage> {
  late AudioPlayer advancePlayer;

  @override
  void initState() {
    super.initState();
    advancePlayer = AudioPlayer();
  }


  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.audioBlueBackground,
      body: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: screenHeight / 3,
              child: Container()),
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                  ),
                  onPressed: () {},
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {},
                  ),
                ],
                backgroundColor: Colors.transparent,
                elevation: 0.0,
              )),
          Positioned(
              left: 0,
              right: 0,
              top: screenHeight * 0.25,
              height: screenHeight * 0.36,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40)),
                child: Column(
                  children: [
                    SizedBox(height: screenHeight * 0.1),
                    const Text(
                      'THE WATER CURE',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Avenir"),
                    ),
                    const Text(
                      "Martin Hyatt",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    AudioFile(advancePlayer: advancePlayer),
                  ],
                ),
              )),
          Positioned(
              top: screenHeight * 0.17,
              left: (screenWidth - 150) / 2,
              right: (screenWidth - 150) / 2,
              height: screenHeight * 0.17,
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.audioGrayBackground,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white, width: 2)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 5),
                        image: const DecorationImage(
                            image:
                                AssetImage("assets/images/THE_WATER_CURE.jpg"),
                            fit: BoxFit.cover)),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
