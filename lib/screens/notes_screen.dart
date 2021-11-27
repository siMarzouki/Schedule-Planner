import '../models/note.dart';
import '../providers/project_manager.dart';
import '../widgets/drawer.dart';
import '../widgets/note_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/note_manager.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);
  static const routeName = "/notes";
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    final _notesManager = Provider.of<NoteManager>(context, listen: true);
    final _projects =
        Provider.of<ProjectManager>(context, listen: false).getProjects();
    final _notes = _notesManager.getNotes();

    return Scaffold(
        appBar: AppBar(
          title: Text("Notes (${_notesManager.getNotes().length})"),
        ),
        drawer: const AppDrawer(),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed("/note");
          },
        ),
        body: SingleChildScrollView(
          child: _notes.isEmpty
              ? Image.asset(
                  "assets/icons/empty_notes.png",
                  fit: BoxFit.contain,
                )
              : ExpansionPanelList(
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
