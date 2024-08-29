import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/constant/constant.validate.dart';
import 'package:new_project_driving/controller/fees_N_bills_Controller/fee_student_controller.dart';
import 'package:new_project_driving/controller/fees_N_bills_Controller/fees_bills_controller.dart';
import 'package:new_project_driving/controller/notification_controller/notification_controller.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/utils/firebase/firebase.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';
import 'package:new_project_driving/view/widget/button_container_widget/button_container_widget.dart';
import 'package:new_project_driving/view/widget/custom_showdialouge/custom_showdilog.dart';
import 'package:new_project_driving/view/widget/loading_widget/loading_widget.dart';
import 'package:new_project_driving/view/widget/notification_color/notification_color_widget.dart';
import 'package:new_project_driving/view/widget/responsive/responsive.dart';
import 'package:new_project_driving/view/widget/reusable_table_widgets/category_table_header.dart';
import 'package:new_project_driving/view/widget/reusable_table_widgets/data_container.dart';
import 'package:new_project_driving/view/widget/routeSelectedTextContainer/routeSelectedTextContainer.dart';
import 'package:new_project_driving/view/widget/routeSelectedTextContainer/route_NonSelectedContainer.dart';

class ClassWiseFeesStatus extends StatelessWidget {
  const ClassWiseFeesStatus({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: ResponsiveWebSite.isMobile(context)
            ? Axis.horizontal
            : Axis.vertical,
        child: Container(
          color: screenContainerbackgroundColor,
          height: 1000,
          width: ResponsiveWebSite.isDesktop(context) ? double.infinity : 1200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 25, top: 25),
                child: TextFontWidget(
                  text: 'Fee Details',
                  fontsize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 08,
                        right: 05,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Get.find<FeesAndBillsController>()
                              .ontapviewclasswiseFees
                              .value = false;
                        },
                        child:
                            const RouteNonSelectedTextContainer(title: 'Home'),
                      ),
                    ),
                    const RouteSelectedTextContainer(
                        width: 140, title: 'Fees Details'),
                    const Spacer(),
                    GestureDetector(
                      onTap: () async {
                        Get.find<FeesAndBillsController>()
                            .sendMessageForUnPaidStudentandParentsbool
                            .value = true;
                        await Get.find<FeesAndBillsController>()
                            .sendMessageForUnPaidStudentandParents();
                      },
                      child: Obx(() => Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Get.find<FeesAndBillsController>()
                                        .sendMessageForUnPaidStudentandParentsbool
                                        .value ==
                                    true
                                ? const SizedBox(
                                    child: CircularProgressIndicator.adaptive(),
                                  )
                                : ButtonContainerWidget(
                                    curving: 0,
                                    colorindex: 6,
                                    height: 35,
                                    width: 220,
                                    child: const Center(
                                      child: TextFontWidgetRouter(
                                        text:
                                            'Send Message For Unpaid Students',
                                        fontsize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: cWhite,
                                      ),
                                    )),
                          )),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: cWhite,
                  width: double.infinity,
                  height: ResponsiveWebSite.isMobile(context) ? 800 : 500,
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 20),
                        child: Container(
                          color: cWhite,
                          height: 40,
                          child: const Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: CatrgoryTableHeaderWidget(
                                      headerTitle: 'No')),
                              SizedBox(
                                width: 02,
                              ),
                              Expanded(
                                  flex: 4,
                                  child: CatrgoryTableHeaderWidget(
                                      headerTitle: 'Student Name')),
                              SizedBox(
                                width: 02,
                              ),
                              Expanded(
                                  flex: 2,
                                  child: CatrgoryTableHeaderWidget(
                                      headerTitle: 'Class')),
                              SizedBox(
                                width: 02,
                              ),
                              Expanded(
                                  flex: 2,
                                  child: CatrgoryTableHeaderWidget(
                                      headerTitle: 'Fee')),
                              SizedBox(
                                width: 02,
                              ),
                              Expanded(
                                  flex: 2,
                                  child: CatrgoryTableHeaderWidget(
                                      headerTitle: 'status')),
                              SizedBox(
                                width: 02,
                              ),
                              Expanded(
                                  flex: 2,
                                  child: CatrgoryTableHeaderWidget(
                                      headerTitle: 'Paid')),
                              SizedBox(
                                width: 02,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                          child: StreamBuilder(
                              stream: server
                                  .collection('DrivingSchoolCollection')
                                  .doc(UserCredentialsController.schoolId)
                                  .collection('FeesCollection')
                                  .doc(Get.find<FeesAndBillsController>()
                                      .feeMonthData
                                      .value)
                                  .collection(Get.find<FeesAndBillsController>()
                                      .feeMonthData
                                      .value)
                                  .doc(Get.find<FeesAndBillsController>()
                                      .feeDateData
                                      .value)
                                  .collection('Students')
                                  .orderBy(
                                    'feepaid',
                                  )
                                  .snapshots(),
                              builder: (context, snaps) {
                                if (snaps.hasData) {
                                  return ListView.separated(
                                      itemBuilder: (context, index) {
                                        final data =
                                            snaps.data!.docs[index].data();
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: ClassWiseFeesDataListContainer(
                                              studentFee: data['fee'],
                                              studentdata: data,
                                              index: index),
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return const SizedBox(
                                          height: 02,
                                        );
                                      },
                                      itemCount: snaps.data!.docs.length);
                                } else {
                                  return const LoadingWidget();
                                }
                              }))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ClassWiseFeesDataListContainer extends StatelessWidget {
  final Map<String, dynamic> studentdata;
  final int index;
  final int studentFee;
  ClassWiseFeesDataListContainer({
    required this.index,
    super.key,
    required this.studentdata,
    required this.studentFee,
  });

  final NotificationController notificationController =
      Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: studentdata['feepaid'] == false
          ? Colors.red.withOpacity(0.1)
          : Colors.green.withOpacity(0.1),
      height: 35,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: DataContainerWidget(
                rowMainAccess: MainAxisAlignment.center,
                // width: 150,
                index: index,
                headerTitle: '${index + 1}'), //....................No
          ),
          Container(
            color: cWhite,
            width: 02,
          ),
          Expanded(
            flex: 4,
            child: DataContainerWidget(
                rowMainAccess: MainAxisAlignment.start,
                index: index,
                headerTitle: "  ${studentdata['StudentName']}"),
          ), //................................................. Months
          Container(
            color: cWhite,
            width: 02,
          ),
          Expanded(
            flex: 2,
            child: DataContainerWidget(
                        rowMainAccess: MainAxisAlignment.center,
                        index: index,
                        headerTitle: " ${studentdata['courseName']}")
                 
                 
          ), //........................................... Subjects
          Container(
            color: cWhite,
            width: 02,
          ),
          Expanded(
            flex: 2,
            child: studentdata['editFee'] == true
                ? StudentFeesEditWidget(docid: studentdata['docid'])
                : Row(
                    children: [
                      DataContainerWidget(
                          rowMainAccess: MainAxisAlignment.center,
                          index: index,
                          headerTitle: " ${studentdata['fee']}"),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: IconButton(
                            onPressed: () async {
                              Get.find<StudentFeeController>()
                                  .feeEditController(
                                      studentdata['docid'], true);
                            },
                            icon: const Icon(
                              Icons.edit_outlined,
                              color: cgreen,
                              size: 20,
                            )),
                      )
                    ],
                  ),
          ), //....................................... Fess Collectes
          Container(
            color: cWhite,
            width: 02,
          ),
          Expanded(
            flex: 2,
            child: studentdata['feepaid'] == false
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // webassets\png\not_active.png
                      SizedBox(
                        width: 15,
                        child: Image.asset(
                          'webassets/png/not_active.png',
                        ),
                      ),
                      const TextFontWidget(
                        text: " Pending",
                        fontsize: 12,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 15,
                        child: Image.asset(
                          'webassets/png/active.png',
                        ),
                      ),
                      const TextFontWidget(
                        text: " Full Paid",
                        fontsize: 12,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
          ),
          Container(
            color: cWhite,
            width: 02,
          ),
          Expanded(
            flex: 2,
            child: studentdata['feepaid'] == false
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Get.find<FeesAndBillsController>()
                                        .feessendingMessage
                                        .value ==
                                    true
                                ? const SizedBox(
                                    height: 10,
                                    width: 10,
                                    child: CircularProgressIndicator.adaptive())
                                : IconButton(
                                    onPressed: () async {
                                      try {
                                        Get.find<FeesAndBillsController>()
                                            .feessendingMessage
                                            .value = true;
                                        await server
                                            .collection('DrivingSchoolCollection')
                                            .doc(UserCredentialsController
                                                .schoolId)
                                            .collection("Students")
                                            .doc(studentdata['docid'])
                                            .get()
                                            .then((value) async {
                                          await notificationController
                                              // .userparentNotification(
                                              //     parentID: value['parentId'],
                                              //     icon: SuccessNotifierSetup()
                                              //         .icon,
                                              //     messageText:
                                              //         'Your ${Get.find<FeesAndBillsController>().feetypeName.value} rupees $studentFee /- is paid successfully, Thank you 🙏. \n നിങ്ങളുടെ ${Get.find<FeesAndBillsController>().feetypeName.value} ആയ $studentFee /- രൂപ വിജയകരമായി അടച്ചിരിക്കുന്നു, നന്ദി 🙏',
                                              //     // ,
                                              //     headerText:
                                              //         "${Get.find<FeesAndBillsController>().feetypeName.value} Due Fee",
                                              //     whiteshadeColor:
                                              //         SuccessNotifierSetup()
                                              //             .whiteshadeColor,
                                              //     containerColor:
                                              //         SuccessNotifierSetup()
                                              //             .containerColor)
                                            //   .then((value) async {
                                            // await notificationController
                                                .userStudentNotification(
                                                    studentID:
                                                        studentdata['docid'],
                                                    icon: SuccessNotifierSetup()
                                                        .icon,
                                                    messageText:
                                                        'Your ${Get.find<FeesAndBillsController>().feetypeName.value} rupees $studentFee /- is paid successfully, Thank you 🙏. \n നിങ്ങളുടെ ${Get.find<FeesAndBillsController>().feetypeName.value} ആയ $studentFee /- രൂപ വിജയകരമായി അടച്ചിരിക്കുന്നു, നന്ദി 🙏',
                                                    // ,
                                                    headerText:
                                                        "${Get.find<FeesAndBillsController>().feetypeName.value} Due Fee",
                                                    whiteshadeColor:
                                                        SuccessNotifierSetup()
                                                            .whiteshadeColor,
                                                    containerColor:
                                                        SuccessNotifierSetup()
                                                            .containerColor);
                                          }).then((value) async {
                                            await Get.find<
                                                    StudentFeeController>()
                                                .updateStudentFeeStatus(
                                                    studentdata['docid'],
                                                    true,
                                                    studentdata['fee']);
                                            Get.find<FeesAndBillsController>()
                                                .feessendingMessage
                                                .value = false;
                                          });
                                      //  });
                                      } catch (e) {
                                        log(e.toString());
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.check,
                                      color: cgreen,
                                      size: 20,
                                    )),
                          )),
                      const TextFontWidget(
                        text: 'Paid?',
                        fontsize: 12,
                        color: cgreen,
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: IconButton(
                            onPressed: () async {
                              customShowDilogBox2(
                                  context: context,
                                  title: 'ALert',
                                  children: [
                                    const TextFontWidget(
                                        text: "Are you confirmed to Unpaid ?",
                                        fontsize: 15)
                                  ],
                                  actiononTapfuction: () async {
                                    await server
                                        .collection('DrivingSchoolCollection')
                                        .doc(UserCredentialsController.schoolId)
                                        .collection("Students")
                                        .doc(studentdata['docid'])
                                        .get()
                                        .then((value) async {
                                      await notificationController
                                          .userStudentNotification(
                                              studentID: studentdata['docid'],
                                              icon: WarningNotifierSetup().icon,
                                              messageText:
                                                  ''' Your ${Get.find<FeesAndBillsController>().feetypeName.value} rupees $studentFee /- is due on ${stringTimeToDateConvert(Get.find<FeesAndBillsController>().feeDueDateName.value)} ,Please pay on or before the due date.
                                                   നിങ്ങളുടെ ${Get.find<FeesAndBillsController>().feetypeName.value} ആയ $studentFee /- രൂപ, ദയവായി ${stringTimeToDateConvert(Get.find<FeesAndBillsController>().feeDueDateName.value)} തിയതിക്കുള്ളിൽ അടക്കേണ്ടതാണ്''',
                                              // ,
                                              headerText:
                                                  "${Get.find<FeesAndBillsController>().feetypeName.value} Due Fee",
                                              whiteshadeColor:
                                                  WarningNotifierSetup()
                                                      .whiteshadeColor,
                                              containerColor:
                                                  WarningNotifierSetup()
                                                      .containerColor);

                                      // await notificationController
                                      //     .userparentNotification(
                                      //         parentID: value['parentId'],
                                      //         icon: WarningNotifierSetup().icon,
                                      //         messageText:
                                      //             ''' Your ${Get.find<FeesAndBillsController>().feetypeName.value} rupees $studentFee /- is due on ${stringTimeToDateConvert(Get.find<FeesAndBillsController>().feeDueDateName.value)} ,Please pay on or before the due date.${"\n"}
                                      //              നിങ്ങളുടെ ${Get.find<FeesAndBillsController>().feetypeName.value} ആയ $studentFee /- രൂപ, ദയവായി ${stringTimeToDateConvert(Get.find<FeesAndBillsController>().feeDueDateName.value)} തിയതിക്കുള്ളിൽ അടക്കേണ്ടതാണ്''',
                                      //         // ,
                                      //         headerText:
                                      //             "${Get.find<FeesAndBillsController>().feetypeName.value} Due Fee",
                                      //         whiteshadeColor:
                                      //             WarningNotifierSetup()
                                      //                 .whiteshadeColor,
                                      //         containerColor:
                                      //             WarningNotifierSetup()
                                      //                 .containerColor)
                                      //     .then((value) =>
                                      //         Navigator.pop(context));
                                    });

                                    Get.find<StudentFeeController>()
                                        .updateStudentFeeStatus(
                                            studentdata['docid'], false, 0);
                                  },
                                  doyouwantActionButton: true);
                              // Get.find<StudentFeeController>()
                              //     .updateStudentFeeStatus(
                              //         studentdata['docid'], false, 0);
                            },
                            icon: const Icon(
                              Icons.close,
                              color: cgreen,
                              size: 20,
                            )),
                      ),
                      const TextFontWidget(
                        text: 'Not Paid?',
                        fontsize: 12,
                        color: cgreen,
                      ),
                    ],
                  ),
          ),
          Container(
            color: cWhite,
            width: 02,
          ),
        ],
      ),
    );
  }
}

class StudentFeesEditWidget extends StatelessWidget {
  final String docid;
  const StudentFeesEditWidget({super.key, required this.docid});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: SizedBox(
            height: 35,
            child: Center(
              child: TextFormField(
                controller:
                    Get.find<StudentFeeController>().updateFeeController,
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 01, horizontal: 01),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(0)),
                      borderSide: BorderSide(
                        width: 1,
                        style: BorderStyle.none,
                        color: Colors.red,
                      )),
                  focusedErrorBorder: OutlineInputBorder(
                    // borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(
                      width: 1,
                      style: BorderStyle.none,
                      color: Colors.red,
                    ),
                  ),
                  // contentPadding: const EdgeInsets.all(8.0),
                  enabledBorder:
                      OutlineInputBorder(borderSide: BorderSide(width: 0.4)),
                  hintStyle: TextStyle(fontSize: 13),
                  hintText: "  Enter Fee",
                  focusedBorder: OutlineInputBorder(
                    //<-- SEE HERE
                    borderSide: BorderSide(width: 1, color: Colors.green),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 2,
        ),
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () async {
              await Get.find<StudentFeeController>()
                  .updateStudentFeeInFeeBill(docid);
            },
            child: Container(
              height: 35,
              decoration: BoxDecoration(
                  border: Border.all(color: cBlack.withOpacity(0.2))),
              child: const Center(
                child: TextFontWidget(
                  text: '✔️',
                  fontsize: 12,
                  fontWeight: FontWeight.bold,
                  color: cgreen,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 2,
        ),
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () async {
              await Get.find<StudentFeeController>().feeEditController(
                docid,
                false,
              );
            },
            child: Container(
              height: 35,
              decoration: BoxDecoration(
                  border: Border.all(color: cBlack.withOpacity(0.2))),
              child: const Center(
                child: TextFontWidget(
                  text: '✖️',
                  fontsize: 12,
                  fontWeight: FontWeight.bold,
                  color: cred,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
