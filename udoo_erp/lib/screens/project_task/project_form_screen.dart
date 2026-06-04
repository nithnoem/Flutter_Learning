import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udoo_erp/model/project_task/project_model.dart';
import 'package:udoo_erp/provider/project_provider.dart';
import 'package:udoo_erp/provider/team_provider.dart';
import 'package:udoo_erp/provider/auth_provider.dart';

class ProjectFormScreen extends StatefulWidget {
  final ProjectModel? project;
  const ProjectFormScreen({super.key, this.project});

  @override
  State<ProjectFormScreen> createState() => _ProjectFormScreenState();
}

class _ProjectFormScreenState extends State<ProjectFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController = TextEditingController();
  dynamic selectedTeamId;
  String? nameError;
  bool isManualEdit = false;
  bool get isEdit => widget.project != null;

  String generateShortcut(String name) {
    return name
        .trim()
        .split(' ')
        .where((word) => word.isNotEmpty)
        .map((word) => word[0].toUpperCase())
        .join();
  }

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.project?.name ?? "");
    selectedTeamId = widget.project?.teamId;

    Future.microtask(() {
      final auth = Provider.of<AuthProvider>(context, listen: false);
      final token = auth.token;

      if (token != null) {
        Provider.of<TeamProvider>(context, listen: false).fetchTeams(token);
      }
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void submit() async {
    if (!_formKey.currentState!.validate()) return;
    final projectProvider = Provider.of<ProjectProvider>(
      context,
      listen: false,
    );
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final activedId = authProvider.userId;
    final token = authProvider.token;

    if (activedId == null || token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error: User not authenticated")),
      );
      return;
    }
    try {
      if (isEdit) {
        await projectProvider.updateProject(
          widget.project!.id,
          nameController.text,
          selectedTeamId,
          token,
        );
      } else {
        //pass active user id
        await projectProvider.createProject(
          nameController.text,
          selectedTeamId,
          activedId,
          token,
        );
      }
      if (mounted) {
        Navigator.pop(context);
      }
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
                  setState(() {
                    nameError = null;
                  });
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
                      if (value == null) {
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
