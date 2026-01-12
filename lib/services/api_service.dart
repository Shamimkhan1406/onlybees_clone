// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../models/section_model.dart';

// class ApiService {
//   static const String _baseUrl =
//       'http://localhost:3000/api/availability';

//   static Future<List<SectionModel>> fetchSections() async {
//     final response = await http.get(Uri.parse(_baseUrl));

//     if (response.statusCode != 200) {
//       throw Exception(
//         'API failed with status ${response.statusCode}',
//       );
//     }

//     final decoded = jsonDecode(response.body);

//     // SAFETY CHECK
//     if (decoded == null || decoded['sections'] == null) {
//       throw Exception('Invalid API response structure');
//     }

//     return List<SectionModel>.from(
//       decoded['sections'].map(
//         (e) => SectionModel.fromJson(e),
//       ),
//     );
//   }
// }

import 'dart:async';
import '../models/section_model.dart'; // Ensure this path is correct

class ApiService {
  // 1. The variable MUST be inside the class to be static
  static const String _baseUrl = 'https://your-api-placeholder.com/api'; 

  static Future<List<SectionModel>> fetchSections() async {
    // We use a try-catch to prevent the "Blank Screen" if the network fails
    try {
      // FOR NOW: Returning Mock Data so your Vercel build works perfectly
      await Future.delayed(const Duration(milliseconds: 500));
      
      return [
        SectionModel(
          id: "1",
          name: "VIP SECTION",
          price: 2500,
          info: "Front row seating + Backstage access",
          availableQuantity: 5,
        ),
        SectionModel(
          id: "2",
          name: "GENERAL ADMISSION",
          price: 799,
          info: "Standing area. Please arrive early.",
          availableQuantity: 100,
        ),
        SectionModel(
        id: "3",
        name: "EARLY BIRD SPECIAL",
        price: 499,
        info: "Limited time offer. (Includes free poster)",
        availableQuantity: 0, // 0 makes it show as "Sold Out"
      ),
      ];
    } catch (e) {
      print("Error fetching sections: $e");
      return []; // Return empty list instead of crashing
    }
  }
}