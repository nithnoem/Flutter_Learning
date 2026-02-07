import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String start;
  final String due;

  const TaskCard({
    super.key,
    required this.title,
    required this.start,
    required this.due,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('Progress 0%', style: TextStyle(color: Colors.grey)),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 14, color: Colors.grey),
              SizedBox(width: 6),
              Text('Start: $start', style: TextStyle(fontSize: 12)),
              Spacer(),
              Text(
                'Due: $due',
                style: TextStyle(fontSize: 12, color: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
