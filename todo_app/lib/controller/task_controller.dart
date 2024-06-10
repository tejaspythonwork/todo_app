import 'dart:developer';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controller/date_picker_getx_controller.dart';
import 'package:todo_app/database/db_helper.dart';
import 'package:todo_app/modal/task.dart';
import 'package:todo_app/utils.dart';

class TaskController extends GetxController {
  DBHelper dbHelper = DBHelper();
  RxList<Task> taskList = <Task>[].obs;
  final dateAndTimeController = Get.find<DateAndTimePickerEx>();
  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];
  var selectedDate = DateTime.now().obs;

  displayTask() async {
    final myTaskList = await dbHelper.displayData();

    taskList.assignAll(myTaskList!.map((e) => Task.fromMap(e)).toList());
    update();
    for (int i = 0; i < taskList.length; i++) {
      log(taskList[i].id.toString());
      log(taskList[i].color.toString());
      log(taskList[i].startTime.toString());
      log(taskList[i].endTime.toString());
      log(taskList[i].title.toString());
      log(taskList[i].note.toString());
      log(taskList[i].date.toString());
      log('====================================');
    }
  }

  @override
  void onInit() {
    displayTask();
    super.onInit();
  }

  List<Task> get filteredTasks {
    return taskList.where((task) {
      // if (task.repeat == 'Daily') {
      //   return true;
      // } else
      final now = DateTime.now();
      final taskDate = DateFormat('dd-MM-yyyy').parse(task.date!);
      final selectedDate = DateFormat('dd-MM-yyyy')
          .parse(dateAndTimeController.setAndStoreSelectedDate.value);
      //===
      // if (task.date == '05-06-2024') {
      //   return true;
      // }

      if (taskDate.year == selectedDate.year &&
          taskDate.month == selectedDate.month &&
          taskDate.day == selectedDate.day) {
        return true;
      }
      //===
      // else if (task.repeat == 'Weekly' &&
      //     selectedDate.value.difference(DateFormat.yMd().parse(task.date)).inDays % 7 == 0) {
      //   return true;
      // } else if (task.repeat == 'Monthly' &&
      //     DateFormat.yMd().parse(task.date).day == selectedDate.value.day) {
      //   return true;
      // }

      return false;
    }).toList();
  }
}
