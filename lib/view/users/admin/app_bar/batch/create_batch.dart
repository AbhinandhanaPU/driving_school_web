import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/constant/constant.validate.dart';
import 'package:new_project_driving/controller/batch_controller/batch_controller.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/view/widget/progess_button/progress_button.dart';
import 'package:new_project_driving/view/widget/text_formfiled_container/textformfiled_blue_container.dart';

createBatchFunction(BuildContext context) {
  final BatchController batchController = Get.put(BatchController());

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const TextFontWidget(
          text: 'Create Batch',
          fontsize: 14,
          fontWeight: FontWeight.bold,
        ),
        content: SizedBox(
          height: 200,
          child: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Form(
                  key: batchController.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 5, left: 10, right: 10),
                        child: TextFormFiledHeightnoColor(
                          width: 500,
                          controller: batchController.batchNameController,
                          validator: checkFieldEmpty,
                          title: 'Batch Name',
                          hintText: 'Batch Name',
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 5, left: 10, right: 10),
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () async {
              Navigator.of(context).pop();
            },
          ),
          Obx(() => ProgressButtonWidget(
              function: () async {
                if (batchController.formKey.currentState!.validate()) {
                  batchController.createBatch();
                }
              },
              buttonstate: batchController.buttonstate.value,
              text: 'Create Batch'))
        ],
      );
    },
  );
}
