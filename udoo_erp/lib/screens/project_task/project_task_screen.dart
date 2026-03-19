import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udoo_erp/model/project_task/project_model.dart';
import 'package:udoo_erp/provider/project_provider.dart';
import 'package:udoo_erp/screens/project_task/create_project_screen.dart';
import 'package:udoo_erp/widgets/project_task/project_card_widget.dart';

class ProjectTaskScreen extends StatefulWidget {
  const ProjectTaskScreen({super.key});

  @override
  State<ProjectTaskScreen> createState() => _ProjectTaskScreenState();
}

class _ProjectTaskScreenState extends State<ProjectTaskScreen> {
  @override
  Widget build(BuildContext context) {
    final projectProvider = Provider.of<ProjectProvider>(context);
    return Scaffold(
      appBar: _appBar(context),
      body: StreamBuilder<List<ProjectModel>>(
        stream: projectProvider.getProjects(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final projects = snapshot.data!;

          return ListView(
            padding: EdgeInsets.all(16),
            children: [
              _searchBar,
              SizedBox(height: 20),
              _sectionTitle("All Projects"),
              SizedBox(height: 10),

              ...projects.map((project) {
                return ProjectCardWidget(
                  name: project.name,
                  shortcut: project.shortcut,
                );
              }),
            ],
          );
        },
      ),
      // body: ListView(
      //   padding: EdgeInsets.all(16),
      //   children: [
      //     _searchBar,
      //     const SizedBox(height: 20),
      //     _sectionTitle("Recently Viewed"),
      //     const SizedBox(height: 10),
      //     //
      //     const SizedBox(height: 20),
      //     _sectionTitle("All Projects"),
      //     const SizedBox(height: 10),
      //     ...projectProvider.map(
      //       (project) => ProjectCardWidget(
      //         name: project.name,
      //         shortcut: project.shortcut,
      //       ),
      //     ),
      //   ],
      // ),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      title: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text('Oddo ERP', style: TextStyle(fontWeight: FontWeight.bold)),
          Text(
            'Project Task',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
      actions: [
        PopupMenuButton<String>(
          icon: Icon(Icons.add, color: Colors.orange),
          onSelected: (value) async {
            if (value == "project") {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateProjectScreen()),
              );
              if (result != null) {
                await Provider.of<ProjectProvider>(
                  context,
                  listen: false,
                ).addProject(result);
              }
            }
            if (value == "task") {
              print("Task");
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: "project",
              child: Row(
                children: [
                  Icon(Icons.inventory_2_outlined),
                  SizedBox(width: 10),
                  Text("New Project"),
                ],
              ),
            ),
            PopupMenuItem(
              value: "task",
              child: Row(
                children: [
                  Icon(Icons.task_alt),
                  SizedBox(width: 10),
                  Text("New Task"),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

Widget _drawer() {
  return Drawer(
    child: ListView(
      children: [
        DrawerHeader(child: Text('Project Menu')),
        ListTile(leading: Icon(Icons.dashboard), title: Text('Project')),
      ],
    ),
  );
}

Widget get _searchBar {
  return TextField(
    decoration: InputDecoration(
      hintText: "Search projects",
      prefixIcon: Icon(Icons.search),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    ),
  );
}

Widget _sectionTitle(String title) {
  return Text(
    title,
    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  );
}
