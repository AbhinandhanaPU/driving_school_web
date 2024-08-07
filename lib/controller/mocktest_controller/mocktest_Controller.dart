import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:new_project_driving/controller/mocktest_controller/model/answerModel.dart';
import 'package:new_project_driving/controller/mocktest_controller/model/questionModel.dart';
import 'package:new_project_driving/utils/firebase/firebase.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';
import 'package:uuid/uuid.dart';

class MockTestController extends GetxController {
  RxString correctAns = ''.obs;

  TextEditingController questionController = TextEditingController();
  TextEditingController optionAController = TextEditingController();
  TextEditingController optionBController = TextEditingController();
  TextEditingController optionCController = TextEditingController();
  TextEditingController optionDController = TextEditingController();

  Future<void> uploadQuestionWithoutImage() async {
    final insertOptions = [
      optionAController.text, //0
      optionBController.text, //1
      optionCController.text, //2
      optionDController.text, //3
    ];
    final questionID = const Uuid().v1();
    QuizTestQuestionModel questionModel = QuizTestQuestionModel(
      docid: questionID,
      imageQuestion: false,
      question: questionController.text,
    );
    await server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('MockTestCollection')
        .doc(questionID)
        .set(questionModel.toMap())
        .then((value) async {
      for (var i = 0; i < insertOptions.length; i++) {
        final optionsID = const Uuid().v1();
        QuizTestAnswerModel answerModel = QuizTestAnswerModel(
          docid: optionsID,
          options: insertOptions[i],
          isCorrect: insertOptions[i] == correctAns.value ? true : false,
        );

        await server
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection('MockTestCollection')
            .doc(questionID)
            .collection("Options")
            .doc(optionsID)
            .set(
              answerModel.toMap(),
            );
      }
    }).then((value) async {
      insertOptions.clear();
      optionAController.clear();
      optionBController.clear();
      optionCController.clear();
      optionDController.clear();
    });
  }
}
