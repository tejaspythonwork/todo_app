import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const Color bluishClr = Color(0xFF4e5ae8);
const Color orangeClr = Color(0xCFFF8746);
const Color pinkClr = Color(0xFFff4667);

extension DateFormatting on DateTime {
  String toFormattedString() {
    return DateFormat('dd-MM-yyyy').format(this);
  }
}

extension StringDateFormatting on String {
  String toFormattedDate() {
    try {
      DateTime dateTime = DateFormat('yyyy-MM-dd').parse(this);
      return DateFormat('dd-MM-yyyy').format(dateTime);
    } catch (e) {
      // Handle the exception if the string is not a valid date
      return 'Invalid Date';
    }
  }
}
