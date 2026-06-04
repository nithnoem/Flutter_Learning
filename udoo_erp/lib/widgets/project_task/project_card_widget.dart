import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udoo_erp/model/project_task/project_model.dart';
import 'package:udoo_erp/provider/auth_provider.dart';
import 'package:udoo_erp/provider/project_provider.dart';
import 'package:udoo_erp/screens/project_task/project_form_screen.dart';
import 'package:udoo_erp/screens/project_task/task_screen.dart';

class ProjectCardWidget extends StatelessWidget {
  final ProjectModel project;

  const ProjectCardWidget({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskScreen(
              projectId: project.id,
              projectName: project.name,
              teamId: project.teamId!,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2),
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(
              'assets/images/erp.png',
              width: 40,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.business_center,
                  size: 40,
                  color: Colors.blueGrey,
                );
              },
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.name,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    project.shortcut ?? "NA",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            PopupMenuButton<String>(
              onSelected: (value) async {
                if (value == "edit") {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProjectFormScreen(project: project),
                    ),
                  );
                }
                if (value == "delete") {
                  final token = Provider.of<AuthProvider>(
                    context,
                    listen: false,
                  ).token;
                  await Provider.of<ProjectProvider>(
                    context,
                    listen: false,
                  ).deleteProject(project.id, token!);
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
      ),
    );
  }
}
