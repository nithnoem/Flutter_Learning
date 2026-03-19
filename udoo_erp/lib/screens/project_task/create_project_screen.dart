import 'package:flutter/material.dart';
import 'package:udoo_erp/model/project_task/project_model.dart';

class CreateProjectScreen extends StatefulWidget {
  const CreateProjectScreen({super.key});

  @override
  State<CreateProjectScreen> createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController shortcutController = TextEditingController();

  void createProject() {
    final project = ProjectModel(
      id: '',
      name: nameController.text,
      shortcut: shortcutController.text,
    );

    Navigator.pop(context, project);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Project")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Project Name"),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: shortcutController,
              decoration: const InputDecoration(labelText: "Shortcut"),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: createProject,
              child: const Text("Create Project"),
            ),
          ],
        ),
      ),
    );
  }
}
