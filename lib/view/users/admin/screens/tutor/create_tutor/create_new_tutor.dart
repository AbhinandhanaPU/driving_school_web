import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/constant/constant.validate.dart';
import 'package:new_project_driving/controller/admin_section/Tutor_controller/tutor_controller.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/model/teacher_model/teacher_model.dart';
import 'package:new_project_driving/view/widget/back_button/back_button.dart';
import 'package:new_project_driving/view/widget/progess_button/progress_button.dart';
import 'package:new_project_driving/view/widget/text_formfiled_container/textformfiled_blue_container.dart';

createTeacherFunction(BuildContext context) {
  final TutorController teacherController = Get.put(TutorController());
  final createTeacherList = [
    TextFormFiledBlueContainerWidgetWithOutColor(
      controller: teacherController.tutorNameController,
      hintText: " Enter Teacher Name",
      title: 'Teacher  Name',
      validator: checkFieldEmpty,
    ), /////////////////////////...........................0....................name
    TextFormFiledBlueContainerWidgetWithOutColor(
      controller: teacherController.tutorPhoneNumeber,
      hintText: " Enter Teacher  Ph",
      title: 'Phone Number',
      validator: checkFieldPhoneNumberIsValid,
    ), //////////////////1....................number...................
    TextFormFiledBlueContainerWidgetWithOutColor(
      controller: teacherController.tutorEmailController,
      hintText: " Enter Employee Email",
      title: 'Employee Email',
      validator: checkFieldEmpty,
    ), ///////////////////4.......................
    Obx(() => ProgressButtonWidget(
        function: () async {
          if (teacherController.formKey.currentState!.validate()) {
            teacherController
                .createNewTutor(TeacherModel(
                  teacherName: teacherController.tutorNameController.text,
                  teacheremail: teacherController.tutorEmailController.text,
                  phoneNumber: teacherController.tutorPhoneNumeber.text.trim(),
                ))
                .then((value) => Get.back());
          }
        },
        buttonstate: teacherController.buttonstate.value,
        text: 'Create Teacher ')),
  ];
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BackButtonContainerWidget(),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: TextFontWidget(
                text: "Create Teacher ",
                fontsize: 15,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
        content: SizedBox(
          height: 380,
          width: 300,
          child: Form(
            key: teacherController.formKey,
            child: Column(
              children: [
                createTeacherList[0],
                createTeacherList[1],
                createTeacherList[2],
                createTeacherList[3],
              ],
            ),
          ),
        ),
      );
    },
  );
}
