import 'package:awesome_side_sheet/Enums/sheet_position.dart';
import 'package:awesome_side_sheet/side_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/constant/constant.validate.dart';
import 'package:new_project_driving/controller/test_controller/test_controller.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/view/widget/progess_button/progress_button.dart';
import 'package:new_project_driving/view/widget/text_formfiled_container/textformfiled_blue_container.dart';

addStudents(BuildContext context) {
  final TestController testController = Get.put(TestController());
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
                    key: testController.formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5, left: 10, right: 10),
                          child: TextFormFiledHeightnoColor(
                            width: 500,
                            controller: testController.testDateController,
                            validator: checkFieldDateIsValid,
                            title: 'Date',
                            hintText: 'Date',
                            onTap: () async {
                              testController.testDateController.text =
                                  await dateTimePicker(context);
                            },
                          ),
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
                            if (testController.formKey.currentState!
                                .validate()) {
                              testController
                                  .addTestDate()
                                  .then((value) => Navigator.pop(context));
                            }
                          },
                          buttonstate: testController.buttonstate.value,
                          text: 'Add Schudele',
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
