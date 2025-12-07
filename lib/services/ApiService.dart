import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/Recipe.dart';

class ApiService {
  Future<List<Recipe>> loadRecipeList() async {
    List<Recipe> recipeList = [];

    final response = await http.get(
      Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php'),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data["categories"] != null) {
        final List categories = data["categories"];

        for (var item in categories) {
          recipeList.add(Recipe.fromCategoryJson(item));
        }
      }
    }

    return recipeList;
  }
  Future<List<Recipe>> searchRecipeByCategory(String name) async {
    List<Recipe> mealsList = [];

    final response = await http.get(
      Uri.parse("https://www.themealdb.com/api/json/v1/1/filter.php?c=$name"),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data["meals"] != null) {
        for (var item in data["meals"]) {
          mealsList.add(Recipe.fromMealJson(item));
        }
      }
    }
    return mealsList;
  }
  Future<Recipe?> detailMeal(int id) async{
    final response = await http.get(
      Uri.parse("https://www.themealdb.com/api/json/v1/1/lookup.php?i=${id}"),
    );
    if (response.statusCode == 200){
      final data = json.decode(response.body);
      if (data['meals'] != null){
        return Recipe.detailMealJson(data["meals"][0]);
      }
    }
    return null;
  }
  Future<Recipe?> randomRecipe() async{
    final response = await http.get(
      Uri.parse("https://www.themealdb.com/api/json/v1/1/random.php"),
    );
    if (response.statusCode == 200){
      final data = json.decode(response.body);
      if (data["meals"]!= null){
        return Recipe.detailMealJson(data["meals"][0]);
      }
    }
    return null;
  }
}
