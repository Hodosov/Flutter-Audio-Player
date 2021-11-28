import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getx/tabs.dart';
import 'package:getx/utils/app_colors.dart' as AppColors;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  List? popularBooks;
  List? books;
  ScrollController? _scrollController;
  TabController? _tabController;

  ReadData() async {
    await DefaultAssetBundle.of(context)
        .loadString('json/popularBook.json')
        .then((s) => {
              setState(() {
                popularBooks = json.decode(s);
              })
            });

    await DefaultAssetBundle.of(context)
        .loadString('json/books.json')
        .then((s) => {
              setState(() {
                books = json.decode(s);
              })
            });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
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
                height: 150,
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
                              itemCount: popularBooks == null
                                  ? 0
                                  : popularBooks?.length,
                              itemBuilder: (_, i) {
                                return Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  height: 200,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              popularBooks?[i]['img']))),
                                );
                              }),
                        ))
                  ],
                ),
              ),
              Expanded(
                  child: NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder: (BuildContext context, bool isScroll) {
                  return [
                    SliverAppBar(
                      pinned: true,
                      backgroundColor: AppColors.sliverBackground,
                      bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(50),
                        child: Container(
                            margin: const EdgeInsets.only(bottom: 20, left: 5),
                            child: TabBar(
                              indicatorPadding: const EdgeInsets.all(0),
                              indicatorSize: TabBarIndicatorSize.label,
                              labelPadding:
                                  const EdgeInsets.only(left: 6, right: 6),
                              controller: _tabController,
                              isScrollable: true,
                              indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      blurRadius: 7,
                                      offset: const Offset(0, 0),
                                    )
                                  ]),
                              tabs: const [
                                AppTabs(
                                    text: 'New', color: AppColors.menu1Color),
                                AppTabs(
                                    text: 'Popular',
                                    color: AppColors.menu2Color),
                                AppTabs(
                                    text: 'Tranding',
                                    color: AppColors.menu3Color),
                              ],
                            )),
                      ),
                    )
                  ];
                },
                body: TabBarView(
                  controller: _tabController,
                  children: [
                    ListView.builder(
                        itemCount: books == null ? 0 : books?.length,
                        itemBuilder: (_, i) {
                          return Container(
                            margin: const EdgeInsets.only(
                                left: 10, right: 10, top: 10, bottom: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.tabVarViewColor,
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 160,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                              image: AssetImage(
                                                  books?[i]['img']))),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                        
                                          children: [
                                            const Icon(Icons.star,
                                                size: 24,
                                                color: AppColors.starColor),
                                            const SizedBox(width: 5),
                                            Text(books?[i]['rating'])
                                          ],
                                        ),
                                        SizedBox(height: 15,),
                                        Text(books?[i]['title'],
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'Avenir',
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                          books?[i]['text'],
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'Avenir',
                                              color: AppColors.subTitleText),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(top: 20),
                                          width: 60,
                                          height: 20,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: AppColors.loveColor),
                                          child: const Text(
                                            "love",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Avenir',
                                                color: Colors.white)
                                                ,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                    const Material(
                      child: ListTile(
                        title: Text('Content'),
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                        ),
                      ),
                    ),
                    const Material(
                      child: ListTile(
                        title: Text('Content'),
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                        ),
                      ),
                    )
                  ],
                ),
              ))
            ],
          ),
        )));
  }
}
