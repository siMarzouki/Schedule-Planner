class Note {
  static int notesCount = 1;
  int id = notesCount;
  String title;
  String description;
  String priority;
  int projectId;
  bool isExpanded = false;

  Note(this.title, this.description, this.priority, this.projectId) {
    notesCount++;
  }
}
