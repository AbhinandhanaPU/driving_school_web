import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:new_project_driving/constant/const.dart';
import 'package:new_project_driving/model/notification_model/notification_model.dart';
import 'package:new_project_driving/model/userDeviceModel/userDeviceModel.dart';
import 'package:new_project_driving/utils/firebase/firebase.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:uuid/uuid.dart';

class NotificationController extends GetxController {
  TextEditingController headingController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  Rx<ButtonState> buttonstate = ButtonState.idle.obs;
  final formKey = GlobalKey<FormState>();
  RxBool selectStudent = false.obs;
  RxBool selectTeacher = false.obs;

  
  Future<void> sendNotificationSelectedUsers(
      {required IconData icon,
      required Color whiteshadeColor,
      required Color containerColor}) async {
    try {

      final uuid = const Uuid().v1();
      NotificationModel messageDetails = NotificationModel(
          dateTime: DateTime.now().toString(),
          docid: uuid,
          open: false,
          icon: icon,
          messageText: messageController.text,
          headerText: headingController.text,
          whiteshadeColor: whiteshadeColor,
          containerColor: containerColor);
      for (var i = 0; i < selectedUSerUIDList.length; i++) {
        await server
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection('AllUsersDeviceID')
            .doc(selectedUSerUIDList[i].docId)
            .set({'message': true,'docid':selectedUSerUIDList[i].docId}, SetOptions(merge: true)).then(
                (value) async {
          await server
              .collection('DrivingSchoolCollection')
              .doc(UserCredentialsController.schoolId)
              .collection('AllUsersDeviceID')
              .doc(selectedUSerUIDList[i].docId)
              .get()
              .then((value) async {
            await sendPushMessage(selectedUSerUIDList[i].devideID,
                messageController.text, headingController.text);
          }).then((value) async {
            await server
                .collection('DrivingSchoolCollection')
                .doc(UserCredentialsController.schoolId)
                .collection('AllUsersDeviceID')
                .doc(selectedUSerUIDList[i].docId)
                .collection("Notification_Message")
                .doc(uuid)
                .set(messageDetails.toMap());
          });
        });
      }

      buttonstate.value = ButtonState.success;
      await Future.delayed(const Duration(seconds: 2)).then((vazlue) {
        buttonstate.value = ButtonState.idle;
      });
    } catch (e) {
      showToast(msg: 'Somthing went wrong please try again');
      buttonstate.value = ButtonState.fail;
      await Future.delayed(const Duration(seconds: 2)).then((value) {
        buttonstate.value = ButtonState.idle;
      });
      if (kDebugMode) {
        log(e.toString());
      }
    }
  }

  List<UserDeviceIDModel> selectedUSerUIDList = [];// fetchUsersID 
  Future<void> fetchUsersID({required String role}) async {
    log('fetchStudentID');
    await server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('AllUsersDeviceID')
        .get()
        .then((usersvalue) async {
      for (var i = 0; i < usersvalue.docs.length; i++) {
        if (usersvalue.docs[i].data()['userRole'] == role) {
          final list = usersvalue.docs
              .map((e) => UserDeviceIDModel.fromMap(e.data()))
              .toList();
          selectedUSerUIDList.add(list[i]);
        }
      }
    });
  }
    Future<void> sendPushMessage(String token, String body, String title) async {
   await  getPushNotification();
    final serverKey = pushNotficationKey.value;
    final Uri url = Uri.parse(
        'https://fcm.googleapis.com/v1/projects/driving-school-6e78e/messages:send');

    final Map<String, dynamic> message = {
      'message': {
        'token': token,
        'notification': {
          'title': title,
          'body': body,
        },
        'android': {
          'notification': {
            'title': title,
            'body': body,
            'click_action': 'TOP_STORY_ACTIVITY'
          },
          'data': {'story_id': 'story_12345'}
        },
        'apns': {
          'payload': {
            'aps': {'category': 'NEW_MESSAGE_CATEGORY'}
          },
        },
        'data': {
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'status': 'done',
          'body': body,
          'title': title,
        },
      },
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $serverKey',
        },
        body: jsonEncode(message),
      );

      if (response.statusCode == 200) {
        print('Notification sent successfully!');
      } else {
        print('Failed to send notification: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Exception caught sending notification: $e');
    }
  } 
    RxString pushNotficationKey = ''.obs;
  getPushNotification() async {
    FirebaseFirestore.instance
        .collection('PushNotification')
        .doc('key')
        .get()
        .then((value) async {
      pushNotficationKey.value = value.data()?['key'];
    });
  }
}

class InfoNotification {
  Color whiteshadeColor = const Color.fromARGB(255, 63, 162, 232);
  Color containerColor = const Color.fromARGB(255, 4, 130, 225);
  IconData icon = Icons.warning_rounded;
}
