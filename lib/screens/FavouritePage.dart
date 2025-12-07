import 'package:flutter/material.dart';
import 'package:lab3/services/FavouriteService.dart';
import 'package:lab3/widget/MealGrid.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    final favList = FavouriteService.favourites;

    return Scaffold(
      appBar: AppBar(
        title: Text("Favourite Meals"),
        centerTitle: true,
      ),
      body: favList.isEmpty
          ? Center(
        child: Text("No favourite meals yet", style: TextStyle(fontSize: 20),
        ),
      )
      : MealGrid(meal: favList)
    );
  }
}
