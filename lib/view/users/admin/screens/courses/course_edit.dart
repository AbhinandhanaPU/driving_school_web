import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/constant/constant.validate.dart';
import 'package:new_project_driving/controller/course_controller/course_controller.dart';
import 'package:new_project_driving/model/course_model/course_model.dart';
import 'package:new_project_driving/view/widget/custom_showdialouge/custom_showdialouge.dart';
import 'package:new_project_driving/view/widget/text_formfiled_container/textformfiled_blue_container.dart';

editFunctionOfCourse(BuildContext context, CourseModel data) {
  final CourseController courseController = Get.put(CourseController());
  customShowDilogBox(
      context: context,
      title: 'Edit',
      children: [
        Form(
          key: courseController.formKey,
          child: Column(
            children: [
              TextFormFiledHeightnoColor(
                  validator: checkFieldEmpty,
                  controller: courseController.courseEditNameController,
                  hintText: data.courseName,
                  title: 'Course Name'),
              TextFormFiledHeightnoColor(
                  validator: checkFieldEmpty,
                  controller: courseController.courseEditDesController,
                  hintText: data.courseDes,
                  title: 'Description'),
              TextFormFiledHeightnoColor(
                  validator: checkFieldEmpty,
                  controller: courseController.courseEditDurationController,
                  hintText: data.duration,
                  title: 'Duration'),
              TextFormFiledHeightnoColor(
                  validator: checkFieldEmpty,
                  controller: courseController.courseEditRateController,
                  hintText: data.duration,
                  title: 'Rate'),
            ],
          ),
        ),
      ],
      doyouwantActionButton: true,
      actiononTapfuction: () {
        if (courseController.formKey.currentState!.validate()) {
          courseController.updateCourse(
            data.courseId,
            context,
          );
        }
      },
      actiontext: 'Update');
}
