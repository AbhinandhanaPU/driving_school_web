import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:uuid/uuid.dart';

const sw50 = SizedBox(
  width: 50,
);
const sw10 = SizedBox(
  width: 10,
);
const sw20 = SizedBox(
  width: 20,
);
const sh50 = SizedBox(
  height: 50,
);
const sh10 = SizedBox(
  height: 10,
);
const sh20 = SizedBox(
  height: 20,
);
const sh30 = SizedBox(
  height: 30,
);

const uuid = Uuid();

const String netWorkImagePathPerson =
    "https://www.seekpng.com/png/full/202-2024994_profile-icon-profile-logo-no-background.png";

String stringTimeToDateConvert(String date) {
  //String dateandtime convert to "dd-mm-yyyy" this format
  try {
    final DateTime dateFormat = DateTime.parse(date);
    return "${dateFormat.day}-${dateFormat.month}-${dateFormat.year}";
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
  return '';
}

String stringTimeConvert(DateTime date) {
  //String dateandtime convert to "dd-mm-yyyy" this format
  try {
    String formattedTime = DateFormat('hh:mm:a').format(date);

    return formattedTime;
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
  return '';
}

String dateConvert(DateTime dateTime) {
  String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
  return formattedDate;
}

String? checkFieldEmpty(String? fieldContent) {
  //<-- add String? as a return type
  if (fieldContent == null || fieldContent.isEmpty) {
    return "Field is mandatory";
  }
  return null;
}

String? checkFieldEmailIsValid(String? fieldContent) {
  if (fieldContent == null) {
    return 'null';
  }
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  final result = (regex.hasMatch(fieldContent)) ? true : false;
  if (result) {
    return null;
  } else {
    return "Email is not valid";
  }
}

String? checkFieldPhoneNumberIsValid(String? fieldContent) {
  // Check if the input is null
  if (fieldContent == null) {
    return 'null';
  }

  // Check if the input contains only digits
  final validDigits = RegExp(r'^\d{10}$');
  if (validDigits.hasMatch(fieldContent)) {
    return null; // The input is valid
  } else {
    return 'Please enter a valid 10 digit number';
  }
}

String? checkFieldPasswordIsValid(String? fieldContent) {
  if (fieldContent == null) {
    return 'null';
  }
  if (fieldContent.length >= 6) {
    return null;
  } else {
    return 'Minimum 6 Charaters is required';
  }
}

String? checkFieldDateIsValid(String? fieldContent) {
  if (fieldContent == null) {
    return 'null';
  }
  // Define a regular expression pattern to match a date in the "dd-mm-yyyy" format
  String pattern = r'^\d{2}-\d{2}-\d{4}$';
  RegExp regex = RegExp(pattern);

  if (regex.hasMatch(fieldContent)) {
    // If the date matches the pattern, further validate it for valid date values.
    try {
      final parts = fieldContent.split('-');
      final day = int.tryParse(parts[0]);
      final month = int.tryParse(parts[1]);
      final year = int.tryParse(parts[2]);
      if (day != null && month != null && year != null) {
        final date = DateTime(year, month, day);
        if (date.year == year && date.month == month && date.day == day) {
          return null; // Valid date
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  return 'Date is not valid (dd-mm-yyyy)';
}

String? checkFieldTimeIsValid(String? fieldContent) {
  if (fieldContent == null) {
    return 'null';
  }
  // Define a regular expression pattern to match a time in the "h:mm am/pm" format
  String pattern = r'^(0?[1-9]|1[0-2]):[0-5][0-9] (am|pm)$';
  RegExp regex = RegExp(pattern, caseSensitive: false);

  if (regex.hasMatch(fieldContent)) {
    // If the time matches the pattern, further validate it for valid time values.
    try {
      final parts = fieldContent.split(' ');
      final timeParts = parts[0].split(':');
      final hour = int.tryParse(timeParts[0]);
      final minute = int.tryParse(timeParts[1]);
      final period = parts[1].toLowerCase();

      if (hour != null && minute != null) {
        if (hour >= 1 && hour <= 12 && minute >= 0 && minute <= 59) {
          if (period == 'am' || period == 'pm') {
            return null; // Valid time
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  return 'Time is not valid (h:mm am/pm)';
}

class TeacherLoginIDSaver {
  static String id = '';
  static String teacherID = '';
  static String findUser = '';
}

class TarifdetailSaver {
  static int index0 = 0;
  static int index1 = 0;
  static String gpsprice = '';
  static String bioprice = '';
}

Widget circularProgressIndicator = const Center(
  child: CircularProgressIndicator(),
);

showDialogWidget(
    {required BuildContext context,
    required String title,
    required Function function}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: LinearBorder.none,
        title: TextFontWidget(text: title, fontsize: 16),
        actions: [
          TextButton(
            child: const TextFontWidget(
              text: 'No',
              fontsize: 16,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const TextFontWidget(
              text: 'Yes',
              fontsize: 16,
            ),
            onPressed: () {
              function();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

String timeConvert(DateTime date) {
  try {
    String formattedTime = DateFormat('hh:mm:a').format(date);
    return formattedTime;
  } catch (e) {
    // Handle any potential errors
    if (kDebugMode) {
      print('Error converting time: $e');
    }
  }
  return '';
}

String timeToDateConvert(String date) {
  //String dateandtime convert to "dd-mm-yyyy hh:mm" this format
  try {
    final DateTime dateFormat = DateTime.parse(date);
    final DateFormat formatter = DateFormat('dd-MM-yyyy h:mm');
    return formatter.format(dateFormat);
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
  return '';
}

Future<String> dateTimePicker(BuildContext context) async {
  DateTime? dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2025));
  if (dateTime != null) {
    return DateFormat("dd-MM-yyyy").format(dateTime);
  } else {
    return '';
  }
}

// Future<String> setStartTime(BuildContext context) async {
//   TimeOfDay? timeData = await showTimePicker(
//     context: context,
//     initialTime: TimeOfDay.now(),
//   );

//   if (timeData != null) {
//     final now = DateTime.now();
//     final dateTime = DateTime(
//       now.year,
//       now.month,
//       now.day,
//       timeData.hour,
//       timeData.minute,
//     );
//     return DateFormat('hh:mm a').format(dateTime);
//   } else {
//     return '';
//   }
// }
// Future<String> setEndTime(BuildContext context) async {
//   TimeOfDay? timeData = await showTimePicker(
//     context: context,
//     initialTime: TimeOfDay.now(),
//   );

//   if (timeData != null) {
//     final now = DateTime.now();
//     final dateTime = DateTime(
//       now.year,
//       now.month,
//       now.day,
//       timeData.hour,
//       timeData.minute,
//     );
//     return DateFormat('hh:mm a').format(dateTime);
//   } else {
//     return '';
//   }
// }