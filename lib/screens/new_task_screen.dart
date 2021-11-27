import '../providers/project_manager.dart';
import '../providers/task_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({Key? key}) : super(key: key);
  static const routeName = "/new_task";

  @override
  _NewTaskScreenState createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  String _priority = "Low";
  final _formKey = GlobalKey<FormState>();
  int _selectedProject = 0;
  DateTime? _selectedDate;

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
    final _tasks = Provider.of<TaskManager>(context, listen: false);
    final _projects =
        Provider.of<ProjectManager>(context, listen: false).getProjects();
    return Scaffold(
      appBar: AppBar(title: const Text("New Task")),
      body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(8),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(hintText: "Title"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a task title";
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
                          return "Please enter a task description";
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
                    Container(
                        margin: const EdgeInsets.only(top: 25, bottom: 10),
                        child: const Text(
                          "Pick a date ",
                          style: TextStyle(color: Colors.black54, fontSize: 16),
                        )),
                    Container(
                        alignment: Alignment.center,
                        child: Text(
                          _selectedDate == null
                              ? ""
                              : _selectedDate!.toString().substring(0, 10),
                          style: const TextStyle(
                              color: Colors.black87, fontSize: 18),
                        )),
                    Container(
                      alignment: Alignment.center,
                      child: OutlinedButton(
                          onPressed: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2025),
                            );

                            if (picked != null && picked != _selectedDate) {
                              setState(() {
                                _selectedDate = picked;
                              });
                            }
                          },
                          child: const Text("open Calendar")),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _tasks.addTask(
                                  _titleController.text,
                                  _descriptionController.text,
                                  _selectedDate,
                                  _priority,
                                  _selectedProject);

                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text("Submit")),
                    )
                  ],
                ),
              ))),
    );
  }
}
