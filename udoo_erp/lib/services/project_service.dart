import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:udoo_erp/model/project_task/project_model.dart';

class ProjectService {
  static const String baseUrl = 'http://127.0.0.1:8000/api';

  Map<String, String> _getAuthHeaders(String token) => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };

  Future<List<ProjectModel>> getProjects(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/projects'),
        headers: _getAuthHeaders(token),
      );
      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        return data.map((item) => ProjectModel.fromJson(item)).toList();
      } else {
        throw Exception("Failed to load projects: ${response.body}");
      }
    } catch (e) {
      print("Error in getProjects: $e");
      rethrow;
    }
  }

  Future<void> createProject(
    String name,
    int? teamId,
    int userId,
    String token,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/projects'),
      headers: _getAuthHeaders(token),
      body: jsonEncode({'name': name, 'team_id': teamId, 'user_id': userId}),
    );
    if (response.statusCode != 201) {
      throw Exception("Failed to create project");
    }
  }

  Future<void> updateProject(
    int id,
    String name,
    int? teamId,

    String token,
  ) async {
    final response = await http.put(
      Uri.parse('$baseUrl/projects/$id'),
      headers: _getAuthHeaders(token),
      body: jsonEncode({'name': name, 'team_id': teamId}),
    );
    if (response.statusCode != 200) {
      throw Exception("Failed to update project: ${response.body}");
    }
  }

  Future<void> deleteProject(int id, String token) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/projects/$id'),
      headers: _getAuthHeaders(token),
    );
    if (response.statusCode != 200) {
      throw Exception("Failed to delete project");
    }
  }
}
