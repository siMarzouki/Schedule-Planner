class Task {
  static int tasksCount = 1;
  int id = tasksCount;
  String title;
  String description;
  DateTime? date;
  String priority;
  int projectId;
  bool completed = false;

  Task(this.title, this.description, this.date, this.priority, this.projectId) {
    tasksCount++;
  }
}
