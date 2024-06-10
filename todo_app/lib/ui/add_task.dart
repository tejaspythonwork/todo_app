import 'dart:core';
import 'dart:developer';

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controller/date_picker_getx_controller.dart';
import 'package:todo_app/controller/task_controller.dart';
import 'package:todo_app/modal/task.dart';
import 'package:todo_app/notification/notification_services.dart';
import 'package:todo_app/ui/widgets/input_field.dart';
import 'package:todo_app/utils.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final titleController = TextEditingController();
  final noteController = TextEditingController();
  final dateController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();
  final remindDateController = TextEditingController();
  final repeatDateController = TextEditingController();
  final dGetxController = Get.put(DateAndTimePickerEx());
  final dTaskController = Get.put(TaskController());
  final globalKey = GlobalKey<FormState>();
  final notification_services = NotificationServices();
  List<Color> colorList = [
    bluishClr,
    orangeClr,
    pinkClr,
  ];
  List<int> remindList = [5, 10, 15, 20];
  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: globalKey,
          child: Column(
            children: [
              InputField(
                title: 'Title',
                hint: 'Enter Title Here',
                fieldController: titleController,
              ),
              InputField(
                title: 'Note',
                hint: 'Enter Note Here',
                fieldController: noteController,
              ),
              Obx(
                () => InputField(
                  title: 'Date',
                  hint: DateFormat('dd-MM-yyyy')
                      .format(dGetxController.initialDate),
                  fieldController: dateController,
                  child: IconButton(
                    onPressed: () {
                      openDatePickerAndSelectDate();
                    },
                    icon: const Icon(
                      Icons.calendar_month,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => InputField(
                        title: 'Start Time',
                        hint: dGetxController.receiveStartTime.value,
                        fieldController: startTimeController,
                        child: IconButton(
                            onPressed: () {
                              selectTime(isStartTime: true);
                              startTimeController.text =
                                  dGetxController.receiveStartTime.value;
                            },
                            icon: const Icon(
                              Icons.access_time_rounded,
                            )),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Obx(
                      () => InputField(
                        title: 'End Time',
                        hint: dGetxController.receiveendTime.value,
                        fieldController: endTimeController,
                        child: IconButton(
                          onPressed: () {
                            selectTime(isStartTime: false);
                            endTimeController.text =
                                dGetxController.receiveendTime.value;
                          },
                          icon: const Icon(
                            Icons.access_time_rounded,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Obx(
                () => InputField(
                  title: 'Remind',
                  hint: '${dGetxController.remindHint} minutes early',
                  child: DropdownButton(
                    items: remindList
                        .map(
                          (e) => DropdownMenuItem<int>(
                            value: e,
                            child: Text('$e minutes'),
                          ),
                        )
                        .toList(),
                    onChanged: (int? item) {
                      remindDateController.text = item.toString();
                      log(item.toString());
                      log(remindDateController.text);
                      dGetxController.hintTextForRemind(item);
                    },
                    icon: const Icon(Icons.arrow_downward_rounded),
                  ),
                ),
              ),
              Obx(
                () => InputField(
                  title: 'Schedule Task',
                  hint: '${dGetxController.scheduleHint} Schedule Task',
                  child: DropdownButton(
                    items: repeatList.map(
                      (e) {
                        return DropdownMenuItem<String>(
                          value: e.toString(),
                          child: Text(e),
                        );
                      },
                    ).toList(),
                    onChanged: (String? value) {
                      dGetxController.hintTextForSchedule(value);
                    },
                    icon: const Icon(Icons.arrow_downward_rounded),
                  ),
                ),
              ),
              Container(
                width: double.maxFinite,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    //mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Select Tile Colors',
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 17,
                      ),
                      Row(
                        children: List.generate(
                          colorList.length,
                          (index) => Obx(
                            () => GestureDetector(
                              onTap: () {
                                dGetxController.handleTickPositionForColor(
                                    index, colorList[index]);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(1),
                                child: CircleAvatar(
                                  backgroundColor: colorList[index],
                                  child: dGetxController.tickPosition.value ==
                                          index
                                      ? const Center(
                                          child: Icon(
                                            Icons.trending_neutral,
                                            color: Colors.white,
                                            weight: 20,
                                          ),
                                        )
                                      : null,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: 125,
        child: FloatingActionButton(
          onPressed: () {
            if (globalKey.currentState!.validate()) {
              createTask();
              dTaskController.displayTask();
            }
          },
          child: const Text('Create Task'),
        ),
      ),
    );
  }

  void openDatePickerAndSelectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
      initialDate: dGetxController.initialDate,
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      dGetxController.setSelectedDate(formattedDate);
      dateController.text = formattedDate;
      log(dGetxController.selectedDate.value);
    }
  }

  selectTime({required bool isStartTime}) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      DateTime now = DateTime.now();
      DateTime pickedDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        pickedTime.hour,
        pickedTime.minute,
      );
      String formattedTime =
          DateFormat('hh:mm a').format(pickedDateTime); // Format in AM/PM
      // Use WidgetsBinding to defer state update until after the current frame

      if (isStartTime) {
        dGetxController.getStartTimeFromUser(sTime: formattedTime);
        startTimeController.text = formattedTime;
        log(startTimeController.text);
      } else {
        dGetxController.getEndTimeFromUser(eTime: formattedTime);
        endTimeController.text = formattedTime;
        log(endTimeController.text);
      }
    }
  }

  createTask() async {
    await dGetxController.addTaskToTable(
        task: Task(
      id: null,
      title: (titleController.text),
      note: noteController.text,
      isCompleted: 0,
      date: dateController.text,
      startTime: startTimeController.text,
      endTime: endTimeController.text,
      color: dGetxController.tickPosition.value,
      remind: 1,
      repeat: repeatDateController.text,
    ));
    await NotificationServices.showNotification();
    log('Task Has been Created');
  }
}
