import 'package:lab3/model/Recipe.dart';

class FavouriteService {
  static List<Recipe> favourites = [];
  static bool isFavourite (Recipe recipe){
    return favourites.any((r)=>r.id == recipe.id);
  }
  static void toggleFavourite(Recipe recipe){
    if (isFavourite(recipe)){
      favourites.removeWhere((r)=>r.id == recipe.id);
    }else{
      favourites.add(recipe);
    }
  }
}