import 'package:flutter/material.dart';

class LeavesCard extends StatelessWidget {
  final String title;
  final String status;
  final String type;
  final String duration;
  final String start;
  final String due;

  const LeavesCard({
    super.key,
    required this.title,
    required this.status,
    required this.type,
    required this.duration,
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
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  status,
                  style: TextStyle(fontSize: 12, color: Colors.blue),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text('$type - $duration', style: TextStyle(color: Colors.grey)),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.calendar_today_outlined, color: Colors.grey),
              SizedBox(width: 8),
              Text('$start to $due'),
            ],
          ),
        ],
      ),
    );
  }
}
