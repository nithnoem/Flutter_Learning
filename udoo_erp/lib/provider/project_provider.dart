import 'package:flutter/material.dart';
import 'package:udoo_erp/model/project_task/project_model.dart';
import 'package:udoo_erp/services/project_service.dart';

class ProjectProvider extends ChangeNotifier {
  final ProjectService _service = ProjectService();

  List<ProjectModel> projects = [];
  bool isLoading = false;

  Future<void> fetchProjects(String token) async {
    isLoading = true;
    notifyListeners();
    try {
      projects = await _service.getProjects(token);
    } catch (e) {
      debugPrint('API fetch Error: $e');
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> createProject(
    String name,
    int? teamId,
    int userId,
    String token,
  ) async {
    await _service.createProject(name, teamId, userId, token);
    await fetchProjects(token);
  }

  Future<void> deleteProject(int id, String token) async {
    await _service.deleteProject(id, token);
    await fetchProjects(token);
  }

  Future<void> updateProject(
    int id,
    String name,
    int? teamId,
    String token,
  ) async {
    await _service.updateProject(id, name, teamId, token);
    await fetchProjects(token);
  }

  Future<bool> isProjectNameExist(String name, String teamId) async {
    return false;
  }
}
