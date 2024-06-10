import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controller/task_controller.dart';
import 'package:todo_app/modal/task.dart';
import 'package:todo_app/ui/add_task.dart';
import 'package:todo_app/ui/widgets/task_tile.dart';
import 'package:todo_app/ui/widgets/timeline_widget.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      body: SafeArea(
        child: Column(
          children: [
            CurrentTimeBar(),
            const SizedBox(
              height: 35,
            ),
            TimeLineWidget(),
            ShowTaskList(),
          ],
        ),
      ),
    );
  }
}

class CurrentTimeBar extends StatelessWidget {
  CurrentTimeBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            StreamBuilder(
              stream: Stream.periodic(
                const Duration(seconds: 1),
                (computationCount) => DateTime.now(),
              ),
              builder: (context, snapshot) {
                final dateTime = snapshot.data;
                final formattedDate =
                    DateFormat('dd MMMM yyyy').format(DateTime.now());
                return Row(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Text(
                            //'Date = ${dateTime?.toLocal().toString().split(' ')[0]}',
                            'Date = $formattedDate',
                            style: dateTimeTextStyle,
                          ),
                        ),
                        Text(
                          'Time = ${dateTime?.toLocal().toString().split(' ')[1].split('.')[0]}',
                          style: dateTimeTextStyle,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const AddTask(),
                                ),
                              );
                            },
                            child: const Text('Add Task'))
                      ],
                    )
                  ],
                );
              },
            )
          ],
        )
      ],
    );
  }

  TextStyle dateTimeTextStyle = const TextStyle(
    color: Colors.blue,
    fontSize: 25,
  );
}

class ShowTaskList extends StatelessWidget {
  ShowTaskList({super.key});
  TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      width: double.maxFinite,
      child: Obx(
        () => RefreshIndicator(
          onRefresh: () => taskController.displayTask(),
          child: ListView.builder(
            itemCount: taskController.filteredTasks.length,
            itemBuilder: (context, index) {
              final task = taskController.filteredTasks;
              return TaskTile(task[index]);
            },
          ),
        ),
      ),
    );
  }
}
