import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/controller/admin_section/student_controller/student_controller.dart';
import 'package:new_project_driving/model/student_model/student_model.dart';
import 'package:new_project_driving/view/widget/dropdown_widget/std_fees_level/fee_edit_popup.dart';

class StdFeesLevelDropDown extends StatefulWidget {
  final StudentModel data;
  final String courseID;

  const StdFeesLevelDropDown(
      {super.key, required this.data, required this.courseID});

  @override
  State<StdFeesLevelDropDown> createState() => _StdFeesLevelDropDownState();
}

class _StdFeesLevelDropDownState extends State<StdFeesLevelDropDown> {
  StudentController studentController = Get.put(StudentController());
  var selectStdLevel;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectStdLevel,
      hint: Text(widget.data.feesStatus),
      decoration: const InputDecoration(
        border: InputBorder.none,
        filled: false,
      ),
      items: const [
        DropdownMenuItem(
          value: 'partly paid',
          child: Text('Partly paid'),
        ),
        DropdownMenuItem(
          value: 'fully paid',
          child: Text('Fully paid'),
        ),
      ],
      onChanged: (val) {
        if (val != null) {
          log('Selected type: $val');
          setState(() {
            widget.data.feesStatus = val;
          });
          if (val == 'partly paid') {
            pendingAmountFunction(
              context,
              widget.data,
              val, 
              widget.courseID,
            );
          } 
        }
      },
    );
  }
}
