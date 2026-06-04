import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:udoo_erp/model/project_task/task_model.dart';
import 'package:udoo_erp/services/task_service.dart';

enum TaskStatus { initial, loading, loaded, error }

class TaskProvider with ChangeNotifier {
  final TaskService _service = TaskService();
  List<Task> tasks = [];
  bool isLoading = false;
  bool isCreating = false;

  Future<void> fetchTasksByProject(int projectId, String token) async {
    isLoading = true;
    notifyListeners();
    try {
      tasks = await _service.getTasksByProject(
        projectId: projectId,
        token: token,
      );
    } catch (error) {
      debugPrint("API fetch tasks error: $error");
    }
    isLoading = false;
    notifyListeners();
  }

  Future<bool> createTask({
    required int projectId,
    required String title,
    required String priority,
    required String? startDate,
    required String? dueDate,
    required String description,
    required String token,
    int? assigneeId,
  }) async {
    isCreating = true;
    notifyListeners();
    try {
      await _service.createTask(
        projectId,
        title,
        priority,
        startDate,
        dueDate,
        description,
        token,
        assigneeId,
      );
      await fetchTasksByProject(projectId, token);

      isCreating = false;
      notifyListeners();
      return true;
    } catch (error) {
      debugPrint("API create task error: $error");
      isCreating = false;
      notifyListeners();
      return false;
    }
  }
}
