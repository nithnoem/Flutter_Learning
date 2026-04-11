import 'package:udoo_erp/screens/notifications_screen.dart';

class NotificationsModel {
  final String id;
  final String? userId;
  final String? teamId;
  final String title;
  final String body;
  final String type;
  final String? referenceId;
  final bool isRead;
  final DateTime createdAt;

  NotificationsModel({
    required this.id,
    this.userId,
    this.teamId,
    required this.title,
    required this.body,
    required this.type,
    this.referenceId,
    required this.isRead,
    required this.createdAt,
  });

  factory NotificationsModel.fromJson(Map<String, dynamic> json) {
    return NotificationsModel(
      id: json['id'],
      userId: json['user_id'],
      teamId: json['team_id'],
      title: json['title'],
      body: json['body'],
      type: json['type'],
      referenceId: json['reference_id'],
      isRead: json['is_read'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
