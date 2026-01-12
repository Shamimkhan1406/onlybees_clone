class SectionModel {
  final String id;
  final String name;
  final int price;
  final String info;
  final int availableQuantity;
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
      id: json['_id']?.toString() ?? '',
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toInt(),
      info: json['info'] ?? '',
      availableQuantity: (json['availableQuantity'] ?? 0).toInt(),
    );
  }
}
