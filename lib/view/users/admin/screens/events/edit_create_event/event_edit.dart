import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/constant/constant.validate.dart';
import 'package:new_project_driving/controller/event_controller/event_controller.dart';
import 'package:new_project_driving/model/event_model/events_model.dart';
import 'package:new_project_driving/view/widget/custom_showdialouge/custom_showdialouge.dart';
import 'package:new_project_driving/view/widget/text_formfiled_container/textformfiled_blue_container.dart';

editFunctionOfEvent(BuildContext context, EventModel data) {
  final EventController eventController = Get.put(EventController());
  customShowDilogBox(
      context: context,
      title: 'Edit',
      children: [
        Form(
          key: eventController.formKey,
          child: Column(
            children: [
              TextFormFiledHeightnoColor(
                  validator: checkFieldEmpty,
                  controller: eventController.editnameController,
                  hintText: data.eventName,
                  title: 'Event'),
              TextFormFiledHeightnoColor(
                  onTap: () async {
                    eventController.editeventdateController.text =
                        await dateTimePicker(context);
                  },
                  controller: eventController.editeventdateController,
                  hintText: data.eventDate,
                  validator: checkFieldDateIsValid,
                  title: 'Date'),
              TextFormFiledHeightnoColor(
                  controller: eventController.editvenueController,
                  hintText: data.venue,
                  validator: checkFieldEmpty,
                  title: 'Venue'),
              TextFormFiledHeightnoColor(
                  controller: eventController.editdescriptionController,
                  hintText: data.eventDescription,
                  validator: checkFieldEmpty,
                  title: 'Description'),
              TextFormFiledHeightnoColor(
                  controller: eventController.editsignedByController,
                  hintText: data.signedBy,
                  validator: checkFieldEmpty,
                  title: 'Signed by')
            ],
          ),
        ),
      ],
      doyouwantActionButton: true,
      actiononTapfuction: () {
        if (eventController.formKey.currentState!.validate()) {
          eventController.updateEvent(data.id, context);
        }
      },
      actiontext: 'Update');
}
