class PharmaciesModel {
  String pharmacy_name;
  String pharmacy_id;

  PharmaciesModel({required this.pharmacy_name, required this.pharmacy_id});

  factory PharmaciesModel.fromJson(Map<String, dynamic> json) {
    return PharmaciesModel(
        pharmacy_name: json['name'],
        pharmacy_id: json['pharmacyId']);
  }
}
