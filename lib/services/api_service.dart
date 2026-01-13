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
import '../models/section_model.dart';

class ApiService {
  static Future<List<SectionModel>> fetchSections() async {
    try {
      await Future.delayed(const Duration(milliseconds: 200));

      // ✅ YOUR JSON DATA (MOCK)
      final data = {
        "sections": [
          {
            "_id": "68eb5a2a24634f327a1bc4f1",
            "name": "GA (Phase 2)",
            "price": 1249,
            "info": "- ⁠Entry only\\n- Easy access to the bar",
            "availableQuantity": 10,
            "lockedSeats": 0,
            "sectionId": "68eb5a2a24634f327a1bc4f1"
          },
          {
            "_id": "68f5c3d9b650f02fec29e4cc",
            "name": "GA VIP (Phase 2)",
            "price": 1999,
            "info": "- Exclusive front-row near the stage\\n- Easy access to the bar",
            "availableQuantity": 10,
            "lockedSeats": 0,
            "sectionId": "68f5c3d9b650f02fec29e4cc"
          },
          {
            "_id": "68e0d4fccd444a2d9bce1100",
            "name": "VVIP Lounge/Round Table (per person)",
            "price": 4999,
            "info":
                "- ⁠Unlimited food & beverages for 180 minutes (7pm - 10 pm)\\n⁠- Access to all areas\\n- Exclusive round table service\\n⁠- Unlimited IMFL pouring\\n- ⁠Clear and unobstructed view of the stage",
            "availableQuantity": 10,
            "lockedSeats": 0,
            "sectionId": "68e0d4fccd444a2d9bce1100"
          },
          {
            "_id": "68e600ce6689f396f9775175",
            "name": "VVIP Round Table (upto 6 persons)",
            "price": 24999,
            "info":
                "- Exclusive round table\\n- ⁠Unlimited food & beverages for 180 minutes (7pm - 10 pm)\\n⁠- Access to all areas\\n- Round table service\\n⁠- Unlimited IMFL pouring\\n- ⁠Clear and unobstructed view of the stage",
            "availableQuantity": 10,
            "lockedSeats": 0,
            "sectionId": "68e600ce6689f396f9775175"
          },
          {
            "_id": "68e0d44fcd444a2d9bce10f8",
            "name": "GA (Early Bird)",
            "price": 799,
            "info": "- ⁠Entry only\\n- Easy access to the bar",
            "availableQuantity": 0,
            "lockedSeats": -1000,
            "sectionId": "68e0d44fcd444a2d9bce10f8"
          },
          {
            "_id": "68e0d4edcd444a2d9bce10ff",
            "name": "GA VIP (Early Bird)",
            "price": 1399,
            "info": "- Exclusive front-row near the stage\\n- Easy access to the bar",
            "availableQuantity": -1000,
            "lockedSeats": 0,
            "sectionId": "68e0d4edcd444a2d9bce10ff"
          }
        ]
      };

      final sectionsJson = data["sections"] as List;

      return sectionsJson.map((e) {
        return SectionModel(
          id: e["_id"],
          name: e["name"],
          price: e["price"],
          info: e["info"],
          availableQuantity: e["availableQuantity"],
        );
      }).toList();
    } catch (e) {
      print("Error fetching sections: $e");
      return [];
    }
  }
}
