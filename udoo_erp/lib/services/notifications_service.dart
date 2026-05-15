import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:udoo_erp/model/notifications_model.dart';

class NotificationsService {
  final String baseUrl = "http://127.0.0.1:8000/api";

  Future<List<NotificationsModel>> fetchNotifications(String token) async {
    final response = await http.get(
      Uri.parse("$baseUrl/notifications"),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data
          .map(
            (item) => NotificationsModel.fromJson(item as Map<String, dynamic>),
          )
          .toList();
    } else {
      throw Exception("Failed to load notifications");
    }
  }

  Future<void> markAsRead(String token, String uuid) async {
    await http.post(
      Uri.parse('$baseUrl/notifications/$uuid/read'),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );
  }
}
