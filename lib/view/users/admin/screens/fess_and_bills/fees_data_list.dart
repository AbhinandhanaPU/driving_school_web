import 'package:flutter/material.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/view/widget/custom_showdialouge/custom_showdilog.dart';
import 'package:new_project_driving/view/widget/reusable_table_widgets/data_container.dart';

class ClassWiseFeesDataListContainer extends StatelessWidget {
  // final Map<String, dynamic> studentdata;
  final int index;
  // final int studentFee;
  const ClassWiseFeesDataListContainer({
    required this.index,
    super.key,
    // required this.studentdata,
    // required this.studentFee,
  });

  // final NotificationController notificationController =
  //     Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // color: studentdata['feepaid'] == false
      //     ? Colors.red.withOpacity(0.1)
      //     : Colors.green.withOpacity(0.1),
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
            flex: 2,
            child: DataContainerWidget(
                rowMainAccess: MainAxisAlignment.start,
                index: index,
                headerTitle: "StudentName"),
          ),
          Container(
            color: cWhite,
            width: 02,
          ),
          Expanded(
            flex: 2,
            child:
                //  studentdata['editFee'] == true
                //     ? StudentFeesEditWidget(docid: studentdata['docid'])
                //     :
                Row(
              children: [
                DataContainerWidget(
                    rowMainAccess: MainAxisAlignment.center,
                    index: index,
                    headerTitle: "fee"),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: IconButton(
                    onPressed: () async {
                      // Get.find<StudentFeeController>()
                      //     .feeEditController(
                      //         studentdata['docid'], true);
                    },
                    icon: const Icon(
                      Icons.edit_outlined,
                      color: cgreen,
                      size: 20,
                    ),
                  ),
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
            child:
                //  studentdata['editFee'] == true
                //     ? StudentFeesEditWidget(docid: studentdata['docid'])
                //     :
                Row(
              children: [
                DataContainerWidget(
                    rowMainAccess: MainAxisAlignment.center,
                    index: index,
                    headerTitle: "Advance"),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: IconButton(
                    onPressed: () async {
                      // Get.find<StudentFeeController>()
                      //     .feeEditController(
                      //         studentdata['docid'], true);
                    },
                    icon: const Icon(
                      Icons.edit_outlined,
                      color: cgreen,
                      size: 20,
                    ),
                  ),
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
            child: DataContainerWidget(
                rowMainAccess: MainAxisAlignment.start,
                index: index,
                headerTitle: "pending Amount"),
          ),
          Container(
            color: cWhite,
            width: 02,
          ),
          Expanded(
            flex: 2,
            child: DataContainerWidget(
                rowMainAccess: MainAxisAlignment.start,
                index: index,
                headerTitle: "Due Date"),
          ),
          Container(
            color: cWhite,
            width: 02,
          ),
          Expanded(
            flex: 2,
            child:
                //  studentdata['feepaid'] == false
                //     ? Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           // webassets\png\not_active.png
                //           SizedBox(
                //             width: 15,
                //             child: Image.asset(
                //               'webassets/png/not_active.png',
                //             ),
                //           ),
                //           const TextFontWidget(
                //             text: " Pending",
                //             fontsize: 12,
                //             overflow: TextOverflow.ellipsis,
                //           ),
                //         ],
                //       )
                //     :
                Row(
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
            child:
                //  studentdata['feepaid'] == false
                //     ? Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Obx(() => Padding(
                //                 padding: const EdgeInsets.only(bottom: 10),
                //                 child: Get.find<FeesAndBillsController>()
                //                             .feessendingMessage
                //                             .value ==
                //                         true
                //                     ? const SizedBox(
                //                         height: 10,
                //                         width: 10,
                //                         child: CircularProgressIndicator.adaptive())
                //                     : IconButton(
                //                         onPressed: () async {
                //                           try {
                //                             Get.find<FeesAndBillsController>()
                //                                 .feessendingMessage
                //                                 .value = true;
                //                             await server
                //                                 .collection(
                //                                     'DrivingSchoolCollection')
                //                                 .doc(UserCredentialsController
                //                                     .schoolId)
                //                                 .collection("Students")
                //                                 .doc(studentdata['docid'])
                //                                 .get()
                //                                 .then((value) async {
                //                               await notificationController
                //                                   .userStudentNotification(
                //                                       studentID:
                //                                           studentdata['docid'],
                //                                       icon: SuccessNotifierSetup()
                //                                           .icon,
                //                                       messageText:
                //                                           'Your ${Get.find<FeesAndBillsController>().feetypeName.value} rupees $studentFee /- is paid successfully, Thank you 🙏. \n നിങ്ങളുടെ ${Get.find<FeesAndBillsController>().feetypeName.value} ആയ $studentFee /- രൂപ വിജയകരമായി അടച്ചിരിക്കുന്നു, നന്ദി 🙏',
                //                                       // ,
                //                                       headerText:
                //                                           "${Get.find<FeesAndBillsController>().feetypeName.value} Due Fee",
                //                                       whiteshadeColor:
                //                                           SuccessNotifierSetup()
                //                                               .whiteshadeColor,
                //                                       containerColor:
                //                                           SuccessNotifierSetup()
                //                                               .containerColor)
                //                                   .then((value) async {
                //                                 await Get.find<
                //                                         StudentFeeController>()
                //                                     .updateStudentFeeStatus(
                //                                         studentdata['docid'],
                //                                         true,
                //                                         studentdata['fee']);
                //                                 Get.find<FeesAndBillsController>()
                //                                     .feessendingMessage
                //                                     .value = false;
                //                               });
                //                             });
                //                           } catch (e) {
                //                             log(e.toString());
                //                           }
                //                         },
                //                         icon: const Icon(
                //                           Icons.check,
                //                           color: cgreen,
                //                           size: 20,
                //                         )),
                //               )),
                //           const TextFontWidget(
                //             text: 'Paid?',
                //             fontsize: 12,
                //             color: cgreen,
                //           ),
                //         ],
                //       )
                //     :
                Row(
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
                              // await server
                              //     .collection('DrivingSchoolCollection')
                              //     .doc(UserCredentialsController.schoolId)
                              //     .collection("Students")
                              //     .doc(studentdata['docid'])
                              //     .get()
                              //     .then((value) async {
                              //   await notificationController
                              //       .userStudentNotification(
                              //           studentID: studentdata['docid'],
                              //           icon: WarningNotifierSetup().icon,
                              //           messageText:
                              //               ''' Your ${Get.find<FeesAndBillsController>().feetypeName.value} rupees $studentFee /- is due on ${stringTimeToDateConvert(Get.find<FeesAndBillsController>().feeDueDateName.value)} ,Please pay on or before the due date.
                              //                      നിങ്ങളുടെ ${Get.find<FeesAndBillsController>().feetypeName.value} ആയ $studentFee /- രൂപ, ദയവായി ${stringTimeToDateConvert(Get.find<FeesAndBillsController>().feeDueDateName.value)} തിയതിക്കുള്ളിൽ അടക്കേണ്ടതാണ്''',
                              //           // ,
                              //           headerText:
                              //               "${Get.find<FeesAndBillsController>().feetypeName.value} Due Fee",
                              //           whiteshadeColor: WarningNotifierSetup()
                              //               .whiteshadeColor,
                              //           containerColor: WarningNotifierSetup()
                              //               .containerColor)
                              //       .then((value) => Navigator.pop(context));
                              // });

                              // Get.find<StudentFeeController>()
                              //     .updateStudentFeeStatus(
                              //         studentdata['docid'], false, 0);
                            },
                            doyouwantActionButton: true);
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
                // controller:
                //     Get.find<StudentFeeController>().updateFeeController,
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
              // await Get.find<StudentFeeController>()
              //     .updateStudentFeeInFeeBill(docid);
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
              // await Get.find<StudentFeeController>().feeEditController(
              //   docid,
              //   false,
              // );
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
