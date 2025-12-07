import 'package:flutter/material.dart';
import 'package:lab3/services/FavouriteService.dart';
import '../model/Recipe.dart';

class MealCard extends StatefulWidget {
  final Recipe meal;

  const MealCard({super.key, required this.meal});

  @override
  State<MealCard> createState() => _MealCardState();
}

class _MealCardState extends State<MealCard> {
  // List<Recipe> favouriteList = [];


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/detail", arguments: widget.meal);
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
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        FavouriteService.toggleFavourite(widget.meal);
                      });
                    },
                    child: FavouriteService.isFavourite(widget.meal)
                        ? Icon(Icons.star, color: Colors.yellow)
                        : Icon(Icons.star_border_outlined),
                  ),
                ],
              ),
              Text(widget.meal.name, style: TextStyle(fontSize: 20)),
              Divider(),
              Expanded(child: Image.network(widget.meal.img)),
            ],
          ),
        ),
      ),
    );
  }
}