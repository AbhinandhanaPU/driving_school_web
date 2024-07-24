// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:new_project_driving/controller/course_controller/course_controller.dart';
// import 'package:new_project_driving/model/course_model/course_model.dart';

// class SelectClassWiseSubjectDropDown extends StatelessWidget {
//   SelectClassWiseSubjectDropDown({super.key});

//   final CourseController subjectCtrl = Get.put(CourseController());

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: DropdownSearch<CourseModel>(
//         validator: (item) {
//           if (item == null) {
//             return "Required field";
//           }
//           return null;
//         },
//         asyncItems: (value) => subjectCtrl.updateStudentCourse(),
//         itemAsString: (value) => value.courseName, // Ensure this property matches your model
//         onChanged: (value) {
//           if (value != null) {
//             subjectCtrl.courseName.value = value.courseName;
//             subjectCtrl.courseId.value = value.courseId;
//           }
//         },
//         popupProps: const PopupProps.menu(
//           searchFieldProps: TextFieldProps(
//             decoration: InputDecoration(
//               hintText: "Search Subject",
//               border: OutlineInputBorder(),
//             ),
//           ),
//           showSearchBox: true,
//           searchDelay: Duration(milliseconds: 300), // Adjust delay as needed
//         ),
//         dropdownDecoratorProps: DropDownDecoratorProps(
//           baseStyle: GoogleFonts.poppins(fontSize: 13, color: Colors.black.withOpacity(0.7)),
//         ),
//       ),
//     );
//   }
// }
