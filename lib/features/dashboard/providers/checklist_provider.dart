import 'package:flutter/material.dart';
import '../models/checklist_task.dart';

class ChecklistProvider extends ChangeNotifier {
  final List<ChecklistTask> _tasks = [
    ChecklistTask(id: '1', title: 'Brush morning'),
    ChecklistTask(id: '2', title: 'Floss teeth'),
    ChecklistTask(id: '3', title: 'Mouthwash rinse'),
    ChecklistTask(id: '4', title: 'Brush before bed'),
    ChecklistTask(id: '5', title: 'Clean tongue'),
  ];

  List<ChecklistTask> get tasks => _tasks;

  double get completionPercentage {
    if (_tasks.isEmpty) return 0.0;
    final completedCount = _tasks.where((task) => task.isCompleted).length;
    return completedCount / _tasks.length;
  }

  void toggleTask(String id) {
    final index = _tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
      notifyListeners();
    }
  }

  void resetTasks() {
    for (var task in _tasks) {
      task.isCompleted = false;
    }
    notifyListeners();
  }
}
