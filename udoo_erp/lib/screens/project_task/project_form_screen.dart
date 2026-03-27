import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udoo_erp/model/project_task/project_model.dart';
import 'package:udoo_erp/provider/project_provider.dart';

class ProjectFormScreen extends StatefulWidget {
  final ProjectModel? project;
  const ProjectFormScreen({super.key, this.project});

  @override
  State<ProjectFormScreen> createState() => _ProjectFormScreenState();
}

class _ProjectFormScreenState extends State<ProjectFormScreen> {
  late TextEditingController nameController = TextEditingController();
  late TextEditingController shortcutController = TextEditingController();

  bool get isEdit => widget.project != null;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.project?.name ?? "");
    shortcutController = TextEditingController(
      text: widget.project?.shortcut ?? "",
    );
  }

  void submit() async {
    final provider = Provider.of<ProjectProvider>(context, listen: false);
    try {
      if (isEdit) {
        // final updatedProject = ProjectModel(
        //   id: widget.project!.id,
        //   name: nameController.text,
        //   shortcut: shortcutController.text,
        // );

        await provider.updateProject(
          widget.project!.id!,
          nameController.text,
          shortcutController.text,
        );
      } else {
        await provider.createProject(
          nameController.text,
          shortcutController.text,
        );
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(isEdit ? 'Project updated' : 'Project created')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
      print('Create Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? "Edit Project" : "Create Project")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Project Name"),
            ),

            const SizedBox(height: 20),

            TextFormField(
              controller: shortcutController,
              decoration: const InputDecoration(labelText: "Shortcut"),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: submit,
              child: Text(isEdit ? "Update Project" : "Create Project"),
            ),
          ],
        ),
      ),
    );
  }
}
