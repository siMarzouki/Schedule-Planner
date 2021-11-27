import '../providers/project_manager.dart';
import '../providers/task_manager.dart';
import 'project_screen.dart';
import '../widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/create_project_button.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({Key? key}) : super(key: key);
  static const routeName = "/projects";

  @override
  _ProjectsScreenState createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  @override
  Widget build(BuildContext context) {
    final _projectManager = Provider.of<ProjectManager>(context, listen: true);
    final _projects = _projectManager.getProjects();
    final _tasksManager = Provider.of<TaskManager>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Projects"),
        ),
        drawer: const AppDrawer(),
        body: ListView.builder(
          itemCount: _projects.length,
          itemBuilder: (ctx, index) {
            final _projectTasks =
                _tasksManager.getTasksByProject(_projects[index].id);
            final _completedTasks =
                _tasksManager.getDoneTasksNumber(_projectTasks);
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProjectScreen(_projects[index].id)));
              },
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                    color: _projects[index].bgColor,
                    borderRadius: BorderRadius.circular(5)),
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Container(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: Text(
                      _projects[index].title,
                      style: const TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ),
                  trailing: Text(
                    "$_completedTasks/${_projectTasks.length}",
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  subtitle: LinearProgressIndicator(
                    value: _projectTasks.isNotEmpty
                        ? _completedTasks / _projectTasks.length
                        : 0,
                    backgroundColor: Colors.white,
                    minHeight: 8,
                  ),
                ),
              ),
            );
          },
        ),
        floatingActionButton: const CreateProjectButton());
  }
}
