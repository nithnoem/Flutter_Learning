import 'package:flutter/material.dart';
import 'package:udoo_erp/model/project_task/project_model.dart';
import 'package:udoo_erp/services/project_service.dart';

class ProjectProvider extends ChangeNotifier {
  final ProjectService _service = ProjectService();

  List<ProjectModel> projects = [];
  bool isLoading = false;

  Future<void> fetchProjects() async {
    isLoading = true;
    notifyListeners();
    try {
      final data = await _service.getProjects();
      projects = data.map((map) => ProjectModel.fromJson(map)).toList();
    } catch (e) {
      debugPrint('API fetch Error: $e');
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> createProject(
    String name,
    String shortcut,
    String? teamId,
  ) async {
    await _service.createProject(name, shortcut, teamId);
    await fetchProjects();
  }

  Future<void> deleteProject(String id) async {
    await _service.deleteProject(id);
    await fetchProjects();
  }

  Future<void> updateProject(
    String id,
    String name,
    String shortcut,
    String? teamId,
  ) async {
    await _service.updateProject(id, name, shortcut, teamId);
    await fetchProjects();
  }

  Future<void> createNotificationForTeam({
    required String teamId,
    required String projectName,
  }) async {
    await _service.createNotificationForTeam(teamId, projectName);
  }

  Future<String> generateUniqueShortcut(String base) async {
    String shortcut = base;
    int counter = 1;
    while (await _service.isShortcutExist(shortcut)) {
      shortcut = "$base$counter";
      counter++;
    }
    return shortcut;
  }

  Future<bool> isProjectNameExist(String name, String teamId) async {
    return await _service.isProjectNameExist(name, teamId);
  }
}
