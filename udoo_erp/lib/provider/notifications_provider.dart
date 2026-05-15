// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:udoo_erp/model/notifications_model.dart';
import 'package:udoo_erp/services/notifications_service.dart';

class NotificationsProvider extends ChangeNotifier {
  final NotificationsService _service = NotificationsService();

  List<NotificationsModel> notifications = [];
  bool isLoading = false;

  Future<void> fetchNotification(String token) async {
    isLoading = true;
    notifyListeners();

    try {
      final data = await _service.fetchNotifications(token);
      notifications = data;
    } catch (e) {
      debugPrint("Notification error: $e");
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> markAsRead(String token, String uuid) async {
    try {
      await _service.markAsRead(token, uuid);

      int index = notifications.indexWhere((n) => n.id == uuid);
      if (index != -1) {
        notifications[index].isReadLocal = true;
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Mark as read error: $e");
    }
  }
}
