import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:news_pulse/model/article_model.dart';
import 'package:news_pulse/model/category_model.dart';
import 'package:news_pulse/model/slider_model.dart';
import 'package:news_pulse/pages/allNews.dart';
import 'package:news_pulse/pages/article_view.dart';
import 'package:news_pulse/pages/category_news.dart';
import 'package:news_pulse/services/data.dart';
import 'package:news_pulse/services/news.dart';
import 'package:news_pulse/services/slider_data.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categories = [];
  List<SliderModel> sliders = [];
  List<ArticleModel> articles = [];
  bool _loading = true;

  @override
  void initState() {
    categories = getCategories();
    // slider = getSliders();
    getNews();
    getSlider();
    super.initState();
  }

  int activeIndex = 0;

  getNews() async {
    News newsclass = News();
    await newsclass.getNews();
    articles = newsclass.news;
    setState(() {
      _loading = false;
    });
  }

  getSlider() async {
    Sliders slider = Sliders();
    await slider.getSlider();
    sliders = slider.sliders;
  }

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
      body: _loading
          ? Center(child: const CircularProgressIndicator())
          : SingleChildScrollView(
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
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Breaking News !",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'PlaywriteGBS'),
                          ),
                          GestureDetector(
                            onTap: (){
                               Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => AllNews(news: "Breaking")),
                              );
                            },
                            child: Text(
                              "View All",
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CarouselSlider.builder(
                        itemCount: 6,
                        itemBuilder: (context, index, realIndex) {
                          String? res = sliders[index].urlToImage;
                          String? sname = sliders[index].title;
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
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Trending News !",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'ZillaSlab'),
                          ),
                          GestureDetector(
                             onTap: (){
                               Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => AllNews(news: "Trending")),
                              );
                            },
                            child: Text(
                              "View All",
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: articles.length,
                          itemBuilder: (context, index) {
                            return BlogTiles(
                                url: articles[index].url!,
                                imageUrl: articles[index].urlToImage!,
                                descrip: articles[index].description!,
                                title: articles[index].title!);
                          }),
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
              child: CachedNetworkImage(
                height: 240,
                imageUrl: image,
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
              child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  name,
                  maxLines: 2,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: 6,
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryNews(name: catergoryName)));
      },
      child: Container(
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
                color: Colors.black38,
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
      ),
    );
  }
}

class BlogTiles extends StatelessWidget {
  String imageUrl, title, descrip, url;
  BlogTiles(
      {required this.imageUrl,
      required this.descrip,
      required this.title,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ArticleView(blogUrl: url)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 15),
        child: Padding(
          padding: const EdgeInsets.only(left: 7, right: 7),
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  )),
                  SizedBox(
                    width: 12,
                  ),
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text(
                          maxLines: 2,
                          title,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text(
                          maxLines: 3,
                          descrip,
                          style: TextStyle(
                              color: Colors.black38,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
