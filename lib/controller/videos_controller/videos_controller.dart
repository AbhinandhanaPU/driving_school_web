import 'dart:developer';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/constant/const.dart';
import 'package:new_project_driving/utils/firebase/firebase.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';
import 'package:uuid/uuid.dart';

class VideosController extends GetxController {
  final formKey = GlobalKey<FormState>();

  TextEditingController videoTitleController = TextEditingController();
  TextEditingController videoDesController = TextEditingController();
  TextEditingController videoCateController = TextEditingController();

  TextEditingController videoEditTitleController = TextEditingController();
  TextEditingController videoEditDesController = TextEditingController();
  TextEditingController videoEditCateController = TextEditingController();

  RxBool isLoading = RxBool(false);
  Uuid uuid = const Uuid();
  String downloadUrl = '';
  final progressData = RxDouble(0.0);
  Rxn<Uint8List> fileBytes = Rxn<Uint8List>();
  RxString fileName = "".obs;

  Future<void> uploadToFirebase() async {
    try {
      isLoading.value = true;

      if (fileBytes.value == null) {
        throw Exception('No file selected');
      }

      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child("files/videos/${uuid.v1()}_${fileName.value}")
          .putData(fileBytes.value!);

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        final progress = snapshot.bytesTransferred / snapshot.totalBytes;
        progressData.value = progress;
      });

      final taskSnapshot = await uploadTask;
      downloadUrl = await taskSnapshot.ref.getDownloadURL();
      log('downloadUrl: $downloadUrl');

      String uid = uuid.v1();
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Videos')
          .doc(uid)
          .set({
        'videoTitle': videoTitleController.text,
        'videoDes': videoDesController.text,
        'videoCategory': videoCateController.text,
        'downloadUrl': downloadUrl,
        'fileName': fileName.value,
        'docId': uid,
      }).then((value) {
        fileBytes.value = null;
        fileName.value = '';
        videoTitleController.clear();
        videoDesController.clear();
        videoCateController.clear();
        showToast(msg: "Uploaded Successfully");
        log("Uploaded Successfully");
        Get.back();
      });

      isLoading.value = false;
    } catch (e) {
      log(e.toString(), name: "VideosController");
      showToast(msg: "Something Went Wrong");
      isLoading.value = false;
    }
  }

  Future<void> deletevideo({required String docId}) async {
    try {
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Videos')
          .doc(docId)
          .delete()
          .then((value) {
        showToast(msg: "Deleted Successfully");
        log("Deleted Successfully");
        Get.back();
      });
    } catch (e) {
      log(e.toString(), name: "VideosController");
    }
  }

  Future<void> updateVideo(String docId, BuildContext context) async {
    try {
      server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Videos')
          .doc(docId)
          .update({
            'videoTitle': videoEditTitleController.text,
            'videoDes': videoEditDesController.text,
            'videoCategory': videoEditCateController.text,
          })
          .then((value) {
            videoEditTitleController.clear();
            videoEditDesController.clear();
            videoEditCateController.clear();
          })
          .then((value) => Navigator.pop(context))
          .then((value) => showToast(msg: 'Videos Updated!'));
    } catch (e) {
      showToast(msg: 'Videos  Updation failed.Try Again');
      log("Videos Updation failed $e");
    }
  }
}
