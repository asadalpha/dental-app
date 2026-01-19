class ChecklistTask {
  final String id;
  final String title;
  bool isCompleted;

  ChecklistTask({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });
}
