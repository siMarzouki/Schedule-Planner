import '../models/project.dart';
import '../providers/project_manager.dart';
import '../models/task.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

Padding tableElement(String txt) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Text(
      txt,
      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
    ),
  );
}

class TaskScreen extends StatelessWidget {
  const TaskScreen({Key? key}) : super(key: key);
  static const routeName = "/task";

  @override
  Widget build(BuildContext context) {
    final _task = ModalRoute.of(context)!.settings.arguments as Task;
    var _mq = MediaQuery.of(context);

    late Project _project;
    if (_task.projectId > 0) {
      _project =
          Provider.of<ProjectManager>(context).getProjectById(_task.projectId);
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
            _task.title,
          ),
        ),
        body: ListView(
          children: [
            Image.asset(
              "assets/icons/task.png",
              height: _mq.size.height * 0.4,
            ),
            Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
                child: Table(
                  columnWidths: const {0: FractionColumnWidth(0.3)},
                  border: TableBorder.all(color: Colors.deepOrange),
                  children: [
                    TableRow(children: [
                      tableElement("Title"),
                      tableElement(_task.title),
                    ]),
                    TableRow(children: [
                      tableElement("Project"),
                      Padding(
                          padding: const EdgeInsets.all(5),
                          child: Chip(
                              label: Text(
                                _task.projectId > 0
                                    ? _project.title
                                    : "No Project",
                                style: const TextStyle(color: Colors.white),
                              ),
                              backgroundColor: _task.projectId > 0
                                  ? _project.bgColor
                                  : Colors.grey))
                    ]),
                    TableRow(children: [
                      tableElement("Date"),
                      tableElement(_task.date != null
                          ? DateFormat("E. d MMM. yyyy").format(_task.date!)
                          : ""),
                    ]),
                    TableRow(children: [
                      tableElement("Priority"),
                      tableElement(_task.priority),
                    ]),
                    TableRow(children: [
                      tableElement("Description"),
                      tableElement(_task.description),
                    ]),
                  ],
                )),
          ],
        ));
  }
}
