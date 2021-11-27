import '../providers/task_manager.dart';
import '../widgets/drawer.dart';
import '../widgets/task_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'new_task_screen.dart';

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({Key? key}) : super(key: key);
  static const routeName = "/timeline";

  @override
  _TimelineScreenState createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final _tasks =
        Provider.of<TaskManager>(context, listen: true).getTasksByDate(date);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Timeline"),
        actions: [
          IconButton(
              onPressed: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: date,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2025),
                );

                if (picked != null && picked != date) {
                  setState(() {
                    date = picked;
                  });
                }
              },
              icon: const Icon(Icons.calendar_today_outlined))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(NewTaskScreen.routeName);
        },
      ),
      drawer: const AppDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 13, horizontal: 30),
            child: Text(
              DateFormat("E.   d MMM.").format(date),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            child: _tasks.isEmpty
                ? Image.asset(
                    "assets/icons/empty_tasks.png",
                    fit: BoxFit.contain,
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: _tasks.length,
                      itemBuilder: (ctx, idx) {
                        return TaskItem(_tasks[idx]);
                      },
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
