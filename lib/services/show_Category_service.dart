import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_pulse/model/show_Category.dart';
import 'package:news_pulse/model/slider_model.dart';

class ShowCategoryNews {
  List<showCategoryModel> categories = [];

  Future<void> getCategoryNews(String category) async {

    // By doing so we will get the API related to the news of the given title
    String url =
        "https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=7e17ed669af54c90a2a950d001baa63e";
    var response = await http.get(Uri.parse(url));

    // Here we are decoding the data that we are getting from the NesApi
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element['description'] != null) {
          showCategoryModel showcategory = showCategoryModel(
            author: element["author"],
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
          );
          categories.add(showcategory);
        }
      });
    }
  }
}
