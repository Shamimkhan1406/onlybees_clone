import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/section_model.dart';

class ApiService {
  static const String _baseUrl =
      'http://localhost:3000/api/availability';

  static Future<List<SectionModel>> fetchSections() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode != 200) {
      throw Exception(
        'API failed with status ${response.statusCode}',
      );
    }

    final decoded = jsonDecode(response.body);

    // SAFETY CHECK
    if (decoded == null || decoded['sections'] == null) {
      throw Exception('Invalid API response structure');
    }

    return List<SectionModel>.from(
      decoded['sections'].map(
        (e) => SectionModel.fromJson(e),
      ),
    );
  }
}
