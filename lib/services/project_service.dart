import 'dart:convert';
import '../models/project_model.dart';
import 'custom_http_client.dart'; 

class ProjectService {
  final String apiUrl = "https://www.airport.lk/project_api_aasl/api/bia.php?type=all&id=&year=&username=&password=";
  final String apiKey = 'fa3b2c9c-a96d-48a8-82ad-0cb775dd3e5d';

  // Fetch all projects with debugging
  Future<List<Project>> fetchProjects() async {
    try {
      final response = await CustomHttpClient.get(
        apiUrl,
        headers: {
          'x-api-key': 'fa3b2c9c-a96d-48a8-82ad-0cb775dd3e5d',
          'Content-Type': 'application/json',
        },
      );

      print("Response Status Code: ${response.statusCode}");
      print("Raw Response Body: ${response.body}");

      if (response.statusCode == 200) {
        var decodedData = json.decode(response.body);

        print("Decoded Data: $decodedData");

        if (decodedData is List) {
          return decodedData.map((json) => Project.fromJson(json)).toList();
        } else {
          throw Exception("Unexpected JSON format: ${decodedData.runtimeType}");
        }
      } else {
        throw Exception('Failed to load projects: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }
  
}
