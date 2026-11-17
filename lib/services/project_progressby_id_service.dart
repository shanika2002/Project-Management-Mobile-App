import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import '../models/project_progressby_id_model.dart';

class ProjectProgressByIdService {
  Future<List<ProjectProgress>> fetchProjectProgressById(String projectId) async {
    final String apiUrl =
        "https://www.airport.lk/project_api_aasl/api/bia.php?type=prog&id=$projectId&year=&username=&password=";

    try {
      print("Fetching API Data for Project ID: $projectId...");

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
        return jsonData.map((item) => ProjectProgress.fromJson(item)).toList();
      } else {
        throw Exception("Failed to load project progress data");
      }
    } catch (e) {
      print("Error fetching project progress data: $e");
      return [];
    }
  }
}

// ✅ Fix SSL Handshake Error
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
