import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/colors/notification_color/notification_color_widget.dart';
import 'package:new_project_driving/constant/const.dart';
import 'package:new_project_driving/constant/constant.validate.dart';
import 'package:new_project_driving/controller/notification_controller/notification_controller.dart';
import 'package:new_project_driving/view/widget/blue_container_widget/blue_container_widget.dart';
import 'package:new_project_driving/view/widget/progess_button/progress_button.dart';
import 'package:new_project_driving/view/widget/responsive/responsive.dart';

class AdminNotificationCreate extends StatelessWidget {
  final NotificationController notificationCntrl =
      Get.put(NotificationController());
  AdminNotificationCreate({super.key});

  @override
  Widget build(BuildContext context) {
    final adminSendNotificationWidgets = [
      Text(
        "Send Notifications",
        style: TextStyle(
            fontSize: ResponsiveWebSite.isMobile(context) ? 15 : 17,
            fontWeight: FontWeight.bold),
      ), ////////////////////////////..................0
      SizedBox(
        width: ResponsiveWebSite.isMobile(context) ? 60 : 80,
        child: Text(
          "Category",
          style: TextStyle(
              fontSize: ResponsiveWebSite.isMobile(context) ? 13 : 15,
              fontWeight: FontWeight.bold),
        ),
      ), //////////////////////////......................1
      Obx(
        () => Row(
          children: [
            BlueContainerWidget(
                title: "Students",
                fontSize: 12,
                color: themeColorBlue,
                width: 150),
            notificationCntrl.selectStudent.value == false
                ? Checkbox(
                    value: notificationCntrl.selectStudent.value,
                    onChanged: (value) {
                      notificationCntrl.selectStudent.value = true;
                    },
                    checkColor: cWhite,
                    activeColor: cgreen,
                  )
                : Checkbox(
                    value: notificationCntrl.selectStudent.value,
                    onChanged: (value) {
                      notificationCntrl.selectStudent.value = false;
                    },
                    checkColor: cWhite,
                    activeColor: cgreen,
                  ),
            BlueContainerWidget(
                title: "Teachers",
                fontSize: 12,
                color: themeColorBlue,
                width: 150),
            notificationCntrl.selectTeacher.value == false
                ? Checkbox(
                    value: notificationCntrl.selectTeacher.value,
                    onChanged: (value) {
                      notificationCntrl.selectTeacher.value = true;
                    },
                    checkColor: cWhite,
                    activeColor: cgreen,
                  )
                : Checkbox(
                    value: notificationCntrl.selectTeacher.value,
                    onChanged: (value) {
                      notificationCntrl.selectTeacher.value = false;
                    },
                    checkColor: cWhite,
                    activeColor: cgreen,
                  )
          ],
        ),
      ),
      ///////////////////////////////////////..........................2
      SizedBox(
        width: ResponsiveWebSite.isMobile(context) ? 60 : 80,
        child: Text(
          "Heading",
          style: TextStyle(
              fontSize: ResponsiveWebSite.isMobile(context) ? 13 : 15,
              fontWeight: FontWeight.bold),
        ),
      ),
      ///////////////////////////////////////..........................3
      SizedBox(
        width: ResponsiveWebSite.isMobile(context) ? 80 : 150,
        child: TextFormField(
          validator: checkFieldEmpty,
          controller: notificationCntrl.headingController,
          maxLines: 1,
          style: const TextStyle(fontSize: 14),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: ' Enter Messages',
            contentPadding: EdgeInsets.only(top: 5, bottom: 5),
          ),
        ),
      ),
      ///////////////////////////////////////..........................4
      SizedBox(
        width: ResponsiveWebSite.isMobile(context) ? 60 : 80,
        child: Text(
          "Content",
          style: TextStyle(
              fontSize: ResponsiveWebSite.isMobile(context) ? 13 : 15,
              fontWeight: FontWeight.bold),
        ),
      ),
      ///////////////////////////////////////..........................5
      SizedBox(
        width: ResponsiveWebSite.isMobile(context) ? 80 : 150,
        child: TextFormField(
          validator: checkFieldEmpty,
          controller: notificationCntrl.messageController,
          maxLines: 10,
          style: const TextStyle(fontSize: 14),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: ' Enter Messages',
            contentPadding: EdgeInsets.only(top: 5, bottom: 5),
          ),
        ),
      ),
      ///////////////////////////////////////..........................6
      SizedBox(
        height: 40,
        width: 180,
        child: Obx(
          () => ProgressButtonWidget(
              function: () async {
                if (notificationCntrl.selectStudent.value == true ||
                    notificationCntrl.selectTeacher.value == true) {
                  notificationCntrl.selectedUSerUIDList.clear();
                  if (notificationCntrl.formKey.currentState!.validate()) {
                    Future<void> sendNotificationsForRole(String role) async {
                      await notificationCntrl.fetchUsersID(role: role);
                      await notificationCntrl
                          .sendNotificationSelectedUsers(
                        icon: Icons.warning_rounded,
                        whiteshadeColor: InfoNotifierSetup().whiteshadeColor,
                        containerColor: InfoNotifierSetup().containerColor,
                      )
                          .then((value) {
                        notificationCntrl.headingController.clear();
                        notificationCntrl.messageController.clear();
                      });
                    }

                    if (notificationCntrl.selectStudent.value &&
                        notificationCntrl.selectTeacher.value) {
                      // Fetch and send notifications for both students and teachers
                      await sendNotificationsForRole('student');
                      await sendNotificationsForRole('teacher');
                    } else if (notificationCntrl.selectStudent.value) {
                      // Fetch and send notifications for students only
                      await sendNotificationsForRole('student');
                    } else if (notificationCntrl.selectTeacher.value) {
                      // Fetch and send notifications for teachers only
                      await sendNotificationsForRole('teacher');
                    }
                  }
                } else {
                  showToast(msg: 'Select any user type');
                }
              },
              buttonstate: notificationCntrl.buttonstate.value,
              text: 'Send Message'),
        ),
      ),
      //////////////////////////////////............................7
      Obx(
        () => Column(
          children: [
            Row(
              children: [
                BlueContainerWidget(
                    title: "Students",
                    fontSize: 12,
                    color: themeColorBlue,
                    width: 150),
                notificationCntrl.selectStudent.value == false
                    ? Checkbox(
                        value: notificationCntrl.selectStudent.value,
                        onChanged: (value) {
                          notificationCntrl.selectStudent.value = true;
                        },
                        checkColor: cWhite,
                        activeColor: cgreen,
                      )
                    : Checkbox(
                        value: notificationCntrl.selectStudent.value,
                        onChanged: (value) {
                          notificationCntrl.selectStudent.value = false;
                        },
                        checkColor: cWhite,
                        activeColor: cgreen,
                      ),
              ],
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                BlueContainerWidget(
                    title: "Teachers",
                    fontSize: 12,
                    color: themeColorBlue,
                    width: 150),
                notificationCntrl.selectTeacher.value == false
                    ? Checkbox(
                        value: notificationCntrl.selectTeacher.value,
                        onChanged: (value) {
                          notificationCntrl.selectTeacher.value = true;
                        },
                        checkColor: cWhite,
                        activeColor: cgreen,
                      )
                    : Checkbox(
                        value: notificationCntrl.selectTeacher.value,
                        onChanged: (value) {
                          notificationCntrl.selectTeacher.value = false;
                        },
                        checkColor: cWhite,
                        activeColor: cgreen,
                      ),
              ],
            )
          ],
        ),
      ),
      ///////////////////////////////////////..........................8 category mobile view
    ];

    return SafeArea(
      child: SingleChildScrollView(
        child: ResponsiveWebSite.isMobile(context)
            ? Form(
                key: notificationCntrl.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 50,
                      color: screenContainerbackgroundColor,
                      child: Padding(
                          padding: const EdgeInsets.only(top: 10, left: 20),
                          child: adminSendNotificationWidgets[0]
                          ///////////////////....................Send Notifications
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 20, left: 20, right: 10),
                              child: adminSendNotificationWidgets[1]
                              ////////////////............category
                              ),
                          Expanded(
                            child: Container(
                                padding: const EdgeInsets.only(right: 10),
                                color: cWhite,
                                child: adminSendNotificationWidgets[8]
                                ///////////////////////...............category select
                                ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: cWhite,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 20, left: 20, right: 10),
                                  child: adminSendNotificationWidgets[3],
                                  /////////////////.....................heading
                                ),
                                Expanded(
                                  child: Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: adminSendNotificationWidgets[4]
                                      ///////////////////.....................heading type
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: cWhite,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 20, left: 20, right: 10),
                                  child: adminSendNotificationWidgets[5],
                                  /////////////////.....................Content
                                ),
                                Expanded(
                                  child: Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: adminSendNotificationWidgets[6]
                                      ///////////////////.....................Content type
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15, top: 25),
                      child: Center(
                        child: adminSendNotificationWidgets[7],
                      ), ///////////////////////.................submit button
                    ),
                  ],
                ),
              )
            ////////////////////////////////////////////////////............................................mobile view
            : Form(
                key: notificationCntrl.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 29),
                      child: Container(
                          width: double.infinity,
                          height: 48,
                          color: screenContainerbackgroundColor,
                          child: Padding(
                              padding: const EdgeInsets.only(top: 10, left: 25),
                              child: adminSendNotificationWidgets[
                                  0] ///////////////////....................Send Notifications
                              )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 20, left: 20, right: 10),
                              child: adminSendNotificationWidgets[1]
                              ////////////////............Category
                              ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Container(
                                  width: 200,
                                  color: cWhite,
                                  child: adminSendNotificationWidgets[2]
                                  ///////////////////////...............Category select
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: cWhite,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 20, left: 20, right: 10),
                                  child: adminSendNotificationWidgets[3],
                                  /////////////////.....................heading
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: adminSendNotificationWidgets[4]
                                      ///////////////////..................heading Text
                                      ),
                                ),
                                Expanded(flex: 1, child: Container()),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: cWhite,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 20, left: 20, right: 10),
                                  child: adminSendNotificationWidgets[5],
                                  /////////////////.....................Content
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: adminSendNotificationWidgets[6]
                                      ///////////////////..................Content Text
                                      ),
                                ),
                                Expanded(flex: 1, child: Container()),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, bottom: 15, top: 30),
                      child: Container(
                        child: adminSendNotificationWidgets[7],
                      ), ///////////////////////.................submit button
                    ),
                  ],
                ),
              ),
      ), /////////////////////////////////////////////////////////.......................................web view
    );
  }
}
