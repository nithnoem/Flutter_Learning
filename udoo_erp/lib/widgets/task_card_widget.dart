import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final int progress;
  final String start;
  final String due;

  const TaskCard({
    super.key,
    required this.progress,
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
          Row(
            children: [
              Icon(Icons.check_box_outlined, color: Colors.teal),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          //Progress label
          Row(
            children: [
              Expanded(
                child: Text(
                  'Progress',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
              Text('$progress%', style: TextStyle(fontSize: 12)),
            ],
          ),
          SizedBox(height: 5),
          //Progress Bar
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(10),
            child: LinearProgressIndicator(
              value: progress / 100,
              minHeight: 6,
              backgroundColor: Colors.grey.shade300,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
            ),
          ),
          SizedBox(height: 12),
          //Date Row
          Row(
            children: [
              Icon(Icons.calendar_today, size: 14, color: Colors.grey.shade600),
              SizedBox(width: 8),
              Text('Start: $start'),
              SizedBox(width: 12),
              Icon(Icons.access_time, size: 14, color: Colors.redAccent),
              SizedBox(width: 8),
              Text('Due: $due', style: TextStyle(color: Colors.redAccent)),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  Icons.keyboard_arrow_up,
                  size: 16,
                  color: Colors.red,
                ),
              ),
              SizedBox(width: 10),
              CircleAvatar(
                radius: 12,
                backgroundImage: AssetImage('assets/images/profile.jpg'),
              ),
              SizedBox(width: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Todo',
                  style: TextStyle(color: Colors.blue, fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
