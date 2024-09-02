import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/controller/admin_section/student_controller/student_controller.dart';
import 'package:new_project_driving/fonts/google_poppins_widget.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/model/student_model/student_model.dart';
import 'package:new_project_driving/view/users/admin/screens/batch/drop_down/batch_dp_dn.dart';

updateStudentBatch(
    {required BuildContext context, required StudentModel studentModel}) {
  final StudentController studentController = Get.put(StudentController());
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: cWhite,
        actionsAlignment: MainAxisAlignment.spaceAround,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back),
            ),
            const SizedBox(width: 10),
            const TextFontWidget(
              text: "Select batch",
              fontsize: 17,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
        content: SizedBox(
          height: 80,
          width: 150,
          child: BatchDropDown(
            onChanged: (batch) {
              studentController.batchId.value = batch!.batchId;
              log('New batch of ${studentModel.studentName}: ${batch.batchId} - ${batch.batchName}');
            },
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 30,
              width: 80,
              decoration: const BoxDecoration(
                color: themeColorBlue,
              ),
              child: Center(
                child: GooglePoppinsWidgets(
                  text: 'Cancel',
                  color: cWhite,
                  fontsize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              studentController.updateStudentBatch(studentModel);
              Navigator.pop(context);
            },
            child: Container(
              height: 30,
              width: 80,
              decoration: const BoxDecoration(
                color: themeColorBlue,
              ),
              child: Center(
                child: GooglePoppinsWidgets(
                  text: 'OK',
                  color: cWhite,
                  fontsize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
