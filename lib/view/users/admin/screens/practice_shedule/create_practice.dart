import 'package:awesome_side_sheet/Enums/sheet_position.dart';
import 'package:awesome_side_sheet/side_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/constant/constant.validate.dart';
import 'package:new_project_driving/controller/notice_controller/notice_controller.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/view/widget/progess_button/progress_button.dart';
import 'package:new_project_driving/view/widget/text_formfiled_container/textformfiled_blue_container.dart';

createPracticeAdmin(BuildContext context) {
  final NoticeController noticeController = Get.put(NoticeController());
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
                    text: 'Practice Schedule',
                    fontsize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              Container(
                height: 900,
                width: 500,
                margin: const EdgeInsets.only(top: 10),
                child:
                    //  Obx(() {
                    // return
                    Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                      key: noticeController.formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5, left: 10, right: 10),
                            child: TextFormFiledHeightnoColor(
                              width: 500,
                              controller:
                                  noticeController.noticeHeadingController,
                              validator: checkFieldEmpty,
                              title: 'Slot Name',
                              hintText:
                                  'Slot Name', /////////////////////////////////////////0
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5, left: 10, right: 10),
                            child: TextFormFiledHeightnoColor(
                              onTap: () async {
                                noticeController.noticePublishedDateController
                                    .text = await dateTimePicker(context);
                              },
                              width: 500,
                              controller: noticeController
                                  .noticePublishedDateController,
                              validator: checkFieldDateIsValid,
                              title: 'Start Time',
                              hintText:
                                  'Start Time', /////////////////////////////////////////0
                            ),
                          ), ////////////////////////////////////////////////////////2
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5, left: 10, right: 10),
                            child: TextFormFiledHeightnoColor(
                              width: 500,
                              validator: checkFieldEmpty,
                              controller:
                                  noticeController.noticeSubjectController,
                              title: 'End Time',
                              hintText: 'End Time',
                            ),
                          ), ///////////////////////////////////////////////3
                         ////////////////////////////////////7
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Center(
                          child: Obx(() => ProgressButtonWidget(
                              function: () async {
                                if (noticeController.formKey.currentState!
                                    .validate()) {
                                  noticeController
                                      .createNotice()
                                      .then((value) => Navigator.pop(context));
                                }
                              },
                              buttonstate: noticeController.buttonstate.value,
                              text: 'Create Practice'))),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      showCloseButton: false,
      footer: Container());
}
