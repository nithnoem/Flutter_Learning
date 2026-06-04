import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:udoo_erp/provider/auth_provider.dart';
import 'package:udoo_erp/provider/task_provider.dart';
import 'package:udoo_erp/provider/team_provider.dart';

class TaskFormScreen extends StatefulWidget {
  final int projectId;
  final String projectName;
  final int teamId;

  const TaskFormScreen({
    Key? key,
    required this.projectId,
    required this.projectName,
    required this.teamId,
  }) : super(key: key);

  @override
  State<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _startDateController = TextEditingController();
  final _dueDateController = TextEditingController();
  String _selectPriority = 'Medium';
  int? _selectedAssigneeId;
  DateTime? _startDate;
  DateTime? _dueDate;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final auth = Provider.of<AuthProvider>(context, listen: false);
      final token = auth.token;
      if (token != null) {
        Provider.of<TeamProvider>(
          context,
          listen: false,
        ).fetchTeamMembers(widget.teamId, token);
      }
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _startDateController.dispose();
    _dueDateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2026),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.orange,
              onPrimary: Colors.white,
              onSurface: Colors.black87,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
          _startDateController.text = DateFormat('dd-MM-yyyy').format(picked);
        } else {
          _dueDate = picked;
          _dueDateController.text = DateFormat('dd-MM-yyyy').format(picked);
        }
      });
    }
  }

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) return;
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    final DateFormat format = DateFormat('yyyy-MM-dd');
    final String? formatStart = _startDate != null
        ? format.format(_startDate!)
        : null;
    final String? formatDue = _dueDate != null
        ? format.format(_dueDate!)
        : null;

    final success = await taskProvider.createTask(
      projectId: widget.projectId,
      title: _titleController.text.trim(),
      priority: _selectPriority,
      startDate: formatStart,
      dueDate: formatDue,
      description: _descriptionController.text.trim(),
      token: authProvider.token!,
      assigneeId: _selectedAssigneeId,
    );
    if (success && mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Create New Task')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  initialValue: widget.projectName,
                  decoration: InputDecoration(labelText: "Project"),
                  readOnly: true,
                  enabled: false,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: "Task Title"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a task title";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: _selectPriority,
                  decoration: InputDecoration(labelText: "Priority"),
                  items: ['Low', 'Medium', 'High'].map((String priority) {
                    return DropdownMenuItem(
                      value: priority,
                      child: Text(priority),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectPriority = value!;
                    });
                  },
                ),
                SizedBox(height: 20),
                Consumer<TeamProvider>(
                  builder: (context, teamProvider, child) {
                    if (teamProvider.isLoading) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "No team members found for this project.",
                            style: TextStyle(color: Colors.redAccent),
                          ),
                        ),
                      );
                    }
                    return DropdownButtonFormField(
                      value: _selectedAssigneeId,
                      decoration: InputDecoration(labelText: "Assignee"),
                      hint: Text("Choose assignee"),
                      items: teamProvider.teamMembers.map((member) {
                        return DropdownMenuItem<int>(
                          value: member['id'] as int,
                          child: Text(member['name'] as String),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedAssigneeId = value;
                        });
                      },
                    );
                  },
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () => _selectDate(context, true),
                  child: IgnorePointer(
                    child: TextFormField(
                      controller: _startDateController,
                      decoration: InputDecoration(
                        labelText: "Start Date",
                        hintText: "dd-mm-yyyy",
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () => _selectDate(context, false),
                  child: IgnorePointer(
                    child: TextFormField(
                      controller: _dueDateController,
                      decoration: InputDecoration(
                        labelText: "Due Date",
                        hintText: "dd-mm-yyyy",
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: "Description"),
                  maxLines: 1,
                ),
                SizedBox(height: 20),
                Consumer<TaskProvider>(
                  builder: (context, taskProvider, child) {
                    return ElevatedButton(
                      onPressed: taskProvider.isCreating ? null : _submitForm,
                      child: taskProvider.isCreating
                          ? SizedBox(
                              width: 30,
                              height: 30,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text("Create Task"),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
