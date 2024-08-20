import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/constant/constant.validate.dart';
import 'package:new_project_driving/controller/mocktest_controller/mocktest_controller.dart';
import 'package:new_project_driving/controller/mocktest_controller/model/answer_model.dart';
import 'package:new_project_driving/controller/mocktest_controller/model/question_model.dart';
import 'package:new_project_driving/view/widget/custom_showdialouge/custom_showdialouge.dart';
import 'package:new_project_driving/view/widget/text_formfiled_container/textformfiled_blue_container.dart';

editMockTestQuestions(BuildContext context, QuizTestQuestionModel model) {
  final MockTestController mtController = Get.put(MockTestController());
  customShowDilogBox(
    context: context,
    title: 'Edit ',
    children: [
      Form(
          key: mtController.formKey,
          child: Column(
            children: [
              TextFormFiledHeightnoColor(
                  validator: checkFieldEmpty,
                  controller: mtController.editquestionController,
                  hintText: model.question,
                  title: 'Question'),
            ],
          ))
    ],
    doyouwantActionButton: true,
    actiononTapfuction: () {
      if (mtController.formKey.currentState!.validate()) {
        mtController.updateMockQuestion(
          model.docid,
          context,
        );
      }
    },
  );
}

editMockTestOptions(BuildContext context, QuizTestQuestionModel questionData,
    QuizTestAnswerModel answerData) {
  final MockTestController mtController = Get.put(MockTestController());
  customShowDilogBox(
    context: context,
    title: 'Edit ',
    children: [
      Form(
          key: mtController.formKey,
          child: Column(
            children: [
              TextFormFiledHeightnoColor(
                  validator: checkFieldEmpty,
                  controller: mtController.editoptionController,
                  hintText: answerData.options,
                  title: 'Question'),
            ],
          ))
    ],
    doyouwantActionButton: true,
    actiononTapfuction: () {
      if (mtController.formKey.currentState!.validate()) {
        mtController.updateMockOption(
          questionData.docid,
          context,
          answerData.docid,
        );
      }
    },
  );
}
