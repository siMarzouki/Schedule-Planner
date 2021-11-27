import '../providers/task_manager.dart';
import 'new_task_screen.dart';
import '../widgets/drawer.dart';
import '../widgets/task_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UnplannedTasksScreen extends StatefulWidget {
  const UnplannedTasksScreen({Key? key}) : super(key: key);
  static const routeName = "/unplanned-tasks";

  @override
  _UnplannedTasksScreenState createState() => _UnplannedTasksScreenState();
}

class _UnplannedTasksScreenState extends State<UnplannedTasksScreen> {
  @override
  Widget build(BuildContext context) {
    final _tasksManager = Provider.of<TaskManager>(context, listen: true);
    final _tasks = _tasksManager.getUnplannedTasks();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Unplanned Tasks"),
      ),
      drawer: const AppDrawer(),
      body: _tasks.isEmpty
          ? Image.asset(
              "assets/icons/empty_tasks.png",
              fit: BoxFit.contain,
            )
          : ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (ctx, idx) {
                return TaskItem(_tasks[idx]);
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(NewTaskScreen.routeName);
        },
      ),
    );
  }
}
