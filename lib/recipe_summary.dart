class RecipeSummary {
  var results;

  RecipeSummary({this.results});

  factory RecipeSummary.fromJson(Map<String, dynamic> json) {
    return RecipeSummary(
      results: json['results'],
    );
  }
}
