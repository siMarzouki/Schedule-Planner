import '../models/task.dart';
import '../providers/task_manager.dart';
import '../screens/edit_task_screen.dart';
import '../screens/task_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskItem extends StatefulWidget {
  final Task _task;
  const TaskItem(this._task, {Key? key}) : super(key: key);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    final _taskManager = Provider.of<TaskManager>(context, listen: false);
    return Container(
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey, width: 1))),
        margin: const EdgeInsets.all(5),
        child: ListTile(
          leading: IconButton(
            icon: Icon(
              widget._task.completed
                  ? Icons.check_circle
                  : Icons.check_circle_outline_sharp,
              color: Colors.blue,
              size: 30,
            ),
            onPressed: () {
              setState(() {
                _taskManager.toggleStatus(widget._task);
              });
            },
          ),
          title: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(TaskScreen.routeName, arguments: widget._task);
              },
              child: Text(widget._task.title)),
          trailing: PopupMenuButton<String>(
            icon: const Icon(Icons.more_horiz),
            iconSize: 20,
            onSelected: (String result) {
              if (result == "view") {}

              switch (result) {
                case "view":
                  {
                    Navigator.of(context).pushNamed(TaskScreen.routeName,
                        arguments: widget._task);
                  }
                  break;
                case "edit":
                  {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditTaskScreen(widget._task)));
                  }
                  break;
                case "delete":
                  {
                    showDialog<String>(
                        context: context,
                        builder: (ctx) {
                          return AlertDialog(
                            title:
                                const Text("Do you want to delete This Task ?"),
                            content: Text(widget._task.title),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("cancel")),
                              TextButton(
                                  onPressed: () {
                                    _taskManager
                                        .deleteTaskById(widget._task.id);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Delete"))
                            ],
                          );
                        });
                  }
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: "view",
                child: ListTile(
                  title: Text(
                    'View',
                  ),
                  leading: Icon(
                    Icons.remove_red_eye,
                    color: Colors.green,
                  ),
                ),
              ),
              const PopupMenuItem<String>(
                value: "edit",
                child: ListTile(
                  title: Text('Edit'),
                  leading: Icon(
                    Icons.edit,
                    color: Colors.blue,
                  ),
                ),
              ),
              const PopupMenuItem<String>(
                value: "delete",
                child: ListTile(
                  title: Text('Delete'),
                  leading: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
