import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/controller/fee_controller/fee_controller.dart';
import 'package:new_project_driving/controller/notification_controller/notification_controller.dart';
import 'package:new_project_driving/view/users/admin/screens/batch/drop_down/batch_dp_dn.dart';
import 'package:new_project_driving/view/users/admin/screens/fess_and_bills/unpaid_std/unpaid_stds.dart';
import 'package:new_project_driving/view/widget/progess_button/progress_button.dart';
import 'package:new_project_driving/view/widget/responsive/responsive.dart';
import 'package:new_project_driving/view/widget/routeSelectedTextContainer/routeSelectedTextContainer.dart';

class FeeCoursesDetails extends StatelessWidget {
  FeeCoursesDetails({super.key});

  final FeeController feeController = Get.put(FeeController());
  final NotificationController notificationController =
      Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        scrollDirection: ResponsiveWebSite.isMobile(context)
            ? Axis.horizontal
            : Axis.vertical,
        child: Container(
          color: screenContainerbackgroundColor,
          height: 650,
          width: ResponsiveWebSite.isDesktop(context) ? double.infinity : 1200,
          padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Fees ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20, top: 10, right: 10),
                child: Row(
                  children: [
                    feeController.onTapBtach.value == false
                        ? const RouteSelectedTextContainer(
                            width: 180,
                            title: 'Unpaid Students',
                          )
                        : Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  feeController.onTapBtach.value = false;
                                },
                                child: const RouteSelectedTextContainer(
                                  title: 'Back',
                                  width: 100,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const RouteSelectedTextContainer(
                                title: 'Students List',
                                width: 200,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: ProgressButtonWidget(
                                  function: () async {
                                    Get.find<NotificationController>()
                                        .fetchUnpaidUsers(
                                      batchID: feeController.batchId.value,
                                      bodyText:
                                          'Your fee payment of your course is due. Please make the payment to avoid any late fees. Thank you!',
                                      titleText: 'Fees Reminder',
                                    );
                                  },
                                  buttonstate:
                                      notificationController.buttonstate.value,
                                  text: 'Send Notification',
                                ),
                              ),
                            ],
                          ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: SizedBox(
                        height: 50,
                        width: 250,
                        child: BatchDropDown(
                          onChanged: (batchModel) {
                            feeController.onTapBtach.value = true;
                            feeController.batchId.value = batchModel!.batchId;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // feeController.onTapUnpaid.value == true
              //     ?
              UnpaidStudentDataTable()
              // : Expanded(
              //     child: Column(
              //       children: [
              //         Container(
              //           color: cWhite,
              //           child: Padding(
              //             padding: const EdgeInsets.only(
              //               left: 5,
              //               right: 5,
              //             ),
              //             child: Container(
              //               color: cWhite,
              //               height: 40,
              //               child: const Row(
              //                 children: [
              //                   Expanded(
              //                       flex: 1,
              //                       child:
              //                           CatrgoryTableHeaderWidget(headerTitle: 'No')),
              //                   SizedBox(
              //                     width: 02,
              //                   ),
              //                   Expanded(
              //                     flex: 2,
              //                     child: CatrgoryTableHeaderWidget(
              //                         headerTitle: 'Course Name'),
              //                   ),
              //                   SizedBox(
              //                     width: 01,
              //                   ),
              //                   Expanded(
              //                     flex: 2,
              //                     child: CatrgoryTableHeaderWidget(
              //                         headerTitle: 'Initial Rate'),
              //                   ),
              //                   SizedBox(
              //                     width: 02,
              //                   ),
              //                   Expanded(
              //                     flex: 2,
              //                     child: CatrgoryTableHeaderWidget(
              //                         headerTitle: 'Total Students'),
              //                   ),
              //                   SizedBox(
              //                     width: 02,
              //                   ),
              //                   Expanded(
              //                     flex: 2,
              //                     child: CatrgoryTableHeaderWidget(
              //                         headerTitle: 'Amount Collected'),
              //                   ),
              //                   SizedBox(
              //                     width: 02,
              //                   ),
              //                   Expanded(
              //                     flex: 2,
              //                     child: CatrgoryTableHeaderWidget(
              //                         headerTitle: 'Pending Amount'),
              //                   ),
              //                   SizedBox(
              //                     width: 02,
              //                   ),
              //                   Expanded(
              //                     flex: 2,
              //                     child: CatrgoryTableHeaderWidget(
              //                         headerTitle: 'Total Amount'),
              //                   ),
              //                   SizedBox(
              //                     width: 02,
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ),
              //         ),
              //         Expanded(
              //           child: Container(
              //             width: ResponsiveWebSite.isDesktop(context)
              //                 ? double.infinity
              //                 : 1200,
              //             padding: const EdgeInsets.only(left: 5, right: 5),
              //             decoration: BoxDecoration(
              //               color: cWhite,
              //               border: Border.all(color: cWhite),
              //             ),
              //             child: StreamBuilder(
              //               stream: feeController.onTapBtach.value == true
              //                   ? server
              //                       .collection('DrivingSchoolCollection')
              //                       .doc(UserCredentialsController.schoolId)
              //                       .collection('FeesCollection')
              //                       .doc(feeController.batchId.value)
              //                       .collection('Courses')
              //                       .snapshots()
              //                   : null,
              //               builder: (context, snapS) {
              //                 if (snapS.connectionState == ConnectionState.waiting) {
              //                   return const Center(child: CircularProgressIndicator());
              //                 }
              //                 if (feeController.onTapBtach.value == false) {
              //                   return const Center(
              //                     child: Text(
              //                       'Select Batch',
              //                       style: TextStyle(
              //                           fontSize: 20, fontWeight: FontWeight.w500),
              //                     ),
              //                   );
              //                 }
              //                 if (snapS.data == null || snapS.data!.docs.isEmpty) {
              //                   return const Center(
              //                     child: Text(
              //                       'No courses',
              //                       style: TextStyle(
              //                           fontSize: 20, fontWeight: FontWeight.w500),
              //                     ),
              //                   );
              //                 }
              //                 return ListView.separated(
              //                   itemCount: snapS.data!.docs.length,
              //                   itemBuilder: (context, index) {
              //                     final fee = snapS.data!.docs[index].data();
              //                     final courseId = fee['courseId'];
              //                     return StreamBuilder(
              //                       stream: server
              //                           .collection('DrivingSchoolCollection')
              //                           .doc(UserCredentialsController.schoolId)
              //                           .collection('Courses')
              //                           .doc(courseId)
              //                           .snapshots(),
              //                       builder: (context, courseSnapshot) {
              //                         if (courseSnapshot.connectionState ==
              //                             ConnectionState.waiting) {
              //                           return const SizedBox();
              //                         }
              //                         final data = CourseModel.fromMap(
              //                             courseSnapshot.data!.data()!);
              //                         feeController.pendingAmountCalculate(
              //                           data.courseId,
              //                           feeController.batchId.value,
              //                         );
              //                         feeController.getFeeTotalAmount(data.courseId,
              //                             feeController.batchId.value, data.rate);
              //                         return GestureDetector(
              //                           onTap: () {
              //                             courseController.setCourseData(data);
              //                             courseController.ontapStudentDetail.value =
              //                                 true;
              //                             courseController.ontapCourseName.value =
              //                                 data.courseName;
              //                             courseController.ontapCourseDocID.value =
              //                                 data.courseId;
              //                           },
              //                           child: FeeCoursesDataList(
              //                               data: data, feeModel: fee, index: index),
              //                         );
              //                       },
              //                     );
              //                   },
              //                   separatorBuilder: (context, index) =>
              //                       const SizedBox(height: 2),
              //                 );
              //               },
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   )
            ],
          ),
        ),
      ),
    );
  }
}
