import 'dart:developer';

import 'package:get/get.dart';
import 'package:new_project_driving/constant/const.dart';
import 'package:new_project_driving/model/student_model/student_model.dart';
import 'package:new_project_driving/utils/firebase/firebase.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';

class StudentController extends GetxController {
  List<StudentModel> studentProfileList = [];
  Rxn<StudentModel> studentModelData = Rxn<StudentModel>();
  RxBool ontapStudent = false.obs;

  final _fbServer = server
      .collection('DrivingSchoolCollection')
      .doc(UserCredentialsController.schoolId);

  Future<void> fetchAllStudents() async {
    try {
      log("fetchAllStudents......................");
      final data = await _fbServer.collection('Students').get();
      studentProfileList =
          data.docs.map((e) => StudentModel.fromMap(e.data())).toList();
      log(studentProfileList[0].toString());
    } catch (e) {
      showToast(msg: "User Data Error");
    }
  }

  Future<void> deleteStudents(StudentModel studentModel) async {
    try {
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Students')
          .doc(studentModel.docid)
          .delete()
          .then((value) => log("Student deleted"));
    } catch (e) {
      log("Student deletion error:$e");
    }
  }

   Future<void> deleteStudentsFromCourse(StudentModel studentModel) async {
    try {
     final docidofcourse= await server
           .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection("Courses")
          .get();

  if (docidofcourse.docs.isNotEmpty) {
      for (var courseDoc in docidofcourse.docs) {
        final courseDocid = courseDoc.id;

        // Delete the student from each course
        await server
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection("Courses")
            .doc(courseDocid)
            .collection('Students')
            .doc(studentModel.docid)
            .delete()
            .then((value) => log("Student deleted from course: $courseDocid"));
      }
    } else {
      log("No courses found");
    }
    } catch (e) {
      log("Student deletion error:$e");
    }
  }
}
