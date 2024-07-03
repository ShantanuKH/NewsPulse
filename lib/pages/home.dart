import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_pulse/model/category_model.dart';
import 'package:news_pulse/model/slider_model.dart';
import 'package:news_pulse/services/data.dart';
import 'package:news_pulse/services/slider_data.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categories = [];
  List<sliderModel> slider = [];
  @override
  void initState() {
    categories = getCategories();
    slider = getSliders();
    super.initState();
  }

  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
              text: "News",
              style: TextStyle(
                  color: Color.fromARGB(255, 241, 45, 45),
                  fontWeight: FontWeight.bold,
                  fontSize: 27),
              children: [
                TextSpan(
                    text: "Pulse",
                    style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 27))
              ]),
        ),
        elevation: 1,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 10),
                height: 70,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return CatergoryTiles(
                        image: categories[index].image,
                        catergoryName: categories[index].catergoryName,
                      );
                    }),
              ),
              SizedBox(
                height: 15,
              ),
               Padding(
                padding: EdgeInsets.only(left: 10,right: 10),
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Breaking News !",
                   style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PlaywriteGBS'
                   ),
                   ),
                   Text("View All",
                   style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 15,
                    fontWeight: FontWeight.w600
                   ),
                   ),
                  ],
                 ),
               ),
                SizedBox(
                height: 15,
              ),
        
        
              CarouselSlider.builder(
                  itemCount: slider.length,
                  itemBuilder: (context, index, realIndex) {
                    String? res = slider[index].image;
                    String? sname = slider[index].name;
                    return buildImage(res!, index, sname!);
                  },
                 
                  options: CarouselOptions(
                      height: 240,
                      autoPlay: true,
                      autoPlayAnimationDuration: Durations.long4,
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                      onPageChanged: (index, reason) {
                        setState(() {
                          activeIndex = index;
                        });
                      })),
              SizedBox(
                height: 20,
              ),
              Center(child: buildIndicator()),
                SizedBox(
                height: 20,
              ),
                           Padding(
                padding: EdgeInsets.only(left: 10,right: 10),
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Trending News !",
                   style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'ZillaSlab'
                   ),
                   ),
                   Text("View All",
                   style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 15,
                    fontWeight: FontWeight.w600
                   ),
                   ),
                  ],
                 ),
               ),
               SizedBox(
                height: 5,
              ),
               Padding(
                 padding: const EdgeInsets.only(left:7,right: 7),
                 child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                   child: Padding(
                     padding: const EdgeInsets.symmetric(vertical: 10),
                     child: Row(
                       crossAxisAlignment:CrossAxisAlignment.start,
                       
                      children: [
                        Container(
                          child:ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset("assets/business.jpeg",
                            height:150 ,
                            width: 150,
                            fit: BoxFit.cover,
                            ),
                          )
                        ),
                         SizedBox(
                                   width: 12,
                                 ),
                         Column(
                           children: [
                            Container(
                              width: MediaQuery.of(context).size.width/2,
                               child: Text("T20 WorldCup 2024",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600
                              ),
                              ),
                             ),
                              SizedBox(
                               height: 4,
                               ),
                             Container(
                              width: MediaQuery.of(context).size.width/2,
                               child: Text("India Men Cricket Team Won the T20 WorldCup 2024",
                              style: TextStyle(
                                color: Colors.black38,
                                fontSize: 15,
                                fontWeight: FontWeight.w600
                              ),
                              ),
                             ),
                           ],
                         ),
                     ],
                     ),
                   ),
                 ),
               ),
                SizedBox(
                               height: 15,
                               ),
                Padding(
                 padding: const EdgeInsets.only(left:7,right: 7),
                 child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                   child: Padding(
                     padding: const EdgeInsets.symmetric(vertical: 10),
                     child: Row(
                       crossAxisAlignment:CrossAxisAlignment.start,
                       
                      children: [
                        Container(
                          child:ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset("assets/sports.jpeg",
                            height:150 ,
                            width: 150,
                            fit: BoxFit.cover,
                            ),
                          )
                        ),
                         SizedBox(
                                   width: 12,
                                 ),
                         Column(
                           children: [
                            Container(
                              width: MediaQuery.of(context).size.width/2,
                               child: Text("T20 WorldCup 2024",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600
                              ),
                              ),
                             ),
                              SizedBox(
                               height: 4,
                               ),
                             Container(
                              width: MediaQuery.of(context).size.width/2,
                               child: Text("India Men Cricket Team Won the T20 WorldCup 2024",
                              style: TextStyle(
                                color: Colors.black38,
                                fontSize: 15,
                                fontWeight: FontWeight.w600
                              ),
                              ),
                             ),
                           ],
                         ),
                     ],
                     ),
                   ),
                 ),
               )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImage(String image, int index, String name) => Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                height: 240,
                image,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Container(
              height: 240,
              padding: EdgeInsets.only(left: 10),
              margin: EdgeInsets.only(top: 160),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              child: Text(
                name,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      );

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: slider.length,
        effect: JumpingDotEffect(
            dotHeight: 8,
            dotWidth: 8,
            jumpScale: 2,
            verticalOffset: 8,
            activeDotColor: const Color.fromARGB(255, 3, 138, 201)),
      );
}

class CatergoryTiles extends StatelessWidget {
  final image, catergoryName;
  CatergoryTiles({this.image, this.catergoryName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            child: Image.asset(
              image,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.black26,
            ),
            width: 120,
            height: 120,
            child: Center(
              child: Text(
                catergoryName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ),
          )
        ],
      ),
    );
  }
}
