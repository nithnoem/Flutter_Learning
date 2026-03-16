import 'package:flutter/material.dart';

class ProjectCardWidget extends StatelessWidget {
  final String name;
  final String shortcut;

  const ProjectCardWidget({
    super.key,
    required this.name,
    required this.shortcut,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsGeometry.only(bottom: 12),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.grey.withValues(alpha: 0.2), blurRadius: 3),
        ],
      ),
      child: Row(
        children: [
          Image.asset('assets/images/erp.png', width: 40),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(shortcut, style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == "edit") {
                print("Edit $name");
              }
              if (value == "delete") {
                print("Delete $name");
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: "edit",
                child: Row(
                  children: [
                    Icon(Icons.edit),
                    SizedBox(width: 10),
                    Text("Edit"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: "delete",
                child: Row(
                  children: [
                    Icon(Icons.delete),
                    SizedBox(width: 10),
                    Text("Delete"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
