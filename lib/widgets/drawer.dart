import '../screens/notes_screen.dart';
import '../screens/projects_screen.dart';
import '../screens/timeline_screen.dart';
import '../screens/unplanned_tasks_screen.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.deepOrange),
            child: Row(
              children: [
                Image.asset(
                  "assets/icons/logo.png",
                  height: 35,
                ),
                const SizedBox(
                  width: 30,
                ),
                Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.white, width: 2))),
                  child: const Text(
                    'Schedule Planner',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.deepOrange,
          ),
          ListTile(
            leading: Image.asset(
              "assets/icons/timeline.png",
              height: 30,
            ),
            title: const Text('Timeline'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(TimelineScreen.routeName);
            },
          ),
          const Divider(
            color: Colors.deepOrange,
          ),
          ListTile(
            leading: Image.asset(
              "assets/icons/project.png",
              height: 30,
            ),
            title: const Text('Projects'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(ProjectsScreen.routeName);
            },
          ),
          const Divider(
            color: Colors.deepOrange,
          ),
          ListTile(
            leading: Image.asset(
              "assets/icons/unplanned.png",
              height: 30,
            ),
            title: const Text('Unplanned Tasks'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UnplannedTasksScreen.routeName);
            },
          ),
          const Divider(
            color: Colors.deepOrange,
          ),
          ListTile(
            leading: Image.asset(
              "assets/icons/notes.png",
              height: 30,
            ),
            title: const Text('Notes'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(NotesScreen.routeName);
            },
          ),
          const Divider(
            color: Colors.deepOrange,
          ),
        ],
      ),
    );
  }
}
