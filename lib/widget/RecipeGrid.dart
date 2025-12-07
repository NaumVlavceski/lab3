import 'package:flutter/material.dart';
import 'package:lab3/model/Recipe.dart';
import 'package:lab3/widget/RecipeCard.dart';

class RecipeGrid extends StatelessWidget {
  final List<Recipe> recipe;

  const RecipeGrid({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 4,
        mainAxisSpacing:4,
      ),
      itemCount: recipe.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return RecipeCard(recipe: recipe[index]);
      },
    );
  }
}
