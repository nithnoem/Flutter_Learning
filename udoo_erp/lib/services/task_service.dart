import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:udoo_erp/model/project_task/task_model.dart';

class TaskService {
  final String baseUrl = "http://127.0.0.1:8000/api";

  Map<String, String> _getAuthHeaders(String token) => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };

  Future<List<Task>> getTasksByProject({
    required int projectId,
    required String token,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/tasks?project_id=$projectId'),
        headers: _getAuthHeaders(token),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List taskListJson = responseData['data'] ?? responseData;
        return taskListJson.map((item) => Task.fromJson(item)).toList();
      } else {
        throw Exception("Failed to load tasks: ${response.body}");
      }
    } catch (error) {
      print("Error in getTasksByProject: $error");
      rethrow;
    }
  }

  Future<void> createTask(
    int projectId,
    String title,
    String priority,
    String? startDate,
    String? dueDate,
    String description,
    String token,
    int? assigneedId,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/tasks'),
        headers: _getAuthHeaders(token),
        body: jsonEncode({
          'project_id': projectId,
          'title': title,
          'priority': priority,
          'start_date': startDate,
          'due_date': dueDate,
          'description': description,
          'status': 'todo',
          'assigned_to': assigneedId,
        }),
      );
      if (response.statusCode != 201 && response.statusCode != 200) {
        throw Exception("Failed to create task: ${response.body}");
      }
    } catch (error) {
      print("Error in createTask: $error");
      rethrow;
    }
  }
}
