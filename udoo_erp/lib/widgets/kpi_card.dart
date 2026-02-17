import 'package:flutter/material.dart';

class KpiCard extends StatelessWidget {
  final String title;
  final String type;
  final double average;

  const KpiCard({
    super.key,
    required this.title,
    required this.type,
    required this.average,
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
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Text(
                'Monthly larget achievement',
                style: TextStyle(fontSize: 12),
              ),
              Spacer(),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: average / 100, // IMPORTANT
                    minHeight: 6,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFFF5A623),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Text(
                '${average.toInt()}%',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
