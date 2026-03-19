class ProjectModel {
  final String id;
  final String name;
  final String shortcut;

  ProjectModel({required this.id, required this.name, required this.shortcut});

  // convert model to firebase
  Map<String, dynamic> toMap() {
    return {'name': name, 'shortcut': shortcut};
  }

  //convert firebase to model
  factory ProjectModel.fromFirestore(String id, Map<String, dynamic> data) {
    return ProjectModel(
      id: id,
      name: data['name'] ?? '',
      shortcut: data['shortcut'] ?? '',
    );
  }
}
