import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_pulse/model/article_model.dart';
import 'package:news_pulse/model/slider_model.dart';
import 'package:news_pulse/pages/article_view.dart';
import 'package:news_pulse/services/news.dart';
import 'package:news_pulse/services/slider_data.dart';

class AllNews extends StatefulWidget {
  final String news;
  AllNews({required this.news});

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  List<SliderModel> sliders = [];
  List<ArticleModel> articles = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    getNews();
    getSlider();
  }

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
    setState(() {}); // Added to update the state after fetching sliders
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            text: "${widget.news} News",
            style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold,
              fontSize: 27,
            ),
          ),
        ),
        elevation: 1,
        centerTitle: true,
      ),
      body: ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.news == "Breaking" ? sliders.length : articles.length,
        itemBuilder: (context, index) {
          return AllNewsSection(
            image: widget.news == "Breaking" ? sliders[index].urlToImage! : articles[index].urlToImage!,
            url: widget.news == "Breaking" ? sliders[index].url! : articles[index].url!,
            descrip: widget.news == "Breaking" ? sliders[index].description! : articles[index].description!,
            title: widget.news == "Breaking" ? sliders[index].title! : articles[index].title!,
          );
        },
      ),
    );
  }
}

class AllNewsSection extends StatelessWidget {
  final String image, title, descrip, url;
  AllNewsSection({
    required this.image,
    required this.title,
    required this.descrip,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ArticleView(blogUrl: url)),
        );
      },
      child: Container(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: image,
                width: MediaQuery.of(context).size.width,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 5),
            Text(
              title,
              maxLines: 2,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            Text(
              descrip,
              maxLines: 3,
              style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black54),
            ),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
