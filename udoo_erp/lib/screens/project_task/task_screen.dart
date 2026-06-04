import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:udoo_erp/model/project_task/task_model.dart';
import 'package:udoo_erp/provider/auth_provider.dart';
import 'package:udoo_erp/provider/task_provider.dart';
import 'package:udoo_erp/screens/project_task/task_form_screen.dart';

class TaskScreen extends StatefulWidget {
  final int projectId;
  final String projectName;
  final int teamId;

  const TaskScreen({
    Key? key,
    required this.projectId,
    required this.projectName,
    required this.teamId,
  }) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  String _selectedFilter = 'All Tasks';

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final auth = Provider.of<AuthProvider>(context, listen: false);
      Provider.of<TaskProvider>(
        context,
        listen: false,
      ).fetchTasksByProject(widget.projectId, auth.token!);
    });
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TaskProvider>();
    final authProvider = context.watch<AuthProvider>();
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: _appBar(),
      body: _body(taskProvider, authProvider),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black54),
      ),
      title: Text(
        widget.projectName,
        style: const TextStyle(
          color: Color(0xFF111111),
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      centerTitle: true,
      actions: [
        TextButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TaskFormScreen(
                  projectId: widget.projectId,
                  projectName: widget.projectName,
                  teamId: widget.teamId,
                ),
              ),
            ).then((_) {
              final auth = Provider.of<AuthProvider>(context, listen: false);
              Provider.of<TaskProvider>(
                context,
                listen: false,
              ).fetchTasksByProject(widget.projectId, auth.token!);
            });
          },
          icon: const Icon(Icons.add, size: 16, color: Color(0xFFFBBF24)),
          label: const Text(
            'Task',
            style: TextStyle(
              color: Color(0xFFFBBF24),
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _body(TaskProvider taskProvider, AuthProvider authProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _subNavigationBar,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              _searchIcon,
              const SizedBox(width: 10),
              Expanded(child: _filterPills),
            ],
          ),
        ),
        Expanded(child: _buildBodyContent(taskProvider, authProvider)),
      ],
    );
  }

  Widget _buildBodyContent(TaskProvider provider, AuthProvider auth) {
    if (provider.isLoading) {
      return Center(child: CircularProgressIndicator(color: Colors.orange));
    }
    if (provider.tasks.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("No task found!", style: TextStyle(color: Colors.black45)),
            SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              onPressed: () =>
                  provider.fetchTasksByProject(widget.projectId, auth.token!),
              child: Text(
                "Refresh board",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    }
    return RefreshIndicator(
      color: Colors.orange,
      child: _buildKanBanBoard(provider.tasks),
      onRefresh: () =>
          provider.fetchTasksByProject(widget.projectId, auth.token!),
    );
  }

  Widget get _subNavigationBar {
    final navItems = ['Board', 'Dashboard', 'All Work', 'List', 'Calendar'];
    return Container(
      color: Colors.white,
      height: 45,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16),
        children: navItems.map((item) {
          final isSelected = item == 'Board';
          return Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: isSelected
                  ? Border(bottom: BorderSide(color: Colors.orange, width: 2))
                  : null,
            ),
            alignment: Alignment.center,
            child: Text(
              item,
              style: TextStyle(
                color: isSelected ? Colors.orange : Colors.black45,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                fontSize: 13,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget get _searchIcon {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black12.withOpacity(0.04)),
      ),
      child: Icon(Icons.search, size: 16, color: Colors.black45),
    );
  }

  Widget get _filterPills {
    final filterOptions = ['All Tasks', 'Todo', 'In Progress', 'Review'];
    return SizedBox(
      height: 34,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: filterOptions.map((text) {
          final isSelected = _selectedFilter == text;
          return GestureDetector(
            onTap: () => setState(() => _selectedFilter = text),
            child: Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: isSelected ? Colors.orange : Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Text(
                text,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black54,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildKanBanBoard(List<Task> allTasks) {
    List<Task> filteredList = allTasks;
    if (_selectedFilter != 'All Tasks') {
      filteredList = allTasks
          .where(
            (task) =>
                task.status.toLowerCase() ==
                _selectedFilter.toLowerCase().replaceAll(' ', '_'),
          )
          .toList();
    }

    final backlogTasks = filteredList
        .where((task) => task.status.toLowerCase() == 'todo')
        .toList();
    final inProgressTasks = filteredList
        .where((task) => task.status.toLowerCase() == 'in progress')
        .toList();
    return ListView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16),
      children: [
        _buildKanbanLane('BACKLOG', backlogTasks, allTasks.length),
        _buildKanbanLane('IN PROGRESS', inProgressTasks, allTasks.length),
      ],
    );
  }

  Widget _buildKanbanLane(String title, List<Task> laneTasks, int totalCount) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.88,
      margin: EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black12.withOpacity(0.03)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$title (${laneTasks.length})',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 13,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12),
          Expanded(
            child: ListView(
              children: laneTasks.map((task) => _taskItemCard(task)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _taskItemCard(Task task) {
    final double completionProgress = task.status.toLowerCase() == 'done'
        ? 1.0
        : (task.status.toLowerCase() == 'in_progress' ? 0.5 : 0.0);

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12.withOpacity(0.02)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.01),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.assignment_turned_in_outlined,
                size: 18,
                color: Color(0xFF22D3EE),
              ),
              SizedBox(width: 8),
              Expanded(child: Text('KEY-0${task.id} Title: ${task.title}')),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Progress',
                style: TextStyle(color: Colors.black38, fontSize: 11),
              ),
              Text(
                '${(completionProgress * 100).toInt()}%',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: completionProgress,
              backgroundColor: Color(0xFFF3F4F6),
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFE5E7EB)),
              minHeight: 5,
            ),
          ),
          SizedBox(height: 14),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 12, color: Colors.black38),
              SizedBox(width: 4),
              Text(
                'start: ${task.startDate ?? "N/A"}',
                style: TextStyle(color: Colors.black45, fontSize: 11),
              ),
              SizedBox(width: 10),
              Icon(
                Icons.local_fire_department,
                size: 13,
                color: Colors.redAccent,
              ),
              SizedBox(width: 2),
              Text(
                'Start: ${task.dueDate ?? "N/A"}',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Color(0xFFFFF1F2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(
                  _getPriorityIcon(task.priority),
                  size: 14,
                  color: Colors.redAccent,
                ),
              ),
              CircleAvatar(
                radius: 11,
                backgroundColor: Color(0xFFE5E7EB),
                child: Icon(Icons.person, size: 12, color: Colors.black38),
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getPriorityIcon(String priority) {
    if (priority.toLowerCase() == 'high')
      return Icons.keyboard_double_arrow_up_rounded;
    return Icons.keyboard_arrow_up_rounded;
  }
}
