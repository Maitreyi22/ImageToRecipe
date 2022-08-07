class RecipeDataModel {
  final String name;
  final String ingredients;
  final String recipe;
  final String difficulty;
  final String cuisine;
  final String calories;
  final String time;

  RecipeDataModel(
      {required this.name,
      required this.ingredients,
      required this.recipe,
      required this.difficulty,
      required this.cuisine,
      required this.time,
      required this.calories});
}
