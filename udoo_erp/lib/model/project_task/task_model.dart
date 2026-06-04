class Task {
  final int id;
  final int projectId;
  final int? assignedTo;
  final String title;
  final String? description;
  final String priority;
  final DateTime? startDate;
  final DateTime? dueDate;
  final String status;

  Task({
    required this.id,
    required this.projectId,
    this.assignedTo,
    required this.title,
    this.description,
    this.priority = 'medium',
    this.startDate,
    this.dueDate,
    this.status = 'todo',
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      projectId: json['project_id'],
      assignedTo: json['assigned_to'],
      title: json['title'],
      description: json['description'],
      priority: json['priority'] ?? 'medium',
      startDate: json['start_date'] != null
          ? DateTime.parse(json['start_date'])
          : null,
      dueDate: json['due_date'] != null
          ? DateTime.parse(json['due_date'])
          : null,
      status: json['status'] ?? 'todo',
    );
  }
}
