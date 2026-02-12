import 'package:flutter/material.dart';

class ApprovalCard extends StatelessWidget {
  final String title;
  final String type;
  final int amount;
  final String date;
  final String status;

  const ApprovalCard({
    super.key,
    required this.title,
    required this.type,
    required this.amount,
    required this.date,
    required this.status,
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
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text(
                '\$$amount',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Text(type, style: TextStyle(color: Colors.grey)),
              SizedBox(width: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue),
                ),
                child: Text(status, style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.calendar_today_outlined, color: Colors.grey),
              SizedBox(width: 10),
              Text(date, style: TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}
