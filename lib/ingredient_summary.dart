class IngredientSummary {
  var ingredients;

  IngredientSummary({this.ingredients});

  factory IngredientSummary.fromJson(Map<String, dynamic> json) {
    return IngredientSummary(
      ingredients: json['ingredients'],
    );
  }
}
