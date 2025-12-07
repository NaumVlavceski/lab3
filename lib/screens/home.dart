import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab3/model/Recipe.dart';
import 'package:lab3/services/ApiService.dart';
import 'package:lab3/widget/RecipeGrid.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final ApiService _apiService = ApiService();
  final TextEditingController _searchController = TextEditingController();

  List<Recipe> _recipe = [];
  List<Recipe> _filterRecipe = [];
  late Recipe? _random;

  bool _loading = false;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _loadAllRecipes();
  }

  Future<void> _loadAllRecipes() async {
    setState(() => _loading = true);
    final list = await _apiService.loadRecipeList();
    final random = await _apiService.randomRecipe();
    setState(() {
      _recipe = list;
      _filterRecipe = _recipe;
      _random = random;
      _loading = false;
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: _loading
              ? Center(child: CircularProgressIndicator())
              : TextButton(
                  onPressed: () => Navigator.pushNamed(
                    context,
                    "/detail",
                    arguments: _random,
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.network(
                          "https://img.freepik.com/free-photo/copy-space-breakfast-with-plain-background_23-2148267646.jpg?semt=ais_hybrid&w=740&q=80",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 15, 100, 15),
                        child: Center(
                          child: Text(
                            "RANDOM RECEPT",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _isSearching
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(25, 5, 25, 2),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search by category ...',
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
                    : Expanded(child: RecipeGrid(recipe: _filterRecipe)),
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
