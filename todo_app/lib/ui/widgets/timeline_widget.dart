import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controller/date_picker_getx_controller.dart';
import 'package:todo_app/utils.dart';

class TimeLineWidget extends StatelessWidget {
  DateAndTimePickerEx controller = Get.put(DateAndTimePickerEx());
  TimeLineWidget({super.key});
  DateTime formattedDate = getCurrentFormattedDate();
  @override
  Widget build(BuildContext context) {
    return DatePicker(
      DateTime.now(),
      height: 100,
      selectionColor: Colors.blue,
      initialSelectedDate: getCurrentFormattedDate(),
      daysCount: 25,
      selectedTextColor: Colors.amber,
      onDateChange: (selectedDate) {
        controller.setAndStoreSelectedDate.value =
            selectedDate.toFormattedString();
      },
    );
  }
}

DateTime getCurrentFormattedDate() {
  DateTime now = DateTime.now();
  String formattedDateString = DateFormat('dd-MM-yyyy').format(now);

  return DateFormat('dd-MM-yyyy').parse(formattedDateString);
}
