import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/controller/admin_section/student_controller/student_controller.dart';
import 'package:new_project_driving/model/student_model/student_model.dart';

class StudentLevelDropDown extends StatefulWidget {
  final StudentModel data;
  final String courseID;

  const StudentLevelDropDown({super.key, required this.data, required this.courseID});

  @override
  State<StudentLevelDropDown> createState() => _StudentLevelDropDownState();
}

class _StudentLevelDropDownState extends State<StudentLevelDropDown> {
  StudentController studentController = Get.put(StudentController());
  var selectStdLevel;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectStdLevel,
      hint: Text(widget.data.level),
      decoration: const InputDecoration(
        border: InputBorder.none,
        filled: false,
      ),
      items: const [
        DropdownMenuItem(
          value: 'beginner',
          child: Text('Beginner'),
        ),
        DropdownMenuItem(
          value: 'intermediate',
          child: Text('Intermediate'),
        ),
        DropdownMenuItem(
          value: 'advanced',
          child: Text('Advanced'),
        ),
      ],
      onChanged: (val) {
        if (val != null) {
          log('Selected user type: $val');
          setState(() {
            widget.data.level = val;
          });
          studentController.updateStudentLevel(
            widget.data,
            val,
            widget.courseID,
          );
        }
      },
    );
  }
}
