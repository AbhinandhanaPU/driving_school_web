import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/constant/constant.validate.dart';
import 'package:new_project_driving/controller/test_controller/test_controller.dart';
import 'package:new_project_driving/view/widget/custom_showdialouge/custom_showdialouge.dart';
import 'package:new_project_driving/view/widget/text_formfiled_container/textformfiled_blue_container.dart';

editFunctionOfTest(BuildContext context, Map<String, dynamic> data) {
  final TestController testController = Get.put(TestController());
  customShowDilogBox(
      context: context,
      title: 'Edit',
      children: [
        Form(
          key: testController.formKey,
          child: Column(
            children: [
              TextFormFiledHeightnoColor(
                  validator: checkFieldDateIsValid,
                  controller: testController.testDateEditController,
                  onTap: () async {
                    testController.testDateEditController.text =
                        await dateTimePicker(context);
                  },
                  hintText: data['testDate'],
                  title: 'Date'),
              TextFormFiledHeightnoColor(
                  validator: checkFieldTimeIsValid,
                  controller: testController.testTimeEditController,
                  onTap: () async {
                    testController.testTimeEditController.text =
                        await timePicker(context);
                  },
                  hintText: data['testTime'],
                  title: 'Time'),
              TextFormFiledHeightnoColor(
                  validator: checkFieldEmpty,
                  controller: testController.testLocationEditController,
                  hintText: data['location'],
                  title: 'Location'),
            ],
          ),
        ),
      ],
      doyouwantActionButton: true,
      actiononTapfuction: () {
        if (testController.formKey.currentState!.validate()) {
          testController.editTest(
            data['docId'],
            context,
          );
        }
      },
      actiontext: 'Update');
}
