import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/database/db_helper.dart';
import 'package:todo_app/modal/task.dart';

class DateAndTimePickerEx extends GetxController {
  RxString selectedDate = DateFormat('dd-MM-yyyy').format(DateTime.now()).obs;
  Rx<TimeOfDay> selectedTime = TimeOfDay.now().obs;
  RxBool isStartTime = true.obs;

  RxString startTime =
      DateFormat('hh:mm a').format(DateTime.now()).toString().obs;
  RxString endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 10)))
      .obs;

  RxString receiveStartTime =
      DateFormat('hh:mm a').format(DateTime.now()).toString().obs;
  RxString receiveendTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 10)))
      .obs;
  RxInt tickPosition = 0.obs;
  RxString remindHint = '15'.obs;
  RxString scheduleHint = 'None'.obs;
  //Rx<Color> selectedColor = Colors.blue.obs;
  //database part
  DBHelper dbHelper = DBHelper();
  //=====
  RxString setAndStoreSelectedDate =
      DateFormat('dd-MM-yyyy').format(DateTime.now()).obs;
  DateTime get initialDate {
    try {
      return DateFormat('dd-MM-yyyy').parse(selectedDate.value);
    } catch (e) {
      return DateTime.now();
    }
  }

  void setSelectedDate(String date) {
    selectedDate.value = date;
  }

  updateSelectedDate(String date) {
    selectedDate.value = date;
    //update();
  }

  getStartTimeFromUser({required String sTime}) {
    receiveStartTime.value = sTime;
    update();
  }

  getEndTimeFromUser({required String eTime}) {
    receiveendTime.value = eTime;
    update();
  }

  // for remind
  hintTextForRemind(int? item) {
    remindHint.value = item.toString();
    log('Controller = ${remindHint.value}');
  }

  // for schedule
  hintTextForSchedule(String? item) {
    scheduleHint.value = item.toString();
    log('Controller = ${scheduleHint.value}');
  }

  // for tick for color selection
  handleTickPositionForColor(int tickIndex, Color mySelectedColor) {
    tickPosition.value = tickIndex;
    //selectedColor.value = mySelectedColor;
    //log(selectedColor.value.toString());
    update();
  }

  addTaskToTable({required Task task}) async {
    await dbHelper.insert(task);
  }
}
