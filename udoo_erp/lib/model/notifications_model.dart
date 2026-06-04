import 'dart:convert';

class NotificationsModel {
  final String id;
  final String type;
  final Map<String, dynamic> data;
  final DateTime? readAt;
  final DateTime createdAt;
  bool isReadLocal;

  NotificationsModel({
    required this.id,
    required this.type,
    required this.data,
    this.readAt,
    required this.createdAt,
    this.isReadLocal = false,
  });

  factory NotificationsModel.fromJson(Map<String, dynamic> json) {
    return NotificationsModel(
      id: json['id'],
      type: json['type'],
      data: json['data'],
      readAt: json['readAt'] != null ? DateTime.parse(json['read_at']) : null,
      createdAt: DateTime.parse(json['created_at']),
      isReadLocal: json['read_at'] != null,
    );
  }

  bool get isRead => isReadLocal || readAt != null;
}
