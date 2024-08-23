import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/controller/admin_section/student_controller/student_controller.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/model/student_model/student_model.dart';
import 'package:new_project_driving/view/widget/custom_showdialouge/custom_showdilog.dart';

archivesStudentsFunction(BuildContext context, StudentModel studentModel) {
  StudentController studentController = Get.put(StudentController());
  customShowDilogBox2(
    context: context,
    title: "Archives",
    children: [
      const TextFontWidget(
          text:
              "You are going to delete this profile.This Profile will archived for future reference.",
          fontsize: 13)
    ],
    doyouwantActionButton: true,
    actiononTapfuction: () {
      studentController.addStudentsToArchive(studentModel);
    },
  );
}
