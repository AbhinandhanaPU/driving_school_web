import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/constant/const.dart';
import 'package:new_project_driving/model/course_model/course_model.dart';
import 'package:new_project_driving/model/student_model/student_model.dart';
import 'package:new_project_driving/utils/firebase/firebase.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:uuid/uuid.dart';

class CourseController extends GetxController {
  final formKey = GlobalKey<FormState>();
  Rx<ButtonState> buttonstate = ButtonState.idle.obs;

  RxBool ontapStudentDetail = false.obs;
  RxString studentDocID = ''.obs;
  RxString studentName = ''.obs;
  RxString courseName = ''.obs;
  RxString courseId = ''.obs;
  RxString courseDocID = 'dd'.obs;
    RxString ontapCourseName= 'dd'.obs;
  RxString ontapCourseDocID = 'dd'.obs;
  
  RxString level = 'Select Level'.obs;
  List<StudentModel> allstudentList = [];
  List<CourseModel> allcourseList = [];
  Rxn<CourseModel> courseModelData = Rxn<CourseModel>();

  void setCourseData(CourseModel course) {
    courseModelData.value = course;
  }

  TextEditingController courseNameController = TextEditingController();
  TextEditingController courseDesController = TextEditingController();
  TextEditingController courseDurationController = TextEditingController();
  TextEditingController courseRateController = TextEditingController();

  TextEditingController editcourseNameController = TextEditingController();
  TextEditingController editcourseDesController = TextEditingController();
  TextEditingController editcourseDurationController = TextEditingController();
  TextEditingController editcourseRateController = TextEditingController();
  clearFields() {
    courseNameController.clear();
    courseDurationController.clear();
    courseRateController.clear();
    courseDesController.clear();

    editcourseNameController.clear();
    editcourseDesController.clear();
    editcourseDurationController.clear();
    editcourseRateController.clear();
  }

  Future<List<CourseModel>> fetchCourse() async {
    final firebase = await server
        .collection('SchoolListCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('Courses')
        .get();

    for (var i = 0; i < firebase.docs.length; i++) {
      final list =
          firebase.docs.map((e) => CourseModel.fromMap(e.data())).toList();
      allcourseList.add(list[i]);
      allcourseList.sort((a, b) => a.courseName.compareTo(b.courseName));
    }
    return allcourseList;
  }

  Future<void> createCourses() async {
    log("Creating Course .....");
    final uuid = const Uuid().v1();
    final courseDetails = CourseModel(
        courseName: courseNameController.text,
        courseDes: courseDesController.text,
        duration: courseDurationController.text,
        rate: courseRateController.text,
        courseId: uuid);

    try {
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Courses')
          .doc(courseDetails.courseId)
          .set(courseDetails.toMap())
          .then((value) async {
        clearFields();
        buttonstate.value = ButtonState.success;
        showToast(msg: "Courses Created Successfully");
        await Future.delayed(const Duration(seconds: 2)).then((vazlue) {
          buttonstate.value = ButtonState.idle;
        });
      });
    } catch (e) {
      buttonstate.value = ButtonState.fail;
      await Future.delayed(const Duration(seconds: 2)).then((value) {
        buttonstate.value = ButtonState.idle;
      });
      log("Courses Creation Error .... $e");
    }
  }

  Future<void> deleteCourse(String courseId) async {
    log("courseId -----------$courseId");
    try {
      server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Courses')
          .doc(courseId)
          .delete()
          .then((value) {
        showToast(msg: "Courses deleted Successfully");
      });
    } catch (e) {
      log("Courses delete$e");
    }
  }

  Future<void> updateCourse(String courseId, BuildContext context) async {
    try {
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Courses')
          .doc(courseId)
          .update({
        'courseName': editcourseNameController.text,
        'courseDes': editcourseDesController.text,
        'duration': editcourseDurationController.text,
        'rate': editcourseRateController.text,
      }).then((value) {
        clearFields();
        Navigator.pop(context);
      }).then((value) => showToast(msg: 'Course Updated!'));
    } catch (e) {
      log("Course Updation failed");
    }
  }

  Future<List<StudentModel>> fetchAllStudents() async {
    final firebase = await server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('Students')
        .get();

    for (var i = 0; i < firebase.docs.length; i++) {
      final list =
          firebase.docs.map((e) => StudentModel.fromMap(e.data())).toList();
      allstudentList.add(list[i]);
    }
    return allstudentList;
  }

  Future<void> addStudentToCourseController(String courseID) async {
    try {
      log("studentDocID.value ${studentDocID.value}");
      log("scourseID $courseID");
      final studentResult = await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Students')
          .doc(studentDocID.value)
          .get();
      if (studentDocID.value != '') {
        final data = StudentModel.fromMap(studentResult.data()!);

              final studentData = data.toMap();
      studentData['level'] = level.value;

        await server
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection('Courses')
            .doc(courseID)
            .collection('Students')
            .doc(studentDocID.value)
            .set(studentData)
            .then((value) async {
          showToast(msg: 'Added');
          allstudentList.clear();
        });
      }
    } catch (e) {
      log(e.toString());
      showToast(msg: 'Somthing went wrong please try again');
      allstudentList.clear();
    }
  }

  Future<void> deleteStudentsFromCourse(StudentModel studentModel) async {
    try {
      final data = courseModelData.value;
      if (data!.courseId != '') {
        // Delete the student from each course
        await server
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection("Courses")
            .doc(data.courseId)
            .collection('Students')
            .doc(studentModel.docid)
            .delete()
            .then((value) {
          log("Student deleted from course: ${data.courseId}");
          Get.back();
        });
      } else {
        log("No courses found");
      }
    } catch (e) {
      log("Student deletion error:$e");
    }
  }
}
