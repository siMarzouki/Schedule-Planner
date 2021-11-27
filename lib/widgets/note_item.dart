import '../models/note.dart';
import '../providers/note_manager.dart';
import '../models/project.dart';
import 'package:flutter/material.dart';

ExpansionPanel noteItem(Note n, List<Project> projects, BuildContext context,
    NoteManager notesProvider) {
  return ExpansionPanel(
      isExpanded: n.isExpanded,
      headerBuilder: (ctx, isOpen) {
        return ListTile(
          title: Text(n.title),
          trailing: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1)),
              child: Text(n.priority)),
        );
      },
      body: ListTile(
        leading: n.projectId == 0
            ? const Chip(
                label: Text("No Project"),
              )
            : Chip(
                backgroundColor: projects
                    .firstWhere((element) => element.id == n.projectId)
                    .bgColor,
                label: Text(
                  projects
                      .firstWhere((element) => element.id == n.projectId)
                      .title,
                  style: const TextStyle(color: Colors.white),
                )),
        trailing: IconButton(
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
          onPressed: () {
            showDialog<String>(
                context: context,
                builder: (ctx) {
                  return AlertDialog(
                    title: const Text("Do you want to delete This Note ?"),
                    content: Text(n.title),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("cancel")),
                      TextButton(
                          onPressed: () {
                            notesProvider.deleteNoteById(n.id);
                            Navigator.of(context).pop();
                          },
                          child: const Text("Delete"))
                    ],
                  );
                });
          },
        ),
        subtitle: Text(n.description),
      ));
}
