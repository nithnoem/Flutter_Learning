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

  Future<void> createProject(String name, String shortcut) async {
    await _service.createProject(name, shortcut);
    await fetchProjects();
  }

  Future<void> deleteProject(String id) async {
    await _service.deleteProject(id);
    await fetchProjects();
  }

  Future<void> updateProject(String id, String name, String shortcut) async {
    await _service.updateProject(id, name, shortcut);
    await fetchProjects();
  }

  // Future<void> addProject(ProjectModel project) async {
  //   final uid = FirebaseAuth.instance.currentUser!.uid;
  //
  //   await _firestore
  //       .collection('users')
  //       .doc(uid)
  //       .collection('projects')
  //       .add(project.toMap());
  // }
  //
  // Future<void> deleteProject(String projectId) async {
  //   final uid = FirebaseAuth.instance.currentUser!.uid;
  //
  //   await _firestore
  //       .collection('users')
  //       .doc(uid)
  //       .collection('projects')
  //       .doc(projectId)
  //       .delete();
  // }

  // Future<void> updateProject(ProjectModel project) async {
  //   final uid = FirebaseAuth.instance.currentUser!.uid;
  //   await _firestore
  //       .collection('users')
  //       .doc(uid)
  //       .collection('projects')
  //       .doc(project.id)
  //       .update(project.toMap());
  // }

  // Stream<List<ProjectModel>> getProjects() {
  //   final uid = FirebaseAuth.instance.currentUser!.uid;
  //   return _firestore
  //       .collection('users')
  //       .doc(uid)
  //       .collection('projects')
  //       .snapshots()
  //       .map((snapshot) {
  //         return snapshot.docs.map((doc) {
  //           return ProjectModel.fromFirestore(doc.id, doc.data());
  //         }).toList();
  //       });
  // }
}
