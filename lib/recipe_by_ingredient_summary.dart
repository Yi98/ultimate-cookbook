class RecipeByIngredientSummary {
  var recipe;

  RecipeByIngredientSummary({this.recipe});

  factory RecipeByIngredientSummary.fromJson(List<dynamic> json) {
    return RecipeByIngredientSummary(
      recipe: json,
    );
  }
}
