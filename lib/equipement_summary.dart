class EquipmentSummary {
  var equipments;

  EquipmentSummary({this.equipments});

  factory EquipmentSummary.fromJson(Map<String, dynamic> json) {
    return EquipmentSummary(
      equipments: json['equipment'],
    );
  }
}
