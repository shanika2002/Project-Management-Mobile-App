import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io'; // Import for SSL fix
import '../models/total_estimate_model.dart';

class EstimateService {
  final String apiUrl =
      "https://www.airport.lk/project_api_aasl/api/bia.php?type=estimate&id=&year=&username=&password=";

  Future<List<TotalEstimateModel>> fetchTotalEstimate() async {
    try {
      print("Fetching API Data...");

      // ✅ Fix SSL handshake error
      HttpOverrides.global = MyHttpOverrides();

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          "x-api-key": "fa3b2c9c-a96d-48a8-82ad-0cb775dd3e5d"
        },
      );

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((item) => TotalEstimateModel.fromJson(item)).toList();
      } else {
        throw Exception("Failed to load budget allocation data");
      }
    } catch (e) {
      print("Error fetching budget data: $e");
      return [];
    }
  }
}

// ✅ This class overrides SSL verification
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
