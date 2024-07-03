
import 'package:news_pulse/model/slider_model.dart';

List<sliderModel> getSliders() {
  List<sliderModel> slider = [];
  sliderModel categoryModel = new sliderModel();

  categoryModel.name = "Bow To The Authority of Silenceforce";
  categoryModel.image = "assets/business.jpeg";
  slider.add(categoryModel);
  categoryModel = new sliderModel();

  categoryModel.name = "Entertainment";
  categoryModel.image = "assets/entertainment.jpeg";
  slider.add(categoryModel);
  categoryModel = new sliderModel();

  categoryModel.name = "General";
  categoryModel.image = "assets/general.jpeg";
  slider.add(categoryModel);
  categoryModel = new sliderModel();

  categoryModel.name = "Health";
  categoryModel.image = "assets/health.jpeg";
  slider.add(categoryModel);
  categoryModel = new sliderModel();

  categoryModel.name = "Science";
  categoryModel.image = "assets/science.jpeg";
  slider.add(categoryModel);
  categoryModel = new sliderModel();

  categoryModel.name = "Sports";
  categoryModel.image = "assets/sports.jpeg";
  slider.add(categoryModel);
  categoryModel = new sliderModel();

  return slider;
}
