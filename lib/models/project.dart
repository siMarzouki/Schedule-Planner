import 'dart:ui';

class Project {
  static int projectsCount = 1;
  int id = projectsCount;
  String title;
  Color bgColor;

  Project(this.title, this.bgColor) {
    projectsCount++;
  }

  void editProject(String title, Color bgColor) {
    this.title = title;
    this.bgColor = bgColor;
  }
}
