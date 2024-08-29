import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/constant/const.dart';
import 'package:new_project_driving/model/student_model/student_model.dart';
import 'package:new_project_driving/utils/firebase/firebase.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';
import 'package:new_project_driving/view/login_section/user_loginpage.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:uuid/uuid.dart';

class StudentSignUpController extends GetxController {
  final formKey = GlobalKey<FormState>();
  RxBool isLoading = RxBool(false);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController fatherSpouseController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController rtoNameController = TextEditingController();
  TextEditingController licenceController = TextEditingController();
  RxString downloadUrl = ''.obs;
  void clearFields() {
    emailController.clear();
    passwordController.clear();
    confirmpasswordController.clear();
    nameController.clear();
    phoneController.clear();
    dateOfBirthController.clear();
    fatherSpouseController.clear();
    placeController.clear();
    addressController.clear();
    rtoNameController.clear();
    licenceController.clear();
  }

  String uid = const Uuid().v1();
  Rx<ButtonState> buttonstate = ButtonState.idle.obs;

  Future<void> createStudent(BuildContext context) async {
    buttonstate.value = ButtonState.loading;
    String imageId = uid;
    try {
      await serverAuth
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((authvalue) async {
        StudentModel studentModel = StudentModel(
          docid: authvalue.user!.uid,
          password: passwordController.text,
          studentemail: emailController.text,
          studentName: nameController.text,
          phoneNumber: phoneController.text,
          dateofBirth: dateOfBirthController.text,
          guardianName: fatherSpouseController.text,
          address: addressController.text,
          place: placeController.text,
          profileImageId: imageId,
          profileImageUrl: downloadUrl.value,
          rtoName: rtoNameController.text,
          licenceNumber: licenceController.text,
          joiningDate: DateTime.now().toString(),
          userRole: "student",
          status: true, //change
          level: "Beginner",
          batchId: '',
          batchName: '',
        );
        await server
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection('Students')
            .doc(authvalue.user!.uid)
            .set(
              studentModel.toMap(),
            )
            .then(
          (value) async {
            buttonstate.value = ButtonState.success;
            await Future.delayed(const Duration(seconds: 2)).then((vazlue) {
              buttonstate.value = ButtonState.idle;
            });
            final user = await server
                .collection('DrivingSchoolCollection')
                .doc(UserCredentialsController.schoolId)
                .collection('Students')
                .doc(authvalue.user!.uid)
                .get();
            if (user.data() != null) {
              UserCredentialsController.studentModel =
                  StudentModel.fromMap(user.data()!);
              log(UserCredentialsController.studentModel.toString());
            }

            if (UserCredentialsController.studentModel?.userRole == "student") {
              await SharedPreferencesHelper.setString(
                      SharedPreferencesHelper.userRoleKey, 'student')
                  .then((value) {
                clearFields();
                return showDialog(
                  context: context,
                  barrierDismissible: false, // user must tap button!
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Message'),
                      content: const SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Text(
                                'Your Profile Created Successfully ...login again to continue...')
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Ok'),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const UserLoginPageScreen();
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              });

              isLoading.value = false;
            }
          },
        ).then((value) {
          clearFields();
          isLoading.value = false;
        });
      });
    } on FirebaseAuthException catch (e) {
      showToast(msg: e.code);
    } catch (e) {
      log(e.toString());
      showToast(msg: 'Somthing went wrong please try again');
      buttonstate.value = ButtonState.fail;
      await Future.delayed(const Duration(seconds: 2)).then((value) {
        buttonstate.value = ButtonState.idle;
      });
    }
  }
}
