import 'package:awesome_side_sheet/Enums/sheet_position.dart';
import 'package:awesome_side_sheet/side_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/controller/practice_shedule_controller/practice_shedule_controller.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/view/widget/dropdown_widget/student_dropdown/all_students.dart';
import 'package:new_project_driving/view/widget/progess_button/progress_button.dart';

addStudentsPractice(BuildContext context) {
  final PracticeSheduleController practiceSheduleController =
      Get.put(PracticeSheduleController());
  aweSideSheet(
    context: context,
    sheetPosition: SheetPosition.right,
    header: Container(),
    body: Padding(
      padding: const EdgeInsets.only(left: 10, top: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Row(
              children: [
                BackButton(),
                SizedBox(
                  width: 20,
                ),
                TextFontWidget(
                  text: 'Add Students',
                  fontsize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            Container(
              height: 900,
              width: 500,
              margin: const EdgeInsets.only(top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                    key: practiceSheduleController.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                              top: 5, left: 10, right: 10, bottom: 5),
                          child: TextFontWidget(
                              text: 'Select Student *', fontsize: 12.5),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5, left: 10, right: 10, bottom: 15),
                          child: AllStudentDropDown(),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Center(
                      child: Obx(
                        () => ProgressButtonWidget(
                          function: () async {
                            if (practiceSheduleController.formKey.currentState!
                                .validate()) {
                              practiceSheduleController
                                  .addStudent()
                                //  .then((value) => Navigator.pop(context))
                                  ;
                            }
                          },
                          buttonstate:
                              practiceSheduleController.buttonstate.value,
                          text: 'Add Student',
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ),
    showCloseButton: false,
    footer: Container(),
  );
}
