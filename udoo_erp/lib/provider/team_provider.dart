import 'package:flutter/material.dart';
import 'package:udoo_erp/model/project_task/team_model.dart';
import 'package:udoo_erp/services/team_service.dart';

class TeamProvider extends ChangeNotifier {
  final TeamService _service = TeamService();

  List<TeamModel> teams = [];
  bool isLoading = false;

  Future<void> fetchTeams() async {
    isLoading = true;
    notifyListeners();

    try {
      final data = await _service.getTeams();
      teams = data.map((e) => TeamModel.fromJson(e)).toList();
    } catch (e) {
      debugPrint("Team fetch error: $e");
    }
    isLoading = false;
    notifyListeners();
  }
}
