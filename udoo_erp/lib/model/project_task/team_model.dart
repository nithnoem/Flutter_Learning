class TeamModel {
  final dynamic id;
  final String name;

  TeamModel({required this.id, required this.name});

  // Convert Supabase JSON to TeamModel
  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(id: json['id'], name: json['name'] ?? '');
  }
}
