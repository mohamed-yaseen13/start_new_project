import 'package:flutter/material.dart';
import '../constants/constants.dart';

Future<DateTime?> selectDate({DateTime? initialDate,DateTime? firstDate,DateTime? lastDate}) async {
  DateTime initial = initialDate ?? DateTime.now();

  DateTime? pickedDate = await showDatePicker(
    context: Constants.globalContext(),
    initialDate: initial,
    firstDate: firstDate??DateTime(2000),
    lastDate: DateTime(2100),
  );

  if (pickedDate == null) {
    return null;
  }
  return pickedDate;
}


