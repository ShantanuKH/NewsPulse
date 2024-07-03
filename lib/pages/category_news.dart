import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_pulse/model/show_Category.dart';
import 'package:news_pulse/pages/article_view.dart';
import 'package:news_pulse/services/show_Category_service.dart';

class CategoryNews extends StatefulWidget {
  String name;
  CategoryNews({required this.name});
  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<showCategoryModel> categories = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    getNews();
  }

  getNews() async {
    ShowCategoryNews newsclass = ShowCategoryNews();
    await newsclass.getCategoryNews(widget.name.toLowerCase());
    categories = newsclass.categories;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            text: widget.name,
            style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.bold,
                fontSize: 27),
          ),
        ),
        elevation: 1,
        centerTitle: true,
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return ShowCategory(
                        Image: categories[index].urlToImage!,
                        url: categories[index].url!,
                        descrip: categories[index].description!,
                        title: categories[index].title!);
                  }),
            ),
    );
  }
}

class ShowCategory extends StatelessWidget {
  String Image, title, descrip, url;
  ShowCategory({required this.Image, required this.title, required this.descrip, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector
    (
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ArticleView(blogUrl: url)));

      },
      child: Container(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: Image,
                width: MediaQuery.of(context).size.width,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 5,),
            Text(title,
            maxLines:2,
            
             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            
            Text(descrip,maxLines:3,style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black54),),
      
            SizedBox(height: 25,),
          ],
        ),
      ),
    );
  }
}
