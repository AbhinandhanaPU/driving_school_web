// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:awesome_side_sheet/Enums/sheet_position.dart';
import 'package:awesome_side_sheet/side_sheet.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/constant/const.dart';
import 'package:new_project_driving/constant/constant.validate.dart';
import 'package:new_project_driving/controller/study_materials/study_materials_controller.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/view/widget/button_container_widget/button_container_widget.dart';
import 'package:new_project_driving/view/widget/text_formfiled_container/textformfiled_blue_container.dart';

uploadStudyMaterials(BuildContext context) {
  final StudyMaterialsController studyMaterialsController =
      Get.put(StudyMaterialsController());
  aweSideSheet(
    context: context,
    sheetPosition: SheetPosition.right,
    header: Container(),
    body: Padding(
      padding: const EdgeInsets.only(left: 10, top: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Row(
              children: [
                BackButton(),
                SizedBox(
                  width: 20,
                ),
                TextFontWidget(
                  text: 'Study Material',
                  fontsize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            Container(
              height: 900,
              width: 500,
              margin: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Form(
                    key: studyMaterialsController.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 5, left: 10, right: 10),
                          child: TextFontWidget(
                              text: 'Study Material upload *', fontsize: 12.5),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5, left: 10, right: 10),
                          child: StudyMaterialsUploadWidget(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5, left: 10, right: 10),
                          child: TextFormFiledHeightnoColor(
                            width: 500,
                            controller:
                                studyMaterialsController.videoTitleController,
                            validator: checkFieldEmpty,
                            title: 'Title',
                            hintText: 'Title',
                            /////////////////////////////////////////0
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5, left: 10, right: 10),
                          child: TextFormFiledHeightnoColor(
                            width: 500,
                            validator: checkFieldEmpty,
                            controller:
                                studyMaterialsController.videoDesController,
                            title: 'Description',
                            hintText: 'Description',
                          ),
                        ), ///////////////////////////////////////////////3
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5, left: 10, right: 10),
                          child: TextFormFiledHeightnoColor(
                            width: 500,
                            validator: checkFieldEmpty,
                            controller:
                                studyMaterialsController.videoCateController,
                            title: 'Category',
                            hintText: 'Category',
                          ),
                        ), ///////////////////////////////////////////////3
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (studyMaterialsController.formKey.currentState
                              ?.validate() ??
                          false) {
                        if (studyMaterialsController.fileBytes.value != null) {
                          studyMaterialsController.uploadToFirebase();
                        } else {
                          showToast(msg: "Please Select File");
                        }
                      }
                    },
                    child: ButtonContainerWidget(
                      curving: 30,
                      colorindex: 0,
                      height: 40,
                      width: 180,
                      child: Center(
                        child: Obx(
                          () {
                            if (studyMaterialsController.isLoading.value) {
                              final progress =
                                  (studyMaterialsController.progressData.value *
                                          100)
                                      .toInt();
                              return Stack(
                                alignment: Alignment.center,
                                children: [
                                  Center(
                                    child: CircularProgressIndicator(
                                      value: studyMaterialsController
                                          .progressData.value,
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  ),
                                  TextFontWidgetRouter(
                                    text: '$progress%',
                                    fontsize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: cWhite,
                                  ),
                                ],
                              );
                            } else {
                              return const Center(
                                child: TextFontWidgetRouter(
                                  text: 'Upload Study Material',
                                  fontsize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: cWhite,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
    showCloseButton: false,
    footer: Container(),
  );
}

class StudyMaterialsUploadWidget extends StatelessWidget {
  StudyMaterialsUploadWidget({
    super.key,
  });

  final StudyMaterialsController _studyMaterialsController =
      Get.put(StudyMaterialsController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        try {
          FilePickerResult? result =
              await FilePicker.platform.pickFiles(allowedExtensions: [
            'pdf',
            'txt',
            'doc',
            'docx',
            'jpg',
            'jpeg',
            'png',
          ], type: FileType.custom, allowCompression: true);

          if (result != null) {
            _studyMaterialsController.fileBytes.value =
                result.files.single.bytes;
            _studyMaterialsController.fileName.value = result.files.single.name;
          } else {
            log('No file selected', name: "StudyMaterials");
          }
        } catch (e) {
          log(e.toString(), name: "StudyMaterials");
        }
      },
      child: Container(
        height: 130.h,
        width: double.infinity - 20.w,
        decoration: BoxDecoration(
          border: Border.all(
            color: cBlue,
            width: 2.0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              child: Icon(Icons.attach_file_rounded,
                  color: cBlue, size: 30.w, weight: 10),
            ),
            FittedBox(
              child: Obx(
                () {
                  String textData =
                      _studyMaterialsController.fileName.value == ""
                          ? 'Upload file here'
                          : _studyMaterialsController.fileName.value;
                  return Text(
                    textData,
                    style: TextStyle(
                        fontSize: 12.h,
                        color: cBlue,
                        fontWeight: FontWeight.bold),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
