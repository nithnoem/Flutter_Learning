class ProjectModel {
  final String id;
  final String name;
  final String shortcut;
  final String userId;

  ProjectModel({
    required this.id,
    required this.name,
    required this.shortcut,
    required this.userId,
  });

  // convert model to firebase
  Map<String, dynamic> toMap() {
    return {'name': name, 'shortcut': shortcut, 'userId': userId};
  }

  //convert firebase to model
  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'].toString(),
      name: json['name'] ?? "",
      shortcut: json['shortcut'] ?? "",
      userId: json['userId'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'shortcut': shortcut, 'userId': userId};
  }

  // factory ProjectModel.fromFirestore(String id, Map<String, dynamic> data) {
  //   return ProjectModel(
  //     id: id,
  //     name: data['name'] ?? '',
  //     shortcut: data['shortcut'] ?? '',
  //   );
  // }
}
