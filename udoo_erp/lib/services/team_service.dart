import 'package:supabase_flutter/supabase_flutter.dart';

class TeamService {
  final supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getTeams() async {
    final data = await supabase.from('teams').select();
    return List<Map<String, dynamic>>.from(data);
  }
}
