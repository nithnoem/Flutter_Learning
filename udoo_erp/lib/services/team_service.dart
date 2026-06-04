import 'dart:convert';
import 'package:http/http.dart' as http;

class TeamService {
  final String baseUrl = "http://127.0.0.1:8000/api";
  Map<String, String> _getHeaders(String token) => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };
  Future<List<dynamic>> getTeams(String token) async {
    final response = await http.get(
      Uri.parse("$baseUrl/teams"),
      headers: _getHeaders(token),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load teams: ${response.statusCode}");
    }
  }

  Future<List<dynamic>> getTeamMembers(int teamId, String token) async {
    final response = await http.get(
      Uri.parse("$baseUrl/teams/$teamId/members"),
      headers: _getHeaders(token),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load team members: ${response.statusCode}");
    }
  }
}
