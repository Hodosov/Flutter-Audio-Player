import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getx/utils/app_colors.dart' as AppColors;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List? popularBooks;

  ReadData() async {
  await  DefaultAssetBundle.of(context).loadString('json/popularBook.json').then((s) => {
      setState(() {
       popularBooks = json.decode(s);
      })
    });
  }

  @override
  void initState() {
    super.initState();
    ReadData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.backGround,
        child: SafeArea(
            child: Scaffold(
          body: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const ImageIcon(AssetImage('assets/images/menu.png'),
                        size: 24),
                    Row(
                      children: const [
                        Icon(Icons.search),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.notifications),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: const Text(
                      "Popular Books",
                      style: TextStyle(fontSize: 30),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Container(
                height: 220,
                child: Stack(
                  children: [
                    Positioned(
                        top: 0,
                        left: -20,
                        right: 0,
                        child: Container(
                          height: 150,
                          child: PageView.builder(
                              controller: PageController(viewportFraction: 0.8),
                              itemCount: popularBooks == null ? 0: popularBooks?.length, 
                              itemBuilder: (_, i) {
                                return Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  height: 200,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image:  DecorationImage(
                                          image: AssetImage(popularBooks?[i]['img']))),
                                );
                              }),
                        ))
                  ],
                ),
              ),
              
            ],
          ),
        )));
  }
}
