import 'package:flutter/material.dart';

import '../models/task.dart';

class TaskItem extends StatelessWidget {
  final int taskIndex;
  final Task task;
  final void Function(int, String, String, int) onDetailAndDelete;
  const TaskItem({
    required this.taskIndex,
    required this.task,
    required this.onDetailAndDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.grey.shade200,
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10.0),
        title: Text(task.getTitle()),
        subtitle: Text(task.getShortDescription()),
        trailing: Text('${task.getDays()} days remaining'),
        onLongPress: () {
          onDetailAndDelete(
            taskIndex,
            task.getTitle(),
            task.getDescription(),
            task.getDays(),
          );
        },
      ),
    );
  }
}
