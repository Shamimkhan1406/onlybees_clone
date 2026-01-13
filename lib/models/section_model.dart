// class SectionModel {
//   final String id;
//   final String name;
//   final int price;
//   final String info;
//   final int availableQuantity;

//   // 👇 THIS FIELD IS REQUIRED
//   int selectedQuantity;

//   SectionModel({
//     required this.id,
//     required this.name,
//     required this.price,
//     required this.info,
//     required this.availableQuantity,
//     this.selectedQuantity = 0,
//   });

//   factory SectionModel.fromJson(Map<String, dynamic> json) {
//     return SectionModel(
//       id: json['_id'],
//       name: json['name'],
//       price: json['price'],
//       info: json['info'],
//       availableQuantity: json['availableQuantity'],
//       selectedQuantity: 0,
//     );
//   }
// }
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
      // The ?? operator provides a fallback if the field is missing
      id: (json['_id'] ?? json['id'] ?? '0').toString(), 
      name: json['name'] ?? 'Unknown Section',
      price: json['price'] is int ? json['price'] : int.tryParse(json['price'].toString()) ?? 0,
      info: json['info'] ?? '',
      availableQuantity: json['availableQuantity'] ?? 0,
      selectedQuantity: 0,
    );
  }
}