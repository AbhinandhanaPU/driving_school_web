import 'package:awesome_side_sheet/Enums/sheet_position.dart';
import 'package:awesome_side_sheet/side_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/constant/constant.validate.dart';
import 'package:new_project_driving/controller/batch_controller/batch_controller.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/view/widget/progess_button/progress_button.dart';
import 'package:new_project_driving/view/widget/text_formfiled_container/textformfiled_blue_container.dart';

createBatchFunction(BuildContext context) {
  final BatchController batchController = Get.put(BatchController());
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
                    text: 'Batch',
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
                      key: batchController.formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                            child: TextFormFiledHeightnoColor(
                              width: 500,
                              controller: batchController.batchNameController,
                              validator: checkFieldEmpty,
                              title: 'Batch Name',
                              hintText: 'Batch Name', /////////////////////////////////////////0
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                            child: TextFormFiledHeightnoColor(
                              onTap: () async {
                                batchController.dateController.text =
                                    await dateTimePicker(context);
                              },
                              width: 500,
                              validator: checkFieldDateIsValid,
                              controller: batchController.dateController,
                              title: 'Date',
                              hintText: 'Date',
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
                                if (batchController.formKey.currentState!.validate()) {
                                  batchController.createBatch() 
                                //  .then((value) => Navigator.pop(context))
                                  ;
                                }
                              },
                              buttonstate: batchController.buttonstate.value,
                              text: 'Create Batch'))),
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
