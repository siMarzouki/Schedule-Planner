import '../providers/note_manager.dart';
import '../providers/project_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewNoteScreen extends StatefulWidget {
  const NewNoteScreen({Key? key})
      : super(
          key: key,
        );
  static const routeName = "/note";

  @override
  State<NewNoteScreen> createState() => _NewNoteScreenState();
}

class _NewNoteScreenState extends State<NewNoteScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  String _priority = "Low";
  final _formKey = GlobalKey<FormState>();
  int _selectedProject = 0;

  @override
  void initState() {
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _notes = Provider.of<NoteManager>(context, listen: false);
    final _projects =
        Provider.of<ProjectManager>(context, listen: false).getProjects();

    return Scaffold(
      appBar: AppBar(title: const Text("New Note")),
      body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(8),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(hintText: "Title"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a note title";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 5,
                      minLines: 3,
                      decoration:
                          const InputDecoration(hintText: "Description"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a note description";
                        }
                        return null;
                      },
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 25, bottom: 10),
                        child: const Text(
                          "Select Project",
                          style: TextStyle(color: Colors.black54, fontSize: 16),
                        )),
                    SizedBox(
                      height: 50,
                      child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: _projects.map((p) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (_selectedProject == p.id) {
                                      setState(() {
                                        _selectedProject = 0;
                                      });
                                    } else {
                                      setState(() {
                                        _selectedProject = p.id;
                                      });
                                    }
                                  });
                                },
                                child: Chip(
                                    backgroundColor: _selectedProject == p.id
                                        ? p.bgColor
                                        : Colors.blueGrey[100],
                                    label: Text(
                                      p.title,
                                      style: TextStyle(
                                        color: _selectedProject == p.id
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    )),
                              ),
                            );
                          }).toList()),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 25, bottom: 10),
                        child: const Text(
                          "Select Priority",
                          style: TextStyle(color: Colors.black54, fontSize: 16),
                        )),
                    Container(
                      alignment: Alignment.topCenter,
                      child: DropdownButton<String>(
                        value: _priority,
                        onChanged: (String? newValue) {
                          setState(() {
                            _priority = newValue!;
                          });
                        },
                        style: const TextStyle(
                            color: Colors.blueGrey, fontSize: 18),
                        itemHeight: 50,
                        items: ['Low', 'Meduim', 'High', 'Urgent'].map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(
                              value,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _notes.addNote(
                                _titleController.text,
                                _descriptionController.text,
                                _priority,
                                _selectedProject);

                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text("Submit"))
                  ],
                ),
              ))),
    );
  }
}
