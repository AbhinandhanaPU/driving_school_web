import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/constant/constant.validate.dart';
import 'package:new_project_driving/controller/batch_controller/batch_controller.dart';
import 'package:new_project_driving/model/batch_model/batch_model.dart';
import 'package:new_project_driving/view/widget/custom_showdialouge/custom_showdialouge.dart';
import 'package:new_project_driving/view/widget/text_formfiled_container/textformfiled_blue_container.dart';

editFunctionOfbatch(BuildContext context, BatchModel data) {
  final BatchController batchController =
      Get.put(BatchController());

  customShowDilogBox(
      context: context,
      title: 'Edit',
      children: [
        Form(
          key: batchController.formKey,
          child: Column(
            children: [
              TextFormFiledHeightnoColor(
                validator: checkFieldEmpty,
                controller: batchController.batchNameController,
                hintText: data.batchName,
                title: 'name',
              ),
              TextFormFiledHeightnoColor(
                onTap: () async {
                  batchController.dateController.text =
                      await dateTimePicker(context);
                },
                validator: checkFieldDateIsValid,
                controller: batchController.dateController,
                hintText: data.date,
                title: 'Date',
              ),
            ],
          ),
        ),
      ],
      doyouwantActionButton: true,
      actiononTapfuction: () {
        if (batchController.formKey.currentState!.validate()) {
          batchController.updateBatch(
            data.batchId,
            context,
          );
        }
      },
      actiontext: 'Update');
}
