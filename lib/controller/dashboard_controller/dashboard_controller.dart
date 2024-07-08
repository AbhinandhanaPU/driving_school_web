import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';

class DashboardController extends GetxController {
  Future<int> fetchTotalStudents() async {
    try {
      CollectionReference studentsRef = FirebaseFirestore.instance
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Students');

      QuerySnapshot studentsSnapshot = await studentsRef.get();

      return studentsSnapshot.docs.length;
    } catch (e) {
      log("Error fetching student count: $e");
      return 0; // Return 0 or handle error appropriately
    }
  }

  Future<int> fetchTotalTutors() async {
    try {
      CollectionReference tutorRef = FirebaseFirestore.instance
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Teachers');

      QuerySnapshot tutorSnapshot = await tutorRef.get();

      return tutorSnapshot.docs.length;
    } catch (e) {
      log("Error fetching Teachers count: $e");
      return 0; // Return 0 or handle error appropriately
    }
  }
}
