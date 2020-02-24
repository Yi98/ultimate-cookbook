class PreparationSummary {
  var preparations;

  PreparationSummary({this.preparations});

  factory PreparationSummary.fromJson(List<dynamic> json) {
    return PreparationSummary(
      preparations: json,
    );
  }
}
