import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/project_manager.dart';

class CreateProjectButton extends StatefulWidget {
  const CreateProjectButton({Key? key}) : super(key: key);

  @override
  _CreateProjectButtonState createState() => _CreateProjectButtonState();
}

class _CreateProjectButtonState extends State<CreateProjectButton> {
  final _colors = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
  ];
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  Color _pickedColor = Colors.red;

  @override
  void initState() {
    _nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return StatefulBuilder(
                builder: (ctx, setS) {
                  return Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _nameController,
                            decoration:
                                const InputDecoration(hintText: "Project Name"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter a project name";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const Text(
                            "Pick a Color :",
                            style:
                                TextStyle(fontSize: 18, color: Colors.black54),
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 100,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: _colors.map((color) {
                                return Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: CircleAvatar(
                                    backgroundColor: color,
                                    child: Radio<Color>(
                                      value: color,
                                      activeColor: Colors.white,
                                      groupValue: _pickedColor,
                                      onChanged: (Color? c) {
                                        setS(() {
                                          _pickedColor = c!;
                                        });
                                      },
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  Provider.of<ProjectManager>(context,
                                          listen: false)
                                      .addProject(
                                          _nameController.text, _pickedColor);

                                  Navigator.of(context).pop();
                                  _nameController.text = "";
                                  _pickedColor = Colors.red;
                                }
                              },
                              child: const Text("Create Project"))
                        ],
                      ),
                    ),
                  );
                },
              );
            });
      },
    );
  }
}
