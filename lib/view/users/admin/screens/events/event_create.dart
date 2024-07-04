import 'package:awesome_side_sheet/Enums/sheet_position.dart';
import 'package:awesome_side_sheet/side_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/constant/constant.validate.dart';
import 'package:new_project_driving/controller/event_controller/event_controller.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/view/widget/progess_button/progress_button.dart';
import 'package:new_project_driving/view/widget/responsive/responsive.dart';
import 'package:new_project_driving/view/widget/text_formfiled_container/textformfiled_blue_container.dart';

createEventAdmin(BuildContext context) {
  final EventController eventController = Get.put(EventController());
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
                    text: 'Events',
                    fontsize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              SizedBox(
                height: 800,
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Form(
                    key: eventController.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 10, right: 10),
                          child: TextFormFiledHeightnoColor(
                            width: ResponsiveWebSite.isMobile(context)
                                ? double.infinity
                                : 500,
                            validator: checkFieldEmpty,
                            controller: eventController.eventnameController,
                            title: 'Event Name',
                            hintText: 'Event Name',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 10, right: 10),
                          child: TextFormFiledHeightnoColor(
                            onTap: () async {
                              eventController.eventdateController.text =
                                  await dateTimePicker(context);
                            },
                            width: ResponsiveWebSite.isMobile(context)
                                ? double.infinity
                                : 500,
                            validator: checkFieldDateIsValid,
                            controller: eventController.eventdateController,
                            title: 'Date',
                            hintText: 'Date',
                          ),
                        ), ////////////////////////////////////////////////////////1
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 10, right: 10),
                          child: TextFormFiledHeightnoColor(
                            width: ResponsiveWebSite.isMobile(context)
                                ? double.infinity
                                : 500,
                            validator: checkFieldEmpty,
                            controller: eventController.eventvenueController,
                            title: 'Venue',
                            hintText: 'Venue',
                          ),
                        ), ///////////////////////////////////////////////2
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 10, right: 10),
                          child: TextFormFiledHeightnoColor(
                            width: ResponsiveWebSite.isMobile(context)
                                ? double.infinity
                                : 500,
                            validator: checkFieldEmpty,
                            controller:
                                eventController.eventdescriptionController,
                            title: 'Description',
                            hintText: 'Description',
                          ),
                        ), ////////////////////////////////////3
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 10, right: 10),
                          child: TextFormFiledHeightnoColor(
                            width: ResponsiveWebSite.isMobile(context)
                                ? double.infinity
                                : 500,
                            validator: checkFieldEmpty,
                            controller: eventController.eventsignedByController,
                            title: 'Signed by',
                            hintText: 'Signed by',
                          ),
                        ), ////////////////////////////////////4
                        Padding(
                          padding: const EdgeInsets.only(top: 25, bottom: 10),
                          child: Center(
                            child: Obx(
                              () => ProgressButtonWidget(
                                  function: () async {
                                    if (eventController.formKey.currentState!
                                        .validate()) {
                                      eventController.createEvent().then(
                                          (value) => Navigator.pop(context));
                                    }
                                  },
                                  buttonstate:
                                      eventController.buttonstate.value,
                                  text: 'Create Event'),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      showCloseButton: false,
      footer: Container());
}
