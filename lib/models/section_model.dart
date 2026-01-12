class SectionModel {
  final String id;
  final String name;
  final int price;
  final String info;
  final int availableQuantity;

  // 👇 THIS FIELD IS REQUIRED
  int selectedQuantity;

  SectionModel({
    required this.id,
    required this.name,
    required this.price,
    required this.info,
    required this.availableQuantity,
    this.selectedQuantity = 0,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(
      id: json['_id'],
      name: json['name'],
      price: json['price'],
      info: json['info'],
      availableQuantity: json['availableQuantity'],
      selectedQuantity: 0,
    );
  }
}
