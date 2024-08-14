import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/controller/course_controller/course_controller.dart';
import 'package:new_project_driving/view/widget/dropdown_widget/student_dropdown/all_students.dart';
import 'package:new_project_driving/view/widget/custom_showdialouge/custom_showdilog.dart';

addStudentToCourse(BuildContext context, String courseID) {
  Get.find<CourseController>().allstudentList.clear();
  customShowDilogBox2(
    context: context,
    title: 'All Student',
    children: [AllStudentDropDown()],
    doyouwantActionButton: true,
    actiononTapfuction: () async {
      await Get.find<CourseController>().addStudentToCourseController(courseID);
      Navigator.pop(context);
    },
  );
}
