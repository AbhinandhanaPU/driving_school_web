import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/constant/constant.validate.dart';
import 'package:new_project_driving/controller/study_materials/study_materials_controller.dart';
import 'package:new_project_driving/view/widget/custom_showdialouge/custom_showdialouge.dart';
import 'package:new_project_driving/view/widget/text_formfiled_container/textformfiled_blue_container.dart';

editFunctionOfStudyMaterials(BuildContext context, Map<String, dynamic> data) {
  final StudyMaterialsController studyMaterialsController =
      Get.put(StudyMaterialsController());
  customShowDilogBox(
      context: context,
      title: 'Edit',
      children: [
        Form(
          key: studyMaterialsController.formKey,
          child: Column(
            children: [
              TextFormFiledHeightnoColor(
                  validator: checkFieldEmpty,
                  controller: studyMaterialsController.titleEditController,
                  hintText: data['title'],
                  title: 'Title'),
              TextFormFiledHeightnoColor(
                  validator: checkFieldEmpty,
                  controller: studyMaterialsController.desEditController,
                  hintText: data['des'],
                  title: 'Description'),
              TextFormFiledHeightnoColor(
                  validator: checkFieldEmpty,
                  controller: studyMaterialsController.cateEditController,
                  hintText: data['category'],
                  title: 'Category'),
            ],
          ),
        ),
      ],
      doyouwantActionButton: true,
      actiononTapfuction: () {
        if (studyMaterialsController.formKey.currentState!.validate()) {
          studyMaterialsController.updateStudyMaterial(
            data['docId'],
            context,
          );
        }
      },
      actiontext: 'Update');
}
