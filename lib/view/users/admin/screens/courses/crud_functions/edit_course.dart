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
                  controller: courseController.editcourseNameController,
                  hintText: data.courseName,
                  title: 'Course Name'),
              TextFormFiledHeightnoColor(
                  controller: courseController.editcourseDesController,
                  hintText: data.courseDes,
                  validator: checkFieldEmpty,
                  title: 'Description'),
              TextFormFiledHeightnoColor(
                  controller: courseController.editcourseDurationController,
                  hintText: data.duration,
                  keyboardType: TextInputType.number,
                  validator: checkFieldEmpty,
                  title: 'Duration'),
              TextFormFiledHeightnoColor(
                  controller: courseController.editcourseRateController,
                  hintText: data.rate.toString(),
                  keyboardType: TextInputType.number,
                  validator: checkFieldEmpty,
                  title: 'Course Fee')
            ],
          ),
        ),
      ],
      doyouwantActionButton: true,
      actiononTapfuction: () {
        if (courseController.formKey.currentState!.validate()) {
          courseController.updateCourse(data.courseId, context);
        }
      },
      actiontext: 'Update');
}
