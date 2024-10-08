import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/constant/const.dart';
import 'package:new_project_driving/model/course_model/course_model.dart';
import 'package:new_project_driving/model/student_model/student_model.dart';
import 'package:new_project_driving/utils/firebase/firebase.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';

class StudentController extends GetxController {
  List<StudentModel> studentProfileList = [];
  Rxn<StudentModel> studentModelData = Rxn<StudentModel>();
  RxBool ontapStudent = false.obs;
  RxString batchId = ''.obs;

  final _fbServer =
      server.collection('DrivingSchoolCollection').doc(UserCredentialsController.schoolId);

  Future<void> fetchAllStudents() async {
    try {
      log("fetchAllStudents......................");
      studentProfileList = [];
      final data = await _fbServer.collection('Students').get();
      studentProfileList = data.docs.map((e) => StudentModel.fromMap(e.data())).toList();
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
      studentProfileList = data.docs.map((e) => StudentModel.fromMap(e.data())).toList();
      log(studentProfileList[0].toString());
    } catch (e) {
      showToast(msg: "User Data Error");
    }
  }

  Future<void> deleteStudents(StudentModel studentModel) async {
    try {
      await _fbServer.collection('Students').doc(studentModel.docid).delete().then((value) async {
        await deleteStudentFromAllStudents(studentModel, isArchiving: false);
        await deleteStudentFromCourse(studentModel, isArchiving: false);
        await deleteStudentFromBatch(studentModel, isArchiving: false);
        await deleteStudentFromDrivingTest(studentModel, isArchiving: false);
        await deleteStudentFromPracticeSchedule(studentModel, isArchiving: false);
        // await deleteStudentFromFee(studentModel, isArchiving: false);
        log("Student deleted");
      });
    } catch (e) {
      log("Student deletion error:$e");
    }
  }

  Future<void> updateStudentStatus(StudentModel studentModel, bool newStatus) async {
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

  Future<void> updateStudentBatch(StudentModel studentModel) async {
    try {
      await _fbServer.collection('Students').doc(studentModel.docid).update({
        'batchId': batchId.value,
      }).then((value) {
        studentModel.batchId = batchId.value;
        update();
        log("Student batch updated to $batchId");
      });
      await addStudentToBatch(studentModel);
      await checkStudentInBatches(studentModel);
      final docidofcourse = await _fbServer.collection("Courses").get();
      if (docidofcourse.docs.isNotEmpty) {
        for (var courseDoc in docidofcourse.docs) {
          final courseDocid = courseDoc.id;

          final std = await _fbServer
              .collection("Courses")
              .doc(courseDocid)
              .collection('Students')
              .doc(studentModel.docid)
              .get();

          if (std.exists) {
            await _fbServer
                .collection("Courses")
                .doc(courseDocid)
                .collection('Students')
                .doc(studentModel.docid)
                .update({
              'batchId': batchId.value,
            });
          }
        }
      }
    } catch (e) {
      log('student batch update error $e');
    }
  }

  Future<void> addStudentToBatch(StudentModel studentModel) async {
    try {
      final batches = await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Batch')
          .get();

      for (var batchDoc in batches.docs) {
        final batchDocid = batchDoc.id;
        final studentsCollection = server
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection('Batch')
            .doc(batchDocid)
            .collection('Students');

        final studentDoc =
            await studentsCollection.doc(studentModel.docid).get();

        if (studentDoc.exists) {
          await studentsCollection.doc(studentModel.docid).delete();
          log('Student removed from batch $batchDocid');
          break;
        }
      }
      if (batchId.value.isNotEmpty) {
        await server
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection('Batch')
            .doc(batchId.value)
            .collection('Students')
            .doc(studentModel.docid)
            .set(studentModel.toMap());
        log('Student added to new batch $batchId');
      } else {
        log('No new batch ID provided.');
      }
    } catch (e) {
      log('Error adding student to batch: $e');
    }
  }

  Future<void> checkStudentInBatches(StudentModel studentModel) async {
    try {
      final batchDoc = await _fbServer.collection('FeesCollection').get();

      for (var batchDoc in batchDoc.docs) {
        final batch = batchDoc.id;
        final coursecol = await _fbServer
            .collection('FeesCollection')
            .doc(batch)
            .collection('Courses')
            .get();
        for (var courseDoc in coursecol.docs) {
          final courseId = courseDoc.id;
          final stdDoc = await _fbServer
              .collection('FeesCollection')
              .doc(batch)
              .collection('Courses')
              .doc(courseId)
              .collection('Students')
              .doc(studentModel.docid)
              .get();
          if (stdDoc.exists) {
            final studentData = stdDoc.data()!;
            DocumentSnapshot batchDoc = await _fbServer
                .collection('FeesCollection')
                .doc(batchId.value)
                .get();

            if (!batchDoc.exists) {
              await _fbServer
                  .collection('FeesCollection')
                  .doc(batchId.value)
                  .set({
                'batchId': batchId.value,
              });
            }
            DocumentSnapshot courseDoc = await _fbServer
                .collection('FeesCollection')
                .doc(studentModel.batchId)
                .collection('Courses')
                .doc(courseId)
                .get();

            if (!courseDoc.exists) {
              await _fbServer
                  .collection('FeesCollection')
                  .doc(studentModel.batchId)
                  .collection('Courses')
                  .doc(courseId)
                  .set({
                'courseId': courseId,
              });
            }
            await _fbServer
                .collection('FeesCollection')
                .doc(batchId.value)
                .collection('Courses')
                .doc(courseId)
                .collection('Students')
                .doc(studentModel.docid)
                .set(studentData);
            await _fbServer
                .collection('FeesCollection')
                .doc(batch)
                .collection('Courses')
                .doc(courseId)
                .collection('Students')
                .doc(studentModel.docid)
                .delete();
          }
        }
      }
    } catch (e) {
      log('checkStudentInBatches error $e ');
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
            final courseDocument = await _fbServer.collection("Courses").doc(courseDocid).get();

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
        showToast(msg: "Student level updated to $newLevel");
      });
    } catch (e) {
      log("Student level update error: $e");
    }
  }

  Stream<List<Map<String, dynamic>>> streamStudentsFromAllCourses() async* {
    try {
      final coursesStream = _fbServer.collection("Courses").snapshots();

      await for (var coursesSnapshot in coursesStream) {
        List<Map<String, dynamic>> results = [];

        for (var courseDoc in coursesSnapshot.docs) {
          CourseModel course = CourseModel.fromMap(courseDoc.data());
          String courseDocId = courseDoc.id;

          final requestedStudentsSnapshot = await _fbServer
              .collection("Courses")
              .doc(courseDocId)
              .collection('RequestedStudents')
              .get();

          for (var studentDoc in requestedStudentsSnapshot.docs) {
            StudentModel student = StudentModel.fromMap(studentDoc.data());
            results.add({
              "course": course,
              "student": student,
            });
          }
        }
        yield results;
      }
    } catch (e) {
      log("Error fetching students: $e");
      yield [];
    }
  }

  Future<void> addStudentsToArchive(StudentModel studentModel) async {
    try {
      await _fbServer
          .collection('Archives')
          .doc(studentModel.docid)
          .set(studentModel.toMap())
          .then((value) async {
        log('Student Archived');
        await deleteStudentFromAllStudents(studentModel, isArchiving: true);
        await deleteStudentFromCourse(studentModel, isArchiving: true);
        await deleteStudentFromBatch(studentModel, isArchiving: true);
        await deleteStudentFromDrivingTest(studentModel, isArchiving: true);
        await deleteStudentFromPracticeSchedule(studentModel, isArchiving: true);
        await deleteStudentFromFee(studentModel, isArchiving: true);
        showToast(msg: 'Student Archived');
        Get.back();
      });
    } catch (e) {
      log('Students archive error $e', name: 'StudentController');
    }
  }

  Future<void> deleteStudentFromAllStudents(StudentModel studentModel,
      {bool isArchiving = false}) async {
    try {
      final documents = await _fbServer
          .collection('Students')
          .doc(studentModel.docid)
          .collection('Documents')
          .get();
      if (isArchiving) {
        for (var doc in documents.docs) {
          await _fbServer
              .collection('Archives')
              .doc(studentModel.docid)
              .collection('Documents')
              .doc(doc.id)
              .set(doc.data());
        }
      }

      for (var doc in documents.docs) {
        await _fbServer
            .collection('Students')
            .doc(studentModel.docid)
            .collection('Documents')
            .doc(doc.id)
            .delete();
        log('documents removed');
      }
      await _deleteAllSubcollections(studentModel.docid, 'AdminChatCounter');
      await _deleteAllSubcollections(studentModel.docid, 'AdminChats');
      await _deleteAllSubcollections(studentModel.docid, 'TeacherChats');
      await _deleteAllSubcollections(studentModel.docid, 'TutorChatCounter');
      await _fbServer.collection('Students').doc(studentModel.docid).delete();
      log('Student removed');
    } catch (e) {
      log('deleteStudentFromAllStudents error: $e');
    }
  }

  Future<void> _deleteAllSubcollections(
    String parentId,
    String subcollection,
  ) async {
    final documents =
        await _fbServer.collection('Students').doc(parentId).collection('Documents').get();
    for (var doc in documents.docs) {
      await _fbServer
          .collection('Students')
          .doc(parentId)
          .collection(subcollection)
          .doc(doc.id)
          .delete();
      log('$subcollection removed');
    }
  }

  Future<void> deleteStudentFromCourse(StudentModel studentModel,
      {bool isArchiving = false}) async {
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
            if (isArchiving) {
              final courseName = courseDoc.data()['courseName'];
              await _fbServer
                  .collection('Archives')
                  .doc(studentModel.docid)
                  .collection('CoursesDetails')
                  .doc(studentModel.docid)
                  .set({
                'courseName': courseName,
                'courseId': courseDocid,
              }, SetOptions(merge: true));
            }

            await _fbServer
                .collection("Courses")
                .doc(courseDocid)
                .collection('Students')
                .doc(studentModel.docid)
                .delete()
                .then((value) {
              log('Student deleted from course');
            });
          }
          log('Student not added to any course to delete');
        }
      }
    } catch (e) {
      log('deleteStudentFromCourse error: $e');
    }
  }

  Future<void> deleteStudentFromBatch(StudentModel studentModel, {bool isArchiving = false}) async {
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
            if (isArchiving) {
              await _fbServer
                  .collection('Archives')
                  .doc(studentModel.docid)
                  .collection('CoursesDetails')
                  .doc(studentModel.docid)
                  .set({
                'batchName': batchName,
                'batchId': batchDocid,
              }, SetOptions(merge: true));
            }
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
          log('Student not added to any batch to delete');
        }
      }
    } catch (e) {
      log('deleteStudentFromBatch error: $e');
    }
  }

  Future<void> deleteStudentFromDrivingTest(StudentModel studentModel,
      {bool isArchiving = false}) async {
    try {
      final drivingTestsSnapshot = await _fbServer.collection("DrivingTest").get();

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
            final testDate = drivingTestDoc.data()['testDate'];
            if (isArchiving) {
              await _fbServer
                  .collection('Archives')
                  .doc(studentModel.docid)
                  .collection('CoursesDetails')
                  .doc(studentModel.docid)
                  .set({
                'testId': drivingTestDocid,
                'testDate': testDate,
              }, SetOptions(merge: true));
            }
            await _fbServer
                .collection("DrivingTest")
                .doc(drivingTestDocid)
                .collection('Students')
                .doc(studentModel.docid)
                .delete()
                .then((value) {
              log('Student deleted from driving test');
            });
          }
          log('Student not added to any driving test to delete');
        }
      }
    } catch (e) {
      log('deleteStudentFromDrivingTest error: $e');
    }
  }

  Future<void> deleteStudentFromFee(StudentModel studentModel, {bool isArchiving = false}) async {
    try {
      final feeCollectionSnapshot = await _fbServer
          .collection("FeesCollection")
          .doc(studentModel.batchId)
          .collection('Courses')
          .get();

      if (feeCollectionSnapshot.docs.isNotEmpty) {
        for (var feeDoc in feeCollectionSnapshot.docs) {
          final feeDocid = feeDoc.id;

          final studentDoc = await _fbServer
              .collection("FeesCollection")
              .doc(studentModel.batchId)
              .collection('Courses')
              .doc(feeDocid)
              .collection('Students')
              .doc(studentModel.docid)
              .get();

          if (studentDoc.exists) {
            final feeStatus = studentDoc.data()!['feeStatus'];
            final pendingAmount = studentDoc.data()!['pendingAmount'];

            if (isArchiving) {
              await _fbServer
                  .collection('Archives')
                  .doc(studentModel.docid)
                  .collection('CoursesDetails')
                  .doc(studentModel.docid)
                  .set({
                'feeStatus': feeStatus,
                'pendingAmount': pendingAmount,
              }, SetOptions(merge: true));
            }
            await _fbServer
                .collection("FeesCollection")
                .doc(studentModel.batchId)
                .collection('Courses')
                .doc(feeDocid)
                .collection('Students')
                .doc(studentModel.docid)
                .delete()
                .then((value) {
              log('Student deleted from fee collection');
            });
          }
        }
        log('Student not added to any feescollection to delete');
      }
    } catch (e) {
      log('deleteStudentFromFee error: $e');
    }
  }

  Future<void> deleteStudentFromPracticeSchedule(StudentModel studentModel,
      {bool isArchiving = false}) async {
    try {
      final practiceScheduleSnapshot = await _fbServer.collection("PracticeSchedule").get();

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
            if (isArchiving) {
              await _fbServer
                  .collection('Archives')
                  .doc(studentModel.docid)
                  .collection('CoursesDetails')
                  .doc(studentModel.docid)
                  .set({
                'practiceName': practiceName,
                'practiceId': practiceDocid,
              }, SetOptions(merge: true));
            }
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
          log('Student not added to any practice schedule to delete');
        }
      }
    } catch (e) {
      log('deleteStudentFromPracticeSchedule error: $e');
    }
  }
}
