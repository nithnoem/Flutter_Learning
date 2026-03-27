import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:udoo_erp/model/project_task/project_model.dart';

class ProjectService {
  final supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getProjects() async {
    final user = supabase.auth.currentUser;
    print("User Id: ${user?.id}");
    if (user == null) {
      throw Exception("User not logged in!");
    }
    final data = await supabase
        .from('projects')
        .select()
        .eq('user_id', user.id);
    return List<Map<String, dynamic>>.from(data);
  }

  Future<void> createProject(String name, String shortcut) async {
    final user = supabase.auth.currentUser;
    if (user == null) {
      throw Exception("User not logged in!");
    }
    await supabase.from('projects').insert({
      'name': name,
      'shortcut': shortcut,
      'user_id': user.id,
    });
  }

  Future<void> updateProject(String id, String name, String shortcut) async {
    await supabase
        .from('projects')
        .update({'name': name, 'shortcut': shortcut})
        .eq('id', id);
  }

  Future<void> deleteProject(String id) async {
    await supabase.from('projects').delete().eq('id', id);
  }
}
