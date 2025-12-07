import 'package:flutter/material.dart';

import '../model/Recipe.dart';
import 'MealCard.dart';

class MealGrid extends StatelessWidget{
  final List<Recipe> meal;

  const MealGrid({super.key, required this.meal});


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
      itemCount: meal.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return MealCard(meal: meal[index]);
      },
    );
  }

}