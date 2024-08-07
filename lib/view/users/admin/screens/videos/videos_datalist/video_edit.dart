import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/constant/constant.validate.dart';
import 'package:new_project_driving/controller/videos_controller/videos_controller.dart';
import 'package:new_project_driving/view/widget/custom_showdialouge/custom_showdialouge.dart';
import 'package:new_project_driving/view/widget/text_formfiled_container/textformfiled_blue_container.dart';

editFunctionOfVideo(BuildContext context, Map<String, dynamic> data) {
  final VideosController videosController = Get.put(VideosController());
  customShowDilogBox(
      context: context,
      title: 'Edit',
      children: [
        Form(
          key: videosController.formKey,
          child: Column(
            children: [
              TextFormFiledHeightnoColor(
                  validator: checkFieldEmpty,
                  controller: videosController.videoEditTitleController,
                  hintText: data['videoTitle'],
                  title: 'Title'),
              TextFormFiledHeightnoColor(
                  validator: checkFieldEmpty,
                  controller: videosController.videoEditDesController,
                  hintText: data['videoDes'],
                  title: 'Description'),
              TextFormFiledHeightnoColor(
                  validator: checkFieldEmpty,
                  controller: videosController.videoEditCateController,
                  hintText: data['videoCategory'],
                  title: 'Category'),
            ],
          ),
        ),
      ],
      doyouwantActionButton: true,
      actiononTapfuction: () {
        if (videosController.formKey.currentState!.validate()) {
          videosController.updateVideo(
            data['docId'],
            context,
          );
        }
      },
      actiontext: 'Update');
}
