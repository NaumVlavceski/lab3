import 'package:flutter/material.dart';
import '../model/Recipe.dart';
import '../services/ApiService.dart';
import '../widget/MealGrid.dart';

class byCategory extends StatefulWidget {
  const byCategory({super.key});

  @override
  State<byCategory> createState() => _byCategoryState();
}

class _byCategoryState extends State<byCategory> {
  final ApiService _apiService = ApiService();

  final TextEditingController _searchController = TextEditingController();

  late Recipe category;
  List<Recipe> _recipe = [];
  List<Recipe> _filterRecipe = [];
  bool _loading = true;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_initialized) {
      category = ModalRoute.of(context)!.settings.arguments as Recipe;
      _loadMeals();
      _initialized = true;
    }
  }

  void _onSearchChanged(String value) {
    value = value.toLowerCase();
    setState(() {
      if (value.isEmpty) {
        _filterRecipe = _recipe;
      } else {
        _filterRecipe = _recipe.where((r) {
          return r.name.toLowerCase().contains(value);
        }).toList();
      }
    });
  }

  Future<void> _loadMeals() async {
    final list = await _apiService.searchRecipeByCategory(category.name);
    setState(() {
      _recipe = list;
      _filterRecipe = _recipe;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Text(category.name)),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Search ${category.name} meal ...",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: _onSearchChanged,
                  ),
                ),
                _filterRecipe.isEmpty
                    ? const Center(
                        child: Text(
                          "No recipe found",
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    : Expanded(child: MealGrid(meal: _filterRecipe)),
              ],
            ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, "/favourite");
          },
          child: Icon(Icons.star, size: 30),
        ),
      ),
    );
  }
}
