class ProjectModel {
  final int id;
  final String name;
  final String? shortcut;
  final int userId;
  final int? teamId;

  ProjectModel({
    required this.id,
    required this.name,
    this.shortcut,
    required this.userId,
    this.teamId,
  });

  // convert model to JSON from Laravel
  Map<String, dynamic> toJson() {
    return {'name': name, 'user_id': userId, 'team_id': teamId};
  }

  //convert Json to model
  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
      name: json['name'] ?? "",
      userId: json['user_id'] is int
          ? json['user_id']
          : int.parse(json['user_id'].toString()),
      teamId: json['team_id'] is int
          ? json['team_id']
          : int.parse(json['team_id'].toString()),
    );
  }
}
