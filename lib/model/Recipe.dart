class Recipe {
  int id;
  String name;
  String img;
  String desc;
  String category;
  String youTube;
  List<String> ingredients =[];

  Recipe({
    required this.id,
    required this.name,
    required this.img,
    required this.desc,
    required this.category,
    required this.youTube,
    required this. ingredients,
  });

  factory Recipe.fromCategoryJson(Map<String, dynamic> data){
    return Recipe(
      id: int.parse(data['idCategory']),
      name: data['strCategory'],
      img: data['strCategoryThumb'],
      desc: data['strCategoryDescription'],
      category: '',
      youTube: "",
      ingredients: [],
    );
  }

  factory Recipe.fromMealJson(Map<String, dynamic> data){
    return Recipe(
      id: int.parse(data['idMeal']),
      name: data['strMeal'],
      img: data['strMealThumb'],
      desc: "",
      category: "",
      youTube: "",
      ingredients: [],
    );
  }

  factory Recipe.detailMealJson(Map<String, dynamic> data){
    List<String> ing = [];
    for (int i = 1; i<=20;i++){
      final ingredient = data['strIngredient$i'];
      if (ingredient != null && ingredient.toString().trim().isNotEmpty){
        ing.add(ingredient.toString());
      }
    }

    return Recipe(id: int.parse(data['idMeal']),
        name: data["strMeal"],
        img: data["strMealThumb"],
        desc: data["strInstructions"],
        category: "",
        youTube: data['strYoutube'],
        ingredients: ing,
    );
  }
}