import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:udoo_erp/model/project_task/team_model.dart';
import 'package:udoo_erp/services/team_service.dart';

class TeamProvider extends ChangeNotifier {
  final TeamService _service = TeamService();

  List<TeamModel> teams = [];
  List<dynamic> teamMembers = [];
  bool isLoading = false;

  Future<void> fetchTeams(String token) async {
    isLoading = true;
    notifyListeners();

    try {
      final List<dynamic> data = await _service.getTeams(token);
      teams = data.map((json) => TeamModel.fromJson(json)).toList();
    } catch (e) {
      debugPrint("Team fetch error: $e");
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchTeamMembers(int teamId, String token) async {
    isLoading = true;
    notifyListeners();
    try {
      teamMembers = await _service.getTeamMembers(teamId, token);
    } catch (error) {
      debugPrint("Error fetching team memebers: $error");
    }
    isLoading = false;
    notifyListeners();
  }
}
