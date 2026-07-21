import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../helper_function/convert.dart';

Future<String?> selectTime({String? time}) async {
  TimeOfDay selectedTime;
  if (time != null) {
    selectedTime = TimeOfDay(
      hour: convertStringToInt(time.split(':').first),
      minute: convertStringToInt(time.split(':').last),
    );
  } else {
    selectedTime = TimeOfDay.now();
  }

  TimeOfDay? pickedTime = await showTimePicker(
    context: Constants.globalContext(),
    initialTime: selectedTime,
  );

  if (pickedTime == null) {
    return null;
  }
  return convertTimeOfDayToString(pickedTime);
}
