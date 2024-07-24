import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_project_driving/controller/course_controller/course_controller.dart';
import 'package:new_project_driving/model/course_model/course_model.dart';

class SelectCourseDropDown extends StatelessWidget {
  SelectCourseDropDown({
    Key? key,
  }) : super(key: key);

  final courseCtrl = Get.put(CourseController());

  @override
  Widget build(BuildContext context) {
    return Center(
        child: DropdownSearch<CourseModel>(

        //  dropdownDecoratorProps: DropDownDecoratorProps(dropdownSearchDecoration: InputDecoration(labelText: 'Select Class')),
      validator: (item) {
        if (item == null) {
          return "Select Course";
        } else {
          return null;
        }
      },


      // autoValidateMode: AutovalidateMode.always,

      asyncItems: (value) {
        courseCtrl.allcourseList.clear();

        return courseCtrl.fetchCourse();
      },
      itemAsString: (value) => value.courseName,
      onChanged: (value) async {
        if (value != null) {
          courseCtrl.courseName.value = value.courseName;
          courseCtrl.courseId.value = value.courseId;
          courseCtrl.courseDocID.value = value.courseId;
          log("Selected course ID: ${courseCtrl.courseDocID.value}");
        }
      },
      popupProps: const PopupProps.menu(
          searchFieldProps: TextFieldProps(
              decoration: InputDecoration(
                  hintText: "Search Course", border: OutlineInputBorder())),
          showSearchBox: true,
          searchDelay: Duration(microseconds: 10)),
      dropdownDecoratorProps: DropDownDecoratorProps(
       // dropdownSearchDecoration: InputDecoration(labelText: 'Select Class',),
          baseStyle: GoogleFonts.poppins(
              fontSize: 13, color: Colors.black.withOpacity(0.7))),
    ));
  }
}
