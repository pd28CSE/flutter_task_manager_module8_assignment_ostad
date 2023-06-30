import 'package:flutter/material.dart';

import '../models/task.dart';
import '../models/task_list.dart';
import '../widgets/task_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TaskList myTaskList = TaskList();
  final GlobalKey<FormState> formInput = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffolState = GlobalKey<ScaffoldState>();
  final Task myTask = Task(title: '', description: '', days: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffolState,
      appBar: AppBar(
        title: const Text('Task Management'),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey.shade300,
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 10.0),
        itemCount: myTaskList.getTotalTasks(),
        itemBuilder: (cntxt, index) {
          return TaskItem(
            taskIndex: index,
            task: myTaskList.getTask(index),
            onDetailAndDelete: _showButtonSheet,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _takeUserInputFromDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _takeUserInputFromDialog() {
    showDialog<bool?>(
      context: context,
      builder: (cntxt) {
        return AlertDialog(
          title: const Text('Add Task'),
          content: Form(
            key: formInput,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Title'),
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter a Title';
                        } else if (value!.trim().length < 7) {
                          return 'at least 7 characters long.';
                        }
                        return null;
                      },
                      onSaved: (String? value) {
                        myTask.setTitle(value!.trim());
                      },
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Description'),
                      ),
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter the Task Description.';
                        } else if (value!.trim().length < 10) {
                          return 'at least 10 characters long.';
                        }
                        return null;
                      },
                      onSaved: (String? value) {
                        myTask.setDescription(value!.trim());
                      },
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Days Required'),
                        hintText: '05',
                      ),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter Remaining Days.';
                        }
                        return null;
                      },
                      onSaved: (String? value) {
                        myTask.setDays(int.parse(value!.trim()));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            buildTaskSaveButton(),
          ],
        );
      },
    );
  }

  void updateUI() {
    if (mounted == true) {
      setState(() {});
    }
  }

  TextButton buildTaskSaveButton() {
    return TextButton(
      onPressed: () {
        if (formInput.currentState!.validate() == false) {
          return;
        } else {
          formInput.currentState!.save();
          Task tempTask = Task(
            title: myTask.getTitle(),
            description: myTask.getDescription(),
            days: myTask.getDays(),
          );
          myTaskList.addNewTask(tempTask);
          formInput.currentState!.reset();
          Navigator.of(context).pop();
          updateUI();
        }
      },
      child: const Text('Save'),
    );
  }

  void _showButtonSheet(int index, String title, String description, int days) {
    scaffolState.currentState!.showBottomSheet(
      (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Task Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              Text('Title: $title'),
              Text('Description: $description', softWrap: true),
              Text('Days Required: $days'),
              const SizedBox(height: 10.0),
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: 80,
                  height: 50,
                  child: FittedBox(
                    child: ElevatedButton(
                      onPressed: () {
                        myTaskList.removeTask(index);
                        Navigator.of(context).pop();
                        updateUI();
                      },
                      child: const Text('Delete'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
