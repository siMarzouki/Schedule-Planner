import 'package:flutter/foundation.dart';
import '../models/task.dart';

class TaskManager with ChangeNotifier {
  final List<Task> _tasks = [
    //seeds
    // Task(
    //     "HTML Tables",
    //     "HTML tables allow web developers to arrange data into rows and columns.",
    //     DateTime(2021, 10, 18),
    //     "Meduim",
    //     1),
    // Task(
    //     "HTML Layout Elements and Techniques",
    //     "Websites often display content in multiple columns (like a magazine or a newspaper).",
    //     DateTime(2021, 10, 19),
    //     "Meduim",
    //     1),
    // Task(
    //     "HTML Responsive Web Design",
    //     "Responsive web design is about creating web pages that look good on all devices! A responsive web design will automatically adjust for different screen sizes and viewports.",
    //     DateTime(2021, 10, 20),
    //     "Low",
    //     1),
    // Task(
    //     "CSS Selectors",
    //     "A CSS selector selects the HTML element(s) you want to style.",
    //     DateTime(2021, 10, 18),
    //     "Meduim",
    //     2),
    // Task(
    //     "CSS Colors",
    //     "Colors are specified using predefined color names, or RGB, HEX, HSL, RGBA, HSLA values.",
    //     DateTime(2021, 10, 19),
    //     "Urgent",
    //     2),
    // Task(
    //     "JS Syntax",
    //     "JavaScript syntax is the set of rules, how JavaScript programs are constructed:",
    //     null,
    //     "Urgent",
    //     3),
    // Task(
    //     "SQL Tutorial",
    //     "SQL is a standard language for storing, manipulating and retrieving data in databases.",
    //     null,
    //     "Low",
    //     0)
  ];

  List<Task> getTasks() {
    return _tasks;
  }

  void addTask(String title, String description, DateTime? date,
      String priority, int projectId) {
    Task newTask = Task(title, description, date, priority, projectId);
    _tasks.add(newTask);
    notifyListeners();
  }

  void editTask(Task task, String title, String description, DateTime? date,
      String priority, int projectId) {
    task.title = title;
    task.description = description;
    task.date = date;
    task.priority = priority;
    task.projectId = projectId;
    notifyListeners();
  }

  List<Task> getTasksByDate(DateTime date) {
    return _tasks.where((element) {
      if (element.date != null) {
        if (element.date!.year == date.year &&
            element.date!.month == date.month &&
            element.date!.day == date.day) {
          return true;
        }
      }
      return false;
    }).toList();
  }

  List<Task> getTasksByProject(int projectId) {
    return _tasks.where((element) => element.projectId == projectId).toList();
  }

  List<Task> getUnplannedTasks() {
    return _tasks.where((element) => element.date == null).toList();
  }

  int getDoneTasksNumber(List<Task> tasks) {
    int count = 0;
    for (Task t in tasks) {
      if (t.completed) count++;
    }
    return count;
  }

  void deleteTaskById(int taskId) {
    _tasks.removeWhere((element) => element.id == taskId);
    notifyListeners();
  }

  void toggleStatus(Task task) {
    task.completed = !task.completed;
    notifyListeners();
  }
}
