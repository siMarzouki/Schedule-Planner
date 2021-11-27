import 'package:flutter/foundation.dart';
import '../models/note.dart';

class NoteManager with ChangeNotifier {
  final List<Note> _notes = [
    //seeds
    // Note(
    //     "Why to Learn HTML?",
    //     "Originally, HTML was developed with the intent of defining the structure of documents like headings, paragraphs, lists, and so forth to facilitate the sharing of scientific information between researchers. Now, HTML is being widely used to format web pages with the help of different tags available in HTML language.",
    //     "Low",
    //     1),
    // Note(
    //     "JavaScript is beginner-friendly",
    //     "Compared to many other programming languages, JavaScript offers one of the more beginner-friendly entry points into the world of coding. The great thing about it is that it comes installed on every modern web browser—there’s no need to set up any kind of development environment, which means you can start coding with JavaScript right away!",
    //     "Low",
    //     3),
    // Note(
    //     "SQL Server Download",
    //     "Start a mssql-server instance using a CU tag, in this example we use the CU 13 for SQL 2019 IMPORTANT NOTE: If you are using PowerShell on Windows to run these commands use double quotes instead of single quotes.",
    //     "High",
    //     0)
  ];

  List<Note> getNotes() {
    return _notes;
  }

  void addNote(
      String title, String description, String priority, int projectId) {
    Note newNote = Note(title, description, priority, projectId);
    _notes.add(newNote);
    notifyListeners();
  }

  List<Note> getNotesByProject(int projectId) {
    return _notes.where((element) => element.projectId == projectId).toList();
  }

  void deleteNoteById(int noteId) {
    _notes.removeWhere((element) => element.id == noteId);
    notifyListeners();
  }

  void toggleExpanded(Note n) {
    n.isExpanded = !n.isExpanded;
    notifyListeners();
  }
}
