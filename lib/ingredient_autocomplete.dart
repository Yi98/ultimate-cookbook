class IngredientAutocomplete {
  var ingredients;

  IngredientAutocomplete({this.ingredients});

  factory IngredientAutocomplete.fromJson(List<dynamic> json) {
    return IngredientAutocomplete(
      ingredients: json,
    );
  }
}
