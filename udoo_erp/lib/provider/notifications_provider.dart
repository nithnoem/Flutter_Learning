import 'package:flutter/material.dart';
import 'package:udoo_erp/model/notifications_model.dart';
import 'package:udoo_erp/services/notifications_service.dart';

class NotificationsProvider extends ChangeNotifier {
  final NotificationsService _service = NotificationsService();

  List<NotificationsModel> notifications = [];
  bool isLoading = false;

  Future<void> fetchNotification() async {
    isLoading = true;
    notifyListeners();

    try {
      final data = await _service.fetchNotifications();
      notifications = data.map((e) => NotificationsModel.fromJson(e)).toList();
    } catch (e) {
      debugPrint("Notification error: $e");
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> markAsRead(String id) async {
    await _service.markAsRead(id);

    final index = notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      notifications[index] = NotificationsModel(
        id: notifications[index].id,
        userId: notifications[index].userId,
        title: notifications[index].title,
        body: notifications[index].body,
        type: notifications[index].type,
        isRead: notifications[index].isRead,
        createdAt: notifications[index].createdAt,
      );
    }
    notifyListeners();
  }

  int get unreadCount => notifications.where((n) => !n.isRead).length;
}
