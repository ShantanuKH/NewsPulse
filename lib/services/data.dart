import 'package:flutter/foundation.dart';
import 'package:news_pulse/model/category_model.dart';

List<CategoryModel> getCategories() {
  List<CategoryModel> category = [];
  CategoryModel categoryModel = new CategoryModel();

  categoryModel.catergoryName = "Business";
  categoryModel.image = "assets/business.jpeg";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.catergoryName = "Entertainment";
  categoryModel.image = "assets/entertainment.jpeg";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.catergoryName = "General";
  categoryModel.image = "assets/general.jpeg";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.catergoryName = "Health";
  categoryModel.image = "assets/health.jpeg";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.catergoryName = "Science";
  categoryModel.image = "assets/science.jpeg";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.catergoryName = "Sports";
  categoryModel.image = "assets/sports.jpeg";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  return category;
}
