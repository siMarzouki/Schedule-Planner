import 'package:flutter/material.dart';
import 'dart:ui';
import '../models/project.dart';

class ProjectManager with ChangeNotifier {
  final List<Project> _projects = [
    //seeds
    // Project("Html Learning", Colors.blue),
    // Project("Css Learning", Colors.green),
    // Project("javascript Learning", Colors.purpleAccent),
  ];

  List<Project> getProjects() {
    return _projects;
  }

  Project getProjectById(int id) {
    return _projects.firstWhere((element) => element.id == id);
  }

  void addProject(String title, Color bgColor) {
    Project newProejct = Project(title, bgColor);
    _projects.add(newProejct);
    notifyListeners();
  }
}
