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
import 'package:new_project_driving/controller/videos_controller/videos_controller.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/view/widget/button_container_widget/button_container_widget.dart';
import 'package:new_project_driving/view/widget/text_formfiled_container/textformfiled_blue_container.dart';

uploadVideos(BuildContext context) {
  final VideosController videosController = Get.put(VideosController());
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
                  text: 'Videos',
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
                    key: videosController.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 5, left: 10, right: 10),
                          child: TextFontWidget(
                              text: 'Video upload *', fontsize: 12.5),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5, left: 10, right: 10),
                          child: VideosUploadWidget(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5, left: 10, right: 10),
                          child: TextFormFiledHeightnoColor(
                            width: 500,
                            controller: videosController.videoTitleController,
                            validator: checkFieldEmpty,
                            title: 'Video Title',
                            hintText: 'Video Title',
                            /////////////////////////////////////////0
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5, left: 10, right: 10),
                          child: TextFormFiledHeightnoColor(
                            width: 500,
                            validator: checkFieldEmpty,
                            controller: videosController.videoDesController,
                            title: 'Video Description',
                            hintText: 'Video Description',
                          ),
                        ), ///////////////////////////////////////////////3
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5, left: 10, right: 10),
                          child: TextFormFiledHeightnoColor(
                            width: 500,
                            validator: checkFieldEmpty,
                            controller: videosController.videoCateController,
                            title: 'Video Category',
                            hintText: 'Video Category',
                          ),
                        ), ///////////////////////////////////////////////3
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (videosController.formKey.currentState?.validate() ??
                          false) {
                        if (videosController.fileBytes.value != null) {
                          videosController.uploadToFirebase();
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
                            if (videosController.isLoading.value) {
                              final progress =
                                  (videosController.progressData.value * 100)
                                      .toInt();
                              return Stack(
                                alignment: Alignment.center,
                                children: [
                                  Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          videosController.progressData.value,
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
                                  text: 'Upload Video',
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

class VideosUploadWidget extends StatelessWidget {
  VideosUploadWidget({
    super.key,
  });

  final VideosController _videosController = Get.put(VideosController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        try {
          FilePickerResult? result = await FilePicker.platform.pickFiles(
              allowedExtensions: ['mkv', 'mp4', 'mov', 'avi'],
              type: FileType.custom,
              allowCompression: true);

          if (result != null) {
            _videosController.fileBytes.value = result.files.single.bytes;
            _videosController.fileName.value = result.files.single.name;
          } else {
            log('No file selected', name: "VideosController");
          }
        } catch (e) {
          log(e.toString(), name: "VideosControllerr");
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
                  String textData = _videosController.fileName.value == ""
                      ? 'Upload file here'
                      : _videosController.fileName.value;
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
