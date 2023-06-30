import './task.dart';

class TaskList {
  final List<Task> _tasks = [];

  int getTotalTasks() {
    return _tasks.length;
  }

  void addNewTask(Task newTask) {
    _tasks.add(newTask);
  }

  void removeTask(int index) {
    _tasks.removeAt(index);
  }

  Task getTask(int index) {
    return _tasks[index];
  }

  // void updateTask(int index, String title, String description, int days) {
  //   _tasks[index].setTitle(title);
  //   _tasks[index].setDescription(description);
  //   _tasks[index].setDays(days);
  // }
}
