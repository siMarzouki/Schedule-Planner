import '../models/note.dart';
import '../providers/note_manager.dart';
import '../providers/project_manager.dart';
import '../providers/task_manager.dart';
import '../widgets/note_item.dart';
import '../widgets/task_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProjectScreen extends StatefulWidget {
  final int projecId;
  const ProjectScreen(this.projecId, {Key? key}) : super(key: key);

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  var _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final _project =
        Provider.of<ProjectManager>(context).getProjectById(widget.projecId);
    final _homeViews = [TasksView(widget.projecId), NotesView(widget.projecId)];

    return Scaffold(
      appBar: AppBar(
        title: Text(_project.title),
      ),
      body: _homeViews[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: const Color.fromRGBO(40, 120, 120, 1),
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.yellow,
        onTap: (val) {
          setState(() {
            _currentIndex = val;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/icons/unplanned.png",
                height: 25,
                color: Colors.white,
              ),
              label: "Tasks"),
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/icons/notes.png",
                height: 25,
                color: Colors.white,
              ),
              label: "Notes"),
        ],
      ),
    );
  }
}

class TasksView extends StatefulWidget {
  final int projecId;
  const TasksView(this.projecId, {Key? key}) : super(key: key);

  @override
  _TasksViewState createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  @override
  Widget build(BuildContext context) {
    final _tasks =
        Provider.of<TaskManager>(context).getTasksByProject(widget.projecId);
    return Container(
      child: _tasks.isEmpty
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
    );
  }
}

class NotesView extends StatefulWidget {
  final int projectId;
  const NotesView(this.projectId, {Key? key}) : super(key: key);

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    final _notesManager = Provider.of<NoteManager>(context);
    final _notes = _notesManager.getNotesByProject(widget.projectId);
    final _projects =
        Provider.of<ProjectManager>(context, listen: false).getProjects();
    return Container(
        child: _notes.isEmpty
            ? Image.asset(
                "assets/icons/empty_notes.png",
                fit: BoxFit.contain,
              )
            : SingleChildScrollView(
                child: ExpansionPanelList(
                  expansionCallback: (int index, bool isExpanded) {
                    setState(() {
                      _notesManager.toggleExpanded(_notes[index]);
                    });
                  },
                  children: _notes.map((Note n) {
                    return noteItem(n, _projects, context, _notesManager);
                  }).toList(),
                ),
              ));
  }
}
