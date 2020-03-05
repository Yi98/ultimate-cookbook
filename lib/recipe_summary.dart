class RecipeSummary {
  var results;

  RecipeSummary({this.results});

  factory RecipeSummary.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      return RecipeSummary(results: json['results']);
    } else {
      return RecipeSummary(results: json['recipes']);
    }
  }
}
