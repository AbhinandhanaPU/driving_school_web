import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/constant/const.dart';
import 'package:new_project_driving/model/course_model/course_model.dart';
import 'package:new_project_driving/model/student_model/student_model.dart';
import 'package:new_project_driving/utils/firebase/firebase.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';

class FeeController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController amountController = TextEditingController();

  final _fbServer = server
      .collection('DrivingSchoolCollection')
      .doc(UserCredentialsController.schoolId);

  Future<void> addStudentFeeColl(
    StudentModel studentModel,
    String status,
    CourseModel course,
  ) async {
    try {
      int amountPaid = int.tryParse(amountController.text) ?? 0;

      // Fetch the course document
      DocumentSnapshot courseDoc = await _fbServer
          .collection('FeeCollection')
          .doc(course.courseId)
          .get();

      int paidAmount = 0;
      int totalStudents = 0;
      int totalAmount = 0;

      if (courseDoc.exists) {
        Map<String, dynamic> courseData =
            courseDoc.data() as Map<String, dynamic>;
        paidAmount = courseData['amountPaid'] ?? 0;
        totalStudents = courseData['totalStudents'] ?? 0;
        totalAmount = courseData['totalAmount'] ?? 0;
      }
      DocumentSnapshot studentDoc = await _fbServer
          .collection('FeeCollection')
          .doc(course.courseId)
          .collection('Students')
          .doc(studentModel.docid)
          .get();

      if (studentDoc.exists) {
        // If the student exists, update the amount paid
        await _fbServer
            .collection('FeeCollection')
            .doc(course.courseId)
            .collection('Students')
            .doc(studentModel.docid)
            .update({
          'feeStatus': status,
          'amountPaid': FieldValue.increment(amountPaid),
        });

        paidAmount += amountPaid;
      } else {
        await _fbServer
            .collection('FeeCollection')
            .doc(course.courseId)
            .collection('Students')
            .doc(studentModel.docid)
            .set({
          'studentName': studentModel.studentName,
          'studentID': studentModel.docid,
          'feeStatus': status,
          'amountPaid': amountPaid,
          'totalAmount': course.rate
        });

        paidAmount += amountPaid;
        totalStudents += 1;
        totalAmount += amountPaid;
      }

      await _fbServer.collection('FeeCollection').doc(course.courseId).update({
        'amountPaid': paidAmount,
        'totalStudents': totalStudents,
        'totalAmount': totalAmount,
        'pendingAmount': totalAmount - paidAmount,
      });

      await acceptStudentToCourse(studentModel, status, course.courseId);

      amountController.clear();
      update();
      showToast(msg: 'Student fees updated');
      log("Fees Status Updated");
    } catch (e) {
      log("FeeCollection error: $e");
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

  Future<void> declineStudentToCourse(
    StudentModel studentModel,
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
        showToast(msg: 'Student request declined');
        log("Student request declined");
      } else {
        log("Student not found in RequestedStudents collection.");
      }
    } catch (e) {
      log("Students approval error: $e");
    }
  }

  Future<void> getFeeTotalAmount(
    String courseId,
    int fee,
  ) async {
    await server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('FeeCollection')
        .doc(courseId)
        .collection('Students')
        .get()
        .then((value) async {
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('FeeCollection')
          .doc(courseId)
          .set({
        'totalStudents': value.docs.length,
        'totalAmount': fee * value.docs.length,
      }, SetOptions(merge: true));
    });
  }

  Future<void> pendingAmountCalculate(String courseID) async {
    try {
      final courseDoc = await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('FeeCollection')
          .doc(courseID)
          .get();

      int totalAmount = courseDoc.data()?['totalAmount'] ?? 0;
      int amountPaid = courseDoc.data()?['amountPaid'] ?? 0;
      int pendingAmount = totalAmount - amountPaid;
      log('Pending amount: $pendingAmount');

      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('FeeCollection')
          .doc(courseID)
          .update({'pendingAmount': pendingAmount});
    } catch (e) {
      log('Error calculating pending amount: $e');
    }
  }
}
