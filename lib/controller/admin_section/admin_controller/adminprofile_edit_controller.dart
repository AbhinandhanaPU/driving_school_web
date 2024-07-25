import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/constant/const.dart';
import 'package:new_project_driving/model/admin_model/admin_model.dart';
import 'package:new_project_driving/utils/firebase/firebase.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';
import 'package:progress_state_button/progress_button.dart';

class AdminProfileEditController extends GetxController {
  final formKey = GlobalKey<FormState>();

  Rx<ButtonState> buttonstate = ButtonState.idle.obs;

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController adminNameController = TextEditingController();

  clearFeilds() {
    phoneNumberController.clear();
    designationController.clear();
    placeController.clear();
    addressController.clear();
    adminNameController.clear();
  }

  Future<void> updateAdminProfile(BuildContext context) async {
    final Map<String, dynamic> updateProfileadmin = {
      'phoneNumber': phoneNumberController.text,
      'designation': designationController.text,
      'address': placeController.text,
      'place': addressController.text,
      'adminName': adminNameController.text
    };
    try {
      server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .update(updateProfileadmin)
          .then((value) {
            clearFeilds();
          })
          .then((value) {
            Navigator.pop(context);
            Navigator.pop(context);
          })
          .then((value) => showToast(msg: 'AdminProfile Updated!'))
          .then((value) async {
            final user = await server
                .collection('DrivingSchoolCollection')
                .doc(UserCredentialsController.schoolId)
                .get();

            if (user.data() != null) {
              UserCredentialsController.adminModel = AdminModel.fromMap(user.data()!);
              log(UserCredentialsController.adminModel.toString());
            }
          });
    } catch (e) {
      showToast(msg: 'AdminProfile  Updation failed.Try Again');
      log("AdminProfile Updation failed $e");
    }
  }
}
