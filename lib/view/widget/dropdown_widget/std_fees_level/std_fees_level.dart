import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/controller/fee_controller/fee_controller.dart';
import 'package:new_project_driving/model/course_model/course_model.dart';
import 'package:new_project_driving/model/student_model/student_model.dart';
import 'package:new_project_driving/view/widget/dropdown_widget/std_fees_level/fee_edit_popup.dart';

class StdFeesLevelDropDown extends StatefulWidget {
  final StudentModel data;
  final CourseModel course;
  final String feeData;

  const StdFeesLevelDropDown({
    super.key,
    required this.data,
    required this.course,
    required this.feeData,
  });

  @override
  State<StdFeesLevelDropDown> createState() => _StdFeesLevelDropDownState();
}

class _StdFeesLevelDropDownState extends State<StdFeesLevelDropDown> {
  FeeController studentController = Get.put(FeeController());
  String? selectStdLevel;

  @override
  void initState() {
    super.initState();
    selectStdLevel = widget.feeData;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectStdLevel,
      hint: Text(widget.feeData),
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
        DropdownMenuItem(
          value: 'not paid',
          child: Text('Not paid'),
        ),
      ],
      onChanged: (val) {
        if (val != null) {
          setState(() {
            selectStdLevel = val;
          });
          if (val == 'partly paid') {
            pendingAmountFunction(
              context,
              widget.data,
              val,
              widget.course,
            );
          } else if (val == 'fully paid') {
            studentController.addStudentfeeFullyPaid(
              widget.data,
              val,
              widget.course,
            );
          } else {
            studentController.addStudentFeeColl(
              widget.data,
              val,
              widget.course,
            );
          }
        }
      },
    );
  }
}
