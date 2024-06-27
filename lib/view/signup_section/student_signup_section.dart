// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/constant/constant.validate.dart';
import 'package:new_project_driving/controller/user_signup_controller/student_signup_controller.dart';
import 'package:new_project_driving/controller/user_signup_controller/teacher_signup_controller.dart';
import 'package:new_project_driving/fonts/fonts.dart';
import 'package:new_project_driving/view/widget/Iconbackbutton.dart';
import 'package:new_project_driving/view/widget/signup_form_field_widget/signup_form_field_widget.dart';
import 'package:uuid/uuid.dart';

class StudentProfileCreationScreen extends StatefulWidget {
  const StudentProfileCreationScreen({super.key});

  @override
  State<StudentProfileCreationScreen> createState() =>
      _StudentProfileCreationScreenState();
}

StudentSignUpController studentSignUpController = StudentSignUpController();
TeacherSignUpController teacherSignUpController = TeacherSignUpController();

class _StudentProfileCreationScreenState
    extends State<StudentProfileCreationScreen> {
  Uint8List? file;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Row(
        children: [
          Container(
            color: adminePrimayColor,
            width: 730,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 35),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButtonBackWidget(color: cWhite),
                      const SizedBox(width: 150),
                      Text(
                        'Hi ! Lepton ',
                        style: ralewayStyle.copyWith(
                          fontSize: 30,
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        '    Welcomes you',
                        style: ralewayStyle.copyWith(
                          fontSize: 23,
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 25),
                    child: Text(
                      'Sign up as a student',
                      style: ralewayStyle.copyWith(
                        fontSize: 18,
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: SizedBox(
                    height: 890,
                    width: 800,
                    child: Center(
                      child: Lottie.asset(
                        'webassets/lottie_files/network_connection.json',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 800,
            height: size.height,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    left: size.width / 10, right: size.width / 10),
                child: Form(
                  key: studentSignUpController.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SignUpTextFormFieldWidget(
                        labelText: "Name *",
                        hintText: "Name",
                        icon: Icons.person,
                        keyboardType: TextInputType.text,
                        textEditingController:
                            studentSignUpController.nameController,
                        function: checkFieldEmpty,
                      ),
                      SizedBox(height: 10.h),
                      SignUpTextFormFieldWidget(
                        labelText: "Phone Number *",
                        hintText: "Phone Number",
                        icon: Icons.phone,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        textEditingController:
                            studentSignUpController.phoneController,
                        function: checkFieldPhoneNumberIsValid,
                      ),
                      SizedBox(height: 10.h),
                      SignUpTextFormFieldWidget(
                        labelText: 'Date of birth',
                        hintText: 'DOB',
                        icon: Icons.calendar_today,
                        keyboardType: TextInputType.none,
                        textEditingController:
                            studentSignUpController.dateOfBirthController,
                        function: checkFieldDateIsValid,
                        onTapFunction: () async {
                          studentSignUpController.dateOfBirthController.text =
                              await dateTimePicker(context);
                        },
                      ),
                      SizedBox(height: 10.h),
                      SignUpTextFormFieldWidget(
                        labelText: "Father/Spouse Name *",
                        hintText: "Name",
                        icon: Icons.person,
                        keyboardType: TextInputType.text,
                        textEditingController:
                            studentSignUpController.fatherSpouseController,
                        function: checkFieldEmpty,
                      ),
                      SizedBox(height: 10.h),
                      SignUpTextFormFieldWidget(
                        labelText: "Place *",
                        hintText: "Place",
                        icon: Icons.location_city,
                        keyboardType: TextInputType.text,
                        textEditingController:
                            studentSignUpController.placeController,
                        function: checkFieldEmpty,
                      ),
                      SizedBox(height: 10.h),
                      SignUpTextFormFieldWidget(
                        labelText: "Address *",
                        hintText: "Address",
                        icon: Icons.location_on,
                        keyboardType: TextInputType.multiline,
                        textEditingController:
                            studentSignUpController.addressController,
                        function: checkFieldEmpty,
                      ),
                      SizedBox(height: 10.h),
                      SignUpTextFormFieldWidget(
                        labelText: "RTO Name *",
                        hintText: "Name",
                        icon: Icons.person,
                        keyboardType: TextInputType.text,
                        textEditingController:
                            studentSignUpController.rtoNameController,
                        function: checkFieldEmpty,
                      ),
                      SizedBox(height: 10.h),
                      SignUpTextFormFieldWidget(
                        labelText: "License Number",
                        hintText: "Number",
                        icon: Icons.drive_file_rename_outline,
                        keyboardType: TextInputType.text,
                        textEditingController:
                            studentSignUpController.licenceController,
                        function: checkFieldEmpty,
                      ),
                      const SizedBox(height: 10),
                      SignUpTextFormFieldWidget(
                        textEditingController:
                            studentSignUpController.emailController,
                        function: checkFieldEmailIsValid,
                        labelText: 'Enter email',
                        hintText: "Enter mail ID",
                        icon: Icons.mail_outline,
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          obscureText: true,
                          validator: checkFieldPasswordIsValid,
                          controller:
                              studentSignUpController.passwordController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            icon: const Icon(
                              Icons.lock_outline_sharp,
                              color: Color.fromARGB(221, 28, 9, 110),
                            ),
                            labelText: 'Password',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          obscureText: true,
                          validator: (value) {
                            if (value ==
                                studentSignUpController
                                    .passwordController.text) {
                              return null;
                            } else {
                              return 'Passwords do not match';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            icon: const Icon(
                              Icons.lock_outline_sharp,
                              color: Color.fromARGB(221, 28, 9, 110),
                            ),
                            labelText: 'Confirm Password',
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Stack(
                        children: [
                          (file == null)
                              ? const CircleAvatar(
                                  radius: 80,
                                  backgroundColor: Colors.blue,
                                )
                              : CircleAvatar(
                                  radius: 80,
                                  backgroundImage: MemoryImage(file!),
                                ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: IconButton(
                              onPressed: () async {
                                FilePickerResult? result =
                                    await FilePicker.platform.pickFiles(
                                  type: FileType.image,
                                );
                                if (result != null) {
                                  file = result.files.first.bytes;
                                  setState(() {});
                                }
                              },
                              icon: const Icon(Icons.camera_alt),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: SizedBox(
                          height: 50,
                          width: 150,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 3, 39, 68),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () async {
                              if (file == null) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Image'),
                                    content: const Text(
                                      'Please add an image before proceeding.',
                                    ),
                                    actions: [
                                      MaterialButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        color: Colors.blue,
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                if (studentSignUpController
                                    .formKey.currentState!
                                    .validate()) {
                                  if (await teacherSignUpController
                                      .isEmailInTempTeacherList(
                                          studentSignUpController
                                              .emailController.text)) {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.all(Radius.zero)),
                                        content: const Text(
                                            "This Email can't used by the User"),
                                        actions: [
                                          MaterialButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    String uid = const Uuid().v1();
                                    UploadTask uploadTask = FirebaseStorage
                                        .instance
                                        .ref()
                                        .child("files/studentProfile/$uid")
                                        .putData(file!);
                                    final TaskSnapshot snap = await uploadTask;
                                    studentSignUpController.downloadUrl.value =
                                        await snap.ref.getDownloadURL();
                                    await studentSignUpController
                                        .createStudent(context);
                                  }
                                }
                              }
                            },
                            child: const Text(
                              'Create',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
