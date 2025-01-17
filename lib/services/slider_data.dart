import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_pulse/model/slider_model.dart';

class Sliders {
  List<SliderModel> sliders = [];

  Future<void> getSlider() async {
    String url =
        "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=7e17ed669af54c90a2a950d001baa63e";
    var response = await http.get(Uri.parse(url));

    // Here we are decoding the data that we are getting from the NesApi
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element['description'] != null) {
          SliderModel sliderModel = SliderModel(
            author: element["author"],
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
          );
          sliders.add(sliderModel);
        }
      });
    }
  }
}
