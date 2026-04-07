class TeamModel {
  final String id;
  final String name;
  final DateTime? createdAt;

  TeamModel({required this.id, required this.name, this.createdAt});

  // Convert Supabase JSON to TeamModel
  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      id: json['id'],
      name: json['name'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }

  // Convert TeamModel back to JSON (for inserting)
  Map<String, dynamic> toJson() {
    return {'name': name};
  }
}
