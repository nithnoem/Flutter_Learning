import 'package:supabase_flutter/supabase_flutter.dart';

class NotificationsService {
  final supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> fetchNotifications() async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      throw Exception("User not logged in");
    }
    final data = await supabase
        .from('notifications')
        .select()
        .eq('user_id', user.id)
        .order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(data);
  }

  Future<void> markAsRead(String id) async {
    await supabase.from('notifications').update({'is_read': true}).eq('id', id);
  }
}
