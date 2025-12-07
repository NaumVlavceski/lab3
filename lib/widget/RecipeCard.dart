import 'package:flutter/material.dart';

import '../model/Recipe.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  const RecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/byCategory", arguments: recipe);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black26, width: 3),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text(recipe.name, style: TextStyle(fontSize: 20)),
              Divider(),
              Expanded(child: Image.network(recipe.img)),
              Divider(),
              SizedBox(
                height: 50,
                child: SingleChildScrollView(
                  child: Text(recipe.desc,style: TextStyle(fontSize: 16),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
