import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:new_project_driving/constant/const.dart';
import 'package:new_project_driving/constant/constant.validate.dart';
import 'package:new_project_driving/controller/notification_controller/notification_controller.dart';
import 'package:new_project_driving/model/course_model/course_model.dart';
import 'package:new_project_driving/model/fees_model/fees_model_controller.dart';
import 'package:new_project_driving/model/student_model/student_model.dart';
import 'package:new_project_driving/utils/firebase/firebase.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';
import 'package:new_project_driving/view/widget/notification_color/notification_color_widget.dart';
import 'package:progress_state_button/progress_button.dart';

class FeesAndBillsController extends GetxController {
  RxList<CourseModel> allClassList = RxList<CourseModel>();
  RxList<CourseModel> selectedClassList = RxList<CourseModel>();
  RxBool selectAllClass = false.obs;
  Rx<ButtonState> buttonstate = ButtonState.idle.obs;
  RxBool ontapCreateFees = false.obs;
  RxBool ontapviewclasswiseFees = false.obs;
  RxInt classinitalFee = 0.obs;
  RxInt studentClassWiseCount = 0.obs;
  List<StudentModel> studentData = [];
  Future<int> fetchInitalClassFee(String courseDocID) async {
    //print("fetchInitalClassFee ....$courseDocID");
    await server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('Courses')
        .doc(courseDocID)
        .get()
        .then((value) async {
          int rate = int.parse(value.data()!['rate']);
      classinitalFee.value = rate;
    });
    return classinitalFee.value;
  }

  Future<RxList<CourseModel>> fetchClass() async {
    allClassList.clear();
    selectedClassList.clear();

    final firebase = await server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('Courses')
        .get();

    for (var i = 0; i < firebase.docs.length; i++) {
      final list =
          firebase.docs.map((e) => CourseModel.fromMap(e.data())).toList();
      allClassList.add(list[i]);
    }
    return allClassList;
  }

  TextEditingController feestypeNameContoller = TextEditingController();
  TextEditingController feesContoller = TextEditingController();
  TextEditingController feesDueContoller = TextEditingController();
  Future<void> addCustomFessAsignToClass() async {
    final String docid = '${feestypeNameContoller.text}${uuid.v1()}';

    buttonstate.value = ButtonState.loading;
    final ClassFeesModel feesDetail = ClassFeesModel(
        docid: docid,
        feestypeName: feestypeNameContoller.text,
        fees: int.parse(feesContoller.text.trim()),
        createdDate: DateTime.now(),
        dueDate: DateTime.now()
            .add(Duration(days: int.parse(feesDueContoller.text.trim()))));
    try {
      for (var i = 0; i < selectedClassList.length; i++) {
        await server
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection('Courses')
            .doc(selectedClassList[i].courseId)
            .collection("ClassFees")
            .doc(selectedFeeMonthContoller.text.trim())
            .set({'docid': selectedFeeMonthContoller.text.trim()}).then(
                (value) async {
          await feesCollection(
                  data: feesDetail,
                  docid: selectedFeeMonthContoller.text.trim(),
                  feeDocid: docid)
              .then((value) async {
            await getStudentClassWiseCount(
                selectedClassList[i].courseId,
                selectedFeeMonthContoller.text.trim(),
                int.parse(feesContoller.text.trim()),
                docid);
          });
          await server
              .collection('DrivingSchoolCollection')
              .doc(UserCredentialsController.schoolId)
              .collection('Courses')
              .doc(selectedClassList[i].courseId)
              .collection("ClassFees")
              .doc(selectedFeeMonthContoller.text.trim())
              .collection('StudentsFees')
              .doc(docid)
              .set(feesDetail.toMap());
        });
      }
                  feestypeNameContoller.clear();
            feesContoller.clear();
            selectAllClass.value=false;
            selectedClassList.clear();
            feesDueContoller.clear();
            seletedFeeDateContoller.clear();
            selectedFeeMonthContoller.clear();
            buttonstate.value = ButtonState.success;
            await Future.delayed(const Duration(seconds: 2)).then((vazlue) {
              buttonstate.value = ButtonState.idle;
            });
            Get.back();
            Get.back();
            selectedClassList.clear();
            allClassList.clear();
            showToast(msg: 'Fees Genrated Completed');
    } catch (e) {
      showToast(msg: 'Somthing went wrong please try again');
      buttonstate.value = ButtonState.fail;
      await Future.delayed(const Duration(seconds: 2)).then((value) {
        buttonstate.value = ButtonState.idle;
      });
      if (kDebugMode) {}
    }
  }

  Future<void> addFessAsignToClass() async {
    final String docid = '${feestypeNameContoller.text}${uuid.v1()}';

    buttonstate.value = ButtonState.loading;

    try {
      
      for (var i = 0; i < selectedClassList.length; i++) {
        final ClassFeesModel feesDetail = ClassFeesModel(
            docid: docid,
            feestypeName: feestypeNameContoller.text,
            fees: classinitalFee.value,
            createdDate: DateTime.now(),
            dueDate: DateTime.now()
                .add(Duration(days: int.parse(feesDueContoller.text.trim()))));

        await fetchInitalClassFee(selectedClassList[i].courseId)
            .then((value) async {
          feesDetail.fees = classinitalFee.value;

          await server
              .collection('DrivingSchoolCollection')
              .doc(UserCredentialsController.schoolId)
              .collection('Courses')
              .doc(selectedClassList[i].courseId)
              .collection("ClassFees")
              .doc(selectedFeeMonthContoller.text.trim())
              .set({'docid': selectedFeeMonthContoller.text.trim()}).then(
                  (value) async {
            await server
                .collection('DrivingSchoolCollection')
                .doc(UserCredentialsController.schoolId)
                .collection('Courses')
                .doc(selectedClassList[i].courseId)
                .collection("ClassFees")
                .doc(selectedFeeMonthContoller.text.trim())
                .collection('StudentsFees')
                .doc(docid)
                .set(feesDetail.toMap());
          }).then((value) async {
            await feesCollection(
                    data: feesDetail,
                    feeDocid: docid,
                    docid: selectedFeeMonthContoller.text.trim())
                .then((value) async {
              await getStudentClassWiseCount(
                  selectedClassList[i].courseId,
                  selectedFeeMonthContoller.text.trim(),
                  classinitalFee.value,
                  docid);
            });
          });
        });
      }
      feestypeNameContoller.clear();
      feesContoller.clear();
             selectAllClass.value=false;
            selectedClassList.clear();
      feesDueContoller.clear();
      seletedFeeDateContoller.clear();
      selectedFeeMonthContoller.clear();
      buttonstate.value = ButtonState.success;
      await Future.delayed(const Duration(seconds: 2)).then((vazlue) {
        buttonstate.value = ButtonState.idle;
      });
      Get.back();
      Get.back();
      selectedClassList.clear();
      allClassList.clear();

      showToast(msg: 'Fees Genrated Completed');
    } catch (e) {
      showToast(msg: 'Somthing went wrong please try again');
      buttonstate.value = ButtonState.fail;
      await Future.delayed(const Duration(seconds: 2)).then((value) {
        buttonstate.value = ButtonState.idle;
      });
      if (kDebugMode) {
         print('Error in addFessAsignToClass(): $e');
      }
    }
  }

  TextEditingController seletedFeeDateContoller = TextEditingController();
  TextEditingController selectedFeeMonthContoller = TextEditingController();
  final Rxn<DateTime> _selectedFeeDate = Rxn<DateTime>();
  final Rxn<DateTime> _selectedMonth = Rxn<DateTime>();
  selectMonth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedMonth.value ?? DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
      // builder: (context, child) {},
    );
    if (picked != null) {
      _selectedMonth.value = picked;
      DateTime parseDate = DateTime.parse(_selectedMonth.value.toString());
      final DateFormat formatter = DateFormat('dd-MM-yyyy');
      String formatted = formatter.format(parseDate);

      selectedFeeMonthContoller.text = formatted.toString();
    }
  }

  selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedFeeDate.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      _selectedFeeDate.value = picked;
      DateTime parseDate = DateTime.parse(_selectedFeeDate.value.toString());
      final DateFormat formatter = DateFormat('dd-MM-yyyy');
      String formatted = formatter.format(parseDate);

      seletedFeeDateContoller.text = formatted.toString();
    }
  }

  Future<void> feesCollection(
      {required ClassFeesModel data,
      required String docid,
      required String feeDocid}) async {
    await server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('FeesCollection')
        .doc(docid)
        .set({'docid': docid}, SetOptions(merge: true));
    await server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('FeesCollection')
        .doc(docid)
        .collection(docid)
        .doc(feeDocid)
        .set(data.toMap(), SetOptions(merge: true));
  }

  Future<void> getStudentClassWiseCount(String courseDocID,
      String feeCollectionID, int fee, String dataDocID) async {
        studentData.clear();

  try {
    // Fetch the course name
    DocumentSnapshot courseDoc = await server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('Courses')
        .doc(courseDocID)
        .get();
        
    if (!courseDoc.exists) {
      throw Exception("Course document does not exist");
    }
     
    final courseData = courseDoc.data() as Map<String, dynamic>;
    final courseName = courseData['courseName'] ?? 'Unknown Course';

    await server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('Courses')
        .doc(courseDocID)
        .collection('Students')
        .get()
        .then((value) async {
                  final list =
            value.docs.map((e) => StudentModel.fromMap(e.data())).toList();
        studentData.addAll(list);
      for (var i = 0; i < value.docs.length; i++) {
        //print('Student names ${value.docs[i].data()['studentemail']}');
       final studentDataMap = value.docs[i].data();
      final courseID = studentDataMap['courseID']??"" ;
      log("MaPPPPPPPPP$studentDataMap");
    

        await server
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection('FeesCollection')
            .doc(feeCollectionID)
            .collection(feeCollectionID)
            .doc(dataDocID)
            .collection('Students')
            .doc(studentData[i].docid)
            .set({
          'docid': studentData[i].docid,
          'StudentName': studentData[i].studentName,
          'fee': fee,
          'feepaid': false,
          'courseID': courseID,
            'courseName': courseName, 
          'paid': 0,
          'editFee': false,
        }, SetOptions(merge: true));
      }
    }).then((value) async {
      await getFeeTotalAmount(feeCollectionID, fee, dataDocID);
    });
      } catch (e) {
    log("Error: $e");
  }
  }

  Future<void> getFeeTotalAmount(
    String feeCollectionID,
    int fee,
    String dateDocID,
  ) async {
    await server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('FeesCollection')
        .doc(feeCollectionID)
        .collection(feeCollectionID)
        .doc(dateDocID)
        .collection('Students')
        .get()
        .then((value) async {
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('FeesCollection')
          .doc(feeCollectionID)
          .collection(feeCollectionID)
          .doc(dateDocID)
          .set({
        'totalStudents': value.docs.length,
        'totalAmount': fee * value.docs.length,
        'collectedAmount': 0,
        'pendingAmount': 0,
      }, SetOptions(merge: true));
    });
  }

  RxList feeMonthList = [].obs;
  RxList feeDateList = [].obs;

  RxString feeMonthDatadowpdown = 'd'.obs;
  RxString feeMonthData = 'd'.obs;
  RxString feeDateData = 'd'.obs;
  RxString feetypeName = ''.obs;
  RxString feeDueDateName = ''.obs;
  RxBool feessendingMessage = false.obs;

  Future<List> fetchFeeMonthData() async {
    await server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('FeesCollection')
        .get()
        .then((value) async {
      for (var i = 0; i < value.docs.length; i++) {
        feeMonthList.add(value.docs[i]['docid']);
      }
    });
    return feeMonthList;
  }

  Future<List> fetchFeeDateData() async {
    await server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('FeesCollection')
        .doc(feeMonthData.value)
        .collection(feeMonthData.value)
        .get()
        .then((value) async {
      for (var i = 0; i < value.docs.length; i++) {
        feeDateList.add(value.docs[i]['docid']);
      }
    });
    return feeDateList;
  }

  pendingAmountCalculate(String dateDocID) async {
    int paidFee = 0;

    int studenttotalAmount = 0;

    await server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('FeesCollection')
        .doc(feeMonthData.value)
        .collection(feeMonthData.value)
        .doc(dateDocID)
        .collection('Students')
        .get()
        .then((value) async {
      for (var i = 0; i < value.docs.length; i++) {
        final int totaladdesult = value.docs[i].data()['paid'];

        studenttotalAmount = studenttotalAmount + totaladdesult;
      }

      paidFee = studenttotalAmount;
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('FeesCollection')
          .doc(feeMonthData.value)
          .collection(feeMonthData.value)
          .doc(dateDocID)
          .get()
          .then((value) async {
        int totalAmount = value.data()?['totalAmount'] ?? 0;
        int result = totalAmount - paidFee;

        await server
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection('FeesCollection')
            .doc(feeMonthData.value)
            .collection(feeMonthData.value)
            .doc(dateDocID)
            .update({'pendingAmount': result});
      });

      // .update({'totalAmount': totalResult.value});
    });
  }

  int initialFeeResult = 0;
  int totalResult = 0;

  bugCalculateTotalamount(String dateDocID, int totalStudent) async {
    int totalAmount = 0;
    await server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('FeesCollection')
        .doc(feeMonthData.value)
        .collection(feeMonthData.value)
        .doc(dateDocID)
        .collection('Students')
        .get()
        .then((value) async {
      for (var i = 0; i < value.docs.length; i++) {
        final int totaladdesult = value.docs[i].data()['fee'];

        totalAmount = totalAmount + totaladdesult;
      }

      totalResult = totalAmount;

      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('FeesCollection')
          .doc(feeMonthData.value)
          .collection(feeMonthData.value)
          .doc(dateDocID)
          .update({'totalAmount': totalResult});
    });
  }

  collectedAmountCalculate(String dateDocID) async {
    int collectedFee = 0;

    int totalAmount = 0;

    await server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('FeesCollection')
        .doc(feeMonthData.value)
        .collection(feeMonthData.value)
        .doc(dateDocID)
        .collection('Students')
        .get()
        .then((value) async {
      for (var i = 0; i < value.docs.length; i++) {
        final int totaladdesult = value.docs[i].data()['paid'];

        totalAmount = totalAmount + totaladdesult;
      }

      collectedFee = totalAmount;
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('FeesCollection')
          .doc(feeMonthData.value)
          .collection(feeMonthData.value)
          .doc(dateDocID)
          .get()
          .then((value) async {
        await server
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection('FeesCollection')
            .doc(feeMonthData.value)
            .collection(feeMonthData.value)
            .doc(dateDocID)
            .update({'collectedAmount': collectedFee});
      });

      // .update({'totalAmount': totalResult.value});
    });
  }

  RxString currentStudentFee = ''.obs;
  RxBool sendMessageForUnPaidStudentandParentsbool = false.obs;
  Future<void> sendMessageForUnPaidStudentandParents() async {
    await server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('FeesCollection')
        .doc(feeMonthData.value)
        .collection(feeMonthData.value)
        .doc(feeDateData.value)
        .collection('Students')
        .get()
        .then((value) async {
      showToast(msg: "Please wait while a sec ...");
      for (var i = 0; i < value.docs.length; i++) {
        int studentFee = value.docs[i]['fee'];
        if (value.docs[i]['feepaid'] == false) {
          server
              .collection('DrivingSchoolCollection')
              .doc(UserCredentialsController.schoolId)
              .collection('AllStudents')
              .doc(value.docs[i]['docid'])
              .get()
              .then((value) async {

          });
        }
      }
    }).then((value) {
      showToast(msg: "Notification Sended !!");
      sendMessageForUnPaidStudentandParentsbool.value = false;
    });
  }
}