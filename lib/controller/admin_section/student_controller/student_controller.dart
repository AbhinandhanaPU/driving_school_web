import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/constant/const.dart';
import 'package:new_project_driving/model/student_model/student_model.dart';
import 'package:new_project_driving/utils/firebase/firebase.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';

class StudentController extends GetxController {
  List<StudentModel> studentProfileList = [];
  Rxn<StudentModel> studentModelData = Rxn<StudentModel>();
  RxBool ontapStudent = false.obs;
  final formKey = GlobalKey<FormState>();
  TextEditingController amountController = TextEditingController();

  final _fbServer = server
      .collection('DrivingSchoolCollection')
      .doc(UserCredentialsController.schoolId);

  Future<void> fetchAllStudents() async {
    try {
      log("fetchAllStudents......................");
      studentProfileList = [];
      final data = await _fbServer.collection('Students').get();
      studentProfileList =
          data.docs.map((e) => StudentModel.fromMap(e.data())).toList();
      log(studentProfileList[0].toString());
    } catch (e) {
      showToast(msg: "User Data Error");
    }
  }

  Future<void> fetchAllArchivesStudents() async {
    try {
      log("fetchAllArchivesStudents......................");
      studentProfileList = [];
      final data = await _fbServer.collection('Archives').get();
      studentProfileList =
          data.docs.map((e) => StudentModel.fromMap(e.data())).toList();
      log(studentProfileList[0].toString());
    } catch (e) {
      showToast(msg: "User Data Error");
    }
  }

  Future<void> deleteStudents(StudentModel studentModel) async {
    try {
      await _fbServer
          .collection('Students')
          .doc(studentModel.docid)
          .delete()
          .then((value) => log("Student deleted"));
    } catch (e) {
      log("Student deletion error:$e");
    }
  }

  Future<void> updateStudentStatus(
      StudentModel studentModel, String newStatus) async {
    try {
      await _fbServer
          .collection('Students')
          .doc(studentModel.docid)
          .update({'status': newStatus}).then((value) {
        studentModel.status = newStatus;
        update();
        log("Student status updated to $newStatus");
      });
    } catch (e) {
      log("Student status update error: $e");
    }
  }

  //   Future<void> updateStudentCourse(StudentModel student, String newCourseId) async {
  //   try {
  //     await _fbServer
  //         .collection('Students')
  //         .doc(student.docid)
  //         .update({'courseId': newCourseId});
  //     showToast(msg: 'Course Updated Successfully');
  //   } catch (e) {
  //     log("Error updating course: $e");
  //     showToast(msg: 'Failed to update course');
  //   }
  // }

  Stream<List<String>> fetchStudentsCourse(StudentModel studentModel) async* {
    List<String> courseNames = [];

    try {
      final docidofcourse = await _fbServer.collection("Courses").get();

      if (docidofcourse.docs.isNotEmpty) {
        for (var courseDoc in docidofcourse.docs) {
          final courseDocid = courseDoc.id;

          // fetch the student from each course
          final std = await _fbServer
              .collection("Courses")
              .doc(courseDocid)
              .collection('Students')
              .doc(studentModel.docid)
              .get();

          if (std.exists) {
            // fetch the course document to get the course name
            final courseDocument =
                await _fbServer.collection("Courses").doc(courseDocid).get();

            if (courseDocument.exists) {
              final courseName = courseDocument.data()?['courseName'];
              if (courseName != null) {
                courseNames.add(courseName);
                log("courseNames : $courseNames");
                yield courseNames;
              }
            }
          }
        }
      }
    } catch (e) {
      log("Student course fetching error: $e");
    }
  }

  Future<void> updateStudentLevel(
      StudentModel studentModel, String newLevel, String courseID) async {
    try {
      await _fbServer
          .collection('Courses')
          .doc(courseID)
          .collection('Students')
          .doc(studentModel.docid)
          .update({'level': newLevel}).then((value) {
        studentModel.level = newLevel;
        update();
        log("Student level updated to $newLevel");
      });
    } catch (e) {
      log("Student level update error: $e");
    }
  }

  Future<void> addStudentFeeColl(
    StudentModel studentModel,
    String status,
    String courseID,
  ) async {
    try {
      await _fbServer
          .collection('FeeCollection')
          .doc(courseID)
          .set({'docId': courseID}).then((value) async {
        await _fbServer
            .collection('FeeCollection')
            .doc(courseID)
            .collection('Students')
            .doc(studentModel.docid)
            .set({
          'studentName': studentModel.studentName,
          'studentID': studentModel.docid,
          'feeStatus': status,
          'pendingAmount':
              amountController.text == "" ? 0 : amountController.text,
          'courseID': courseID
        }).then((value) async {
          await acceptStudentToCourse(studentModel, status, courseID);
          amountController.clear();
          update();
          showToast(msg: 'student fees updated');
          log("Fees Status Updated");
        });
      });
    } catch (e) {
      log(" FeeCollection error: $e");
    }
  }

  Future<void> acceptStudentToCourse(
    StudentModel studentModel,
    String status,
    String courseID,
  ) async {
    try {
      final reqStudentDoc = await _fbServer
          .collection('Courses')
          .doc(courseID)
          .collection("RequestedStudents")
          .doc(studentModel.docid)
          .get();

      if (reqStudentDoc.exists) {
        await reqStudentDoc.reference.delete();
        await _fbServer
            .collection('Courses')
            .doc(courseID)
            .collection("Students")
            .doc(studentModel.docid)
            .set(studentModel.toMap());
        showToast(msg: 'Student Added to Course');
        log("Student accepted and Added to the course.");
      } else {
        log("Student not found in RequestedStudents collection.");
      }
    } catch (e) {
      log("Students approval error: $e");
    }
  }

  addStudentsToArchive(StudentModel studentModel) async {
    try {
      await _fbServer
          .collection('Archives')
          .doc(studentModel.docid)
          .set(studentModel.toMap())
          .then((value) async {
        log('Student Archieved');
        await deleteStudentFromAllStudents(studentModel);
        await deleteStudentFromCourse(studentModel);
        await deleteStudentFromBatch(studentModel);
        await deleteStudentFromDrivingTest(studentModel);
        await deleteStudentFromPracticeSchedule(studentModel);
        await deleteStudentFromFee(studentModel);
        showToast(msg: 'Student Archieved');
        Get.back();
      });
    } catch (e) {
      log('Students archieve error $e', name: 'StudentController');
    }
  }

  Future<void> deleteStudentFromAllStudents(StudentModel studentModel) async {
    try {
      final documents = await _fbServer
          .collection('Students')
          .doc(studentModel.docid)
          .collection('Documents')
          .get();

      for (var doc in documents.docs) {
        await _fbServer
            .collection('Archives')
            .doc(studentModel.docid)
            .collection('Documents')
            .doc(doc.id)
            .set(doc.data());
      }
      for (var doc in documents.docs) {
        await _fbServer
            .collection('Students')
            .doc(studentModel.docid)
            .collection('Documents')
            .doc(doc.id)
            .delete();
      }
      await _fbServer.collection('Students').doc(studentModel.docid).delete();

      log('Student and related documents removed');
    } catch (e) {
      log('deleteStudentFromAllStudents error: $e');
    }
  }

  Future<void> deleteStudentFromCourse(StudentModel studentModel) async {
    try {
      final coursesSnapshot = await _fbServer.collection("Courses").get();

      if (coursesSnapshot.docs.isNotEmpty) {
        for (var courseDoc in coursesSnapshot.docs) {
          final courseDocid = courseDoc.id;

          final studentDoc = await _fbServer
              .collection("Courses")
              .doc(courseDocid)
              .collection('Students')
              .doc(studentModel.docid)
              .get();

          if (studentDoc.exists) {
            final courseName = courseDoc.data()['courseName'];
            await _fbServer
                .collection('Archives')
                .doc(studentModel.docid)
                .collection('CoursesDetails')
                .doc(studentModel.docid)
                .set({
              'courseName': courseName,
              'courseId': courseDocid,
            });
            await _fbServer
                .collection("Courses")
                .doc(courseDocid)
                .collection('Students')
                .doc(studentModel.docid)
                .delete()
                .then((value) {
              log('Student deleted from course: $courseName');
            });
          }
        }
      }
    } catch (e) {
      log('deleteStudentFromCourse error: $e');
    }
  }

  Future<void> deleteStudentFromBatch(StudentModel studentModel) async {
    try {
      final batchesSnapshot = await _fbServer.collection("Batch").get();

      if (batchesSnapshot.docs.isNotEmpty) {
        for (var batchDoc in batchesSnapshot.docs) {
          final batchDocid = batchDoc.id;

          final studentDoc = await _fbServer
              .collection("Batch")
              .doc(batchDocid)
              .collection('Students')
              .doc(studentModel.docid)
              .get();

          if (studentDoc.exists) {
            final batchName = batchDoc.data()['batchName'];

            await _fbServer
                .collection('Archives')
                .doc(studentModel.docid)
                .collection('CoursesDetails')
                .doc(studentModel.docid)
                .set({
              'batchName': batchName,
              'batchId': batchDocid,
            });

            await _fbServer
                .collection("Batch")
                .doc(batchDocid)
                .collection('Students')
                .doc(studentModel.docid)
                .delete()
                .then((value) {
              log('Student deleted from batch: $batchName');
            });
          }
        }
      }
    } catch (e) {
      log('deleteStudentFromBatch error: $e');
    }
  }

  Future<void> deleteStudentFromDrivingTest(StudentModel studentModel) async {
    try {
      final drivingTestsSnapshot =
          await _fbServer.collection("DrivingTest").get();

      if (drivingTestsSnapshot.docs.isNotEmpty) {
        for (var drivingTestDoc in drivingTestsSnapshot.docs) {
          final drivingTestDocid = drivingTestDoc.id;

          final studentDoc = await _fbServer
              .collection("DrivingTest")
              .doc(drivingTestDocid)
              .collection('Students')
              .doc(studentModel.docid)
              .get();

          if (studentDoc.exists) {
            await _fbServer
                .collection('Archives')
                .doc(studentModel.docid)
                .collection('CoursesDetails')
                .doc(studentModel.docid)
                .set({
              'testId': drivingTestDocid,
            });

            await _fbServer
                .collection("DrivingTest")
                .doc(drivingTestDocid)
                .collection('Students')
                .doc(studentModel.docid)
                .delete()
                .then((value) {
              log('Student deleted from driving test ');
            });
          }
        }
      }
    } catch (e) {
      log('deleteStudentFromDrivingTest error: $e');
    }
  }

  Future<void> deleteStudentFromFee(StudentModel studentModel) async {
    try {
      final feeCollectionSnapshot =
          await _fbServer.collection("FeeCollection").get();

      if (feeCollectionSnapshot.docs.isNotEmpty) {
        for (var feeDoc in feeCollectionSnapshot.docs) {
          final feeDocid = feeDoc.id;

          final studentDoc = await _fbServer
              .collection("FeeCollection")
              .doc(feeDocid)
              .collection('Students')
              .doc(studentModel.docid)
              .get();

          if (studentDoc.exists) {
            final feeStatus = studentDoc.data()!['feeStatus'];
            final pendingAmount = studentDoc.data()!['pendingAmount'];

            await _fbServer
                .collection('Archives')
                .doc(studentModel.docid)
                .collection('CoursesDetails')
                .doc(studentModel.docid)
                .set({
              'feeStatus': feeStatus,
              'pendingAmount': pendingAmount,
            });

            await _fbServer
                .collection("FeeCollection")
                .doc(feeDocid)
                .collection('Students')
                .doc(studentModel.docid)
                .delete()
                .then((value) {
              log('Student deleted from fee collection');
            });
          }
        }
      }
    } catch (e) {
      log('deleteStudentFromFee error: $e');
    }
  }

  Future<void> deleteStudentFromPracticeSchedule(
      StudentModel studentModel) async {
    try {
      final practiceScheduleSnapshot =
          await _fbServer.collection("PracticeSchedule").get();

      if (practiceScheduleSnapshot.docs.isNotEmpty) {
        for (var practiceDoc in practiceScheduleSnapshot.docs) {
          final practiceDocid = practiceDoc.id;

          final studentDoc = await _fbServer
              .collection("PracticeSchedule")
              .doc(practiceDocid)
              .collection('Students')
              .doc(studentModel.docid)
              .get();

          if (studentDoc.exists) {
            final practiceName = practiceDoc.data()['practiceName'];
            await _fbServer
                .collection('Archives')
                .doc(studentModel.docid)
                .collection('CoursesDetails')
                .doc(studentModel.docid)
                .set({
              'practiceName': practiceName,
              'practiceId': practiceDocid,
            });

            await _fbServer
                .collection("PracticeSchedule")
                .doc(practiceDocid)
                .collection('Students')
                .doc(studentModel.docid)
                .delete()
                .then((value) {
              log('Student deleted from practice schedule: $practiceName');
            });
          }
        }
      }
    } catch (e) {
      log('deleteStudentFromPracticeSchedule error: $e');
    }
  }
}
