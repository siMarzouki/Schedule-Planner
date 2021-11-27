import './screens/new_note_screen.dart';
import './screens/new_task_screen.dart';
import './screens/notes_screen.dart';
import './screens/task_details_screen.dart';
import './screens/projects_screen.dart';
import './screens/timeline_screen.dart';
import 'screens/unplanned_tasks_screen.dart';
import 'providers/task_manager.dart';
import 'providers/project_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/note_manager.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => NoteManager()),
      ChangeNotifierProvider(create: (_) => TaskManager()),
      ChangeNotifierProvider(create: (_) => ProjectManager()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      debugShowCheckedModeBanner: false,
      routes: {
        TimelineScreen.routeName: (context) => const TimelineScreen(),
        UnplannedTasksScreen.routeName: (context) =>
            const UnplannedTasksScreen(),
        ProjectsScreen.routeName: (context) => const ProjectsScreen(),
        NotesScreen.routeName: (context) => const NotesScreen(),
        NewNoteScreen.routeName: (context) => const NewNoteScreen(),
        NewTaskScreen.routeName: (context) => const NewTaskScreen(),
        TaskScreen.routeName: (context) => const TaskScreen(),
      },
      home: const TimelineScreen(),
    );
  }
}
