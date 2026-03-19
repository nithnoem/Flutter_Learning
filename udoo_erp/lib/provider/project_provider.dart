import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:udoo_erp/model/project_task/project_model.dart';

class ProjectProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // final List<ProjectModel> _projects = [
  //   ProjectModel(id: "", name: "Demo Project", shortcut: "DP"),
  // ];

  // List<ProjectModel> get projects => _projects;

  // Future<void> addProject(ProjectModel project) async {
  //   await _firestore.collection("projects").add(project.toMap());
  //   // _projects.add(project);
  //   // notifyListeners();
  // }

  Future<void> addProject(ProjectModel project) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    await _firestore
        .collection('users')
        .doc(uid)
        .collection('projects')
        .add(project.toMap());
  }

  // void deleteProject(ProjectModel project) {
  //   _projects.remove(project);
  //   notifyListeners();
  // }

  Stream<List<ProjectModel>> getProjects() {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('projects')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return ProjectModel.fromFirestore(doc.id, doc.data());
          }).toList();
        });
    // return _firestore.collection('projects').snapshots().map((snapshort) {
    //   return snapshort.docs.map((doc) {
    //     return ProjectModel.fromFirestore(doc.id, doc.data());
    //   }).toList();
    // });
  }
}
