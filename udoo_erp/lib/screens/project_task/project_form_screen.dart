import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udoo_erp/model/project_task/project_model.dart';
import 'package:udoo_erp/provider/project_provider.dart';
import 'package:udoo_erp/provider/team_provider.dart';

class ProjectFormScreen extends StatefulWidget {
  final ProjectModel? project;
  const ProjectFormScreen({super.key, this.project});

  @override
  State<ProjectFormScreen> createState() => _ProjectFormScreenState();
}

class _ProjectFormScreenState extends State<ProjectFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController = TextEditingController();
  late TextEditingController shortcutController = TextEditingController();
  String? selectedTeamId;
  String? nameError;

  bool get isEdit => widget.project != null;
  bool isManualEdit = false;
  String generateShortcut(String name) {
    return name
        // .trim()
        .split(' ')
        .where((word) => word.isNotEmpty)
        .map((word) => word[0].toUpperCase())
        .join();
  }

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.project?.name ?? "");
    shortcutController = TextEditingController(
      text: widget.project?.shortcut ?? "",
    );
    selectedTeamId = widget.project?.teamId;

    Future.microtask(() {
      Provider.of<TeamProvider>(context, listen: false).fetchTeams();
    });
  }

  void submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final provider = Provider.of<ProjectProvider>(context, listen: false);
    try {
      final exists = await provider.isProjectNameExist(
        nameController.text,
        selectedTeamId!,
      );
      if (exists && !isEdit) {
        setState(() {
          nameError = "Project already exists in this team";
        });
        return;
      }
      String shortcut = shortcutController.text;

      if (shortcut.isEmpty) {
        shortcut = generateShortcut(nameController.text);
      }

      shortcut = await provider.generateUniqueShortcut(shortcut);
      if (isEdit) {
        await provider.updateProject(
          widget.project!.id,
          nameController.text,
          shortcut,
          selectedTeamId,
        );
      } else {
        await provider.createProject(
          nameController.text,
          shortcut,
          selectedTeamId!,
        );

        await provider.createNotificationForTeam(
          teamId: selectedTeamId!,
          projectName: nameController.text,
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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Project Name",
                  errorText: nameError,
                ),
                onChanged: (value) {
                  if (!isManualEdit) {
                    shortcutController.text = generateShortcut(value);
                  }
                  setState(() {
                    nameError = null;
                  });
                },
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: shortcutController,
                decoration: const InputDecoration(labelText: "Shortcut"),
                onChanged: (value) {
                  isManualEdit = true;
                },
              ),

              SizedBox(height: 20),
              Consumer<TeamProvider>(
                builder: (context, teamProvider, child) {
                  if (teamProvider.isLoading) {
                    return CircularProgressIndicator();
                  }
                  if (teamProvider.teams.isEmpty) {
                    return Text("No teams available");
                  }
                  return DropdownButtonFormField(
                    value: selectedTeamId,
                    decoration: InputDecoration(labelText: "Assign to Team"),
                    items: teamProvider.teams.map((team) {
                      return DropdownMenuItem(
                        value: team.id,
                        child: Text(team.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedTeamId = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please select a team";
                      }
                      return null;
                    },
                  );
                },
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: submit,
                child: Text(isEdit ? "Update Project" : "Create Project"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
