import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/constant/const.dart';
import 'package:new_project_driving/controller/mocktest_controller/model/answerModel.dart';
import 'package:new_project_driving/controller/mocktest_controller/model/questionModel.dart';
import 'package:new_project_driving/utils/firebase/firebase.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';
import 'package:uuid/uuid.dart';

class MockTestController extends GetxController {
  RxBool optionA = false.obs;
  RxBool optionB = false.obs;
  RxBool optionC = false.obs;
  RxBool optionD = false.obs;
  RxString correctAns = ''.obs;
  RxString imagePath = ''.obs;
  TextEditingController questionController = TextEditingController();
  TextEditingController optionAController = TextEditingController();
  TextEditingController optionBController = TextEditingController();
  TextEditingController optionCController = TextEditingController();
  TextEditingController optionDController = TextEditingController();


  TextEditingController editquestionController = TextEditingController();
  TextEditingController editoptionController = TextEditingController();
  // TextEditingController editoptionBController = TextEditingController();
  // TextEditingController editoptionCController = TextEditingController();
  // TextEditingController editoptionDController = TextEditingController();

  
  RxBool ontapViewAllQuestions = false.obs;
  final formKey = GlobalKey<FormState>();

  Future<void> uploadQuestionImage() async {
    final insertOptions = [
      optionAController.text, //0
      optionBController.text, //1
      optionCController.text, //2
      optionDController.text, //3
    ];
    final questionID = const Uuid().v1();
    QuizTestQuestionModel questionModel = QuizTestQuestionModel(
      questionNo: await genrateQuestionNo(),
      docid: questionID,
      imageQuestion: imagePath.value == '' ? false : true,
      question: questionController.text,
    );
    await server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('MockTestCollection')
        .doc(questionID)
        .set(questionModel.toMap())
        .then((value) async {
      if (imagePath.value != '') {
        Reference storegeRef =
            serverStorage.ref().child('MockQuestionCollection/images');
        // Upload the file
        await storegeRef
            .putData(Uint8List.fromList(utf8.encode(imagePath.value)))
            .then((p0) async {
          final String downloadURl = await p0.ref.getDownloadURL();
          await server
              .collection('DrivingSchoolCollection')
              .doc(UserCredentialsController.schoolId)
              .collection('MockTestCollection')
              .doc(questionID)
              .update({'imageID': downloadURl});
        });
      }
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
      showToast(msg: "Question Added");
      insertOptions.clear();
      optionAController.clear();
      optionBController.clear();
      optionCController.clear();
      optionDController.clear();
      optionA.value = false;
      optionB.value = false;
      optionC.value = false;
      optionD.value = false;
      imagePath.value = '';
    });
  }

  Future<int> genrateQuestionNo() async {
    int number = 1;
    await server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection("QuestionNoGenrator")
        .doc('number')
        .get()
        .then((value) async {
      if (value.exists && value.data() != null) {
        if (value.data()!.containsKey('number')) {
          await server
              .collection('DrivingSchoolCollection')
              .doc(UserCredentialsController.schoolId)
              .collection("QuestionNoGenrator")
              .doc('number')
              .get()
              .then((value) async {
            number = value.data()!['number'] + 1;
            await server
                .collection('DrivingSchoolCollection')
                .doc(UserCredentialsController.schoolId)
                .collection("QuestionNoGenrator")
                .doc('number')
                .set({'number': number});
          });
        }
      } else {
        await server
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection("QuestionNoGenrator")
            .doc('number')
            .set({'number': 1});
      }
    });

    return number;
  }
   Future<void> updateMockQuestion(String mockID, BuildContext context) async {
    try {
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('MockTestCollection')
          .doc(mockID)
          .update({
        'question': editquestionController.text,
     //   'imageID': editcourseDesController.text,
        
      }).then((value) {
        editquestionController.clear();
        Navigator.pop(context);
      }).then((value) => showToast(msg: 'Mock Updated!'));
    } catch (e) {
      log("Mock Updation failed");
    }
  }

     Future<void> updateMockOption(String mockID, BuildContext context,String optionID) async {
    try {
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('MockTestCollection')
          .doc(mockID)
          .collection("Options")
          .doc(optionID)
          .update({
        'options': editoptionController.text,
     //   'imageID': editcourseDesController.text,
        
      }).then((value) {
        editoptionController.clear();
        Navigator.pop(context);
      }).then((value) => showToast(msg: 'Mock Updated!'));
    } catch (e) {
      log("Mock Updation failed");
    }
  }
}
