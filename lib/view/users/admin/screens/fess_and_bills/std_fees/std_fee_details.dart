import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/controller/course_controller/course_controller.dart';
import 'package:new_project_driving/controller/fee_controller/fee_controller.dart';
import 'package:new_project_driving/controller/notification_controller/notification_controller.dart';
import 'package:new_project_driving/model/student_model/student_model.dart';
import 'package:new_project_driving/utils/firebase/firebase.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';
import 'package:new_project_driving/view/users/admin/screens/fess_and_bills/std_fees/std_fee_datalist.dart';
import 'package:new_project_driving/view/widget/loading_widget/loading_widget.dart';
import 'package:new_project_driving/view/widget/progess_button/progress_button.dart';
import 'package:new_project_driving/view/widget/responsive/responsive.dart';
import 'package:new_project_driving/view/widget/reusable_table_widgets/category_table_header.dart';
import 'package:new_project_driving/view/widget/routeSelectedTextContainer/routeSelectedTextContainer.dart';

class StudentsFeesStatus extends StatelessWidget {
  StudentsFeesStatus({super.key});
  final CourseController courseController = Get.put(CourseController());
  final FeeController feeController = Get.put(FeeController());
  final NotificationController notificationController =
      Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    final courseid = courseController.ontapCourseDocID.value;
    final batchId = feeController.batchId.value;

    return SingleChildScrollView(
      scrollDirection:
          ResponsiveWebSite.isMobile(context) ? Axis.horizontal : Axis.vertical,
      child: Container(
        color: screenContainerbackgroundColor,
        height: 650,
        width: ResponsiveWebSite.isDesktop(context) ? double.infinity : 1200,
        padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Students List ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: GestureDetector(
                      onTap: () {
                        courseController.ontapStudentDetail.value = false;
                      },
                      child: const RouteSelectedTextContainer(
                        title: 'Back',
                        width: 100,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.only(left: 15, bottom: 10),
                      child: ProgressButtonWidget(
                        function: () async {
                          Get.find<NotificationController>().fetchUnpaidUsers(
                            batchID: feeController.batchId.value,
                         
                            bodyText: 'fees notification',
                            titleText: 'Please pay on time',
                          );
                        },
                        buttonstate: notificationController.buttonstate.value,
                        text: 'Send Notification',
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Container(
                width: ResponsiveWebSite.isDesktop(context)
                    ? double.infinity
                    : 1200,
                height: 500,
                color: cWhite,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child:
                                  CatrgoryTableHeaderWidget(headerTitle: 'No')),
                          SizedBox(
                            width: 02,
                          ),
                          Expanded(
                              flex: 3,
                              child: CatrgoryTableHeaderWidget(
                                  headerTitle: 'Student Name')),
                          SizedBox(
                            width: 02,
                          ),
                          Expanded(
                              flex: 2,
                              child: CatrgoryTableHeaderWidget(
                                  headerTitle: 'Joining Date')),
                          SizedBox(
                            width: 02,
                          ),
                          Expanded(
                              flex: 2,
                              child: CatrgoryTableHeaderWidget(
                                  headerTitle: 'Completed Days')),
                          SizedBox(
                            width: 02,
                          ),
                          Expanded(
                              flex: 2,
                              child: CatrgoryTableHeaderWidget(
                                  headerTitle: 'Fee Status')),
                          SizedBox(
                            width: 02,
                          ),
                          Expanded(
                              flex: 2,
                              child: CatrgoryTableHeaderWidget(
                                  headerTitle: 'Amount Paid')),
                          SizedBox(
                            width: 02,
                          ),
                          Expanded(
                              flex: 2,
                              child: CatrgoryTableHeaderWidget(
                                  headerTitle: 'Total Amount')),
                          SizedBox(
                            width: 02,
                          ),
                        ],
                      ),
                    ),
                    // Obx(
                    //   () =>
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 8, left: 8, right: 8, top: 2),
                        child: StreamBuilder(
                          stream:
                              // feeController.onTapUnpaid.value == true
                              //     ? server
                              //         .collection('DrivingSchoolCollection')
                              //         .doc(UserCredentialsController.schoolId)
                              //         .collection('FeesCollection')
                              //         .doc(batchId)
                              //         .collection('Courses')
                              //         .doc(courseid)
                              //         .collection('Students')
                              //         .where('paidStatus', isEqualTo: false)
                              //         .snapshots()
                              //     :
                              server
                                  .collection('DrivingSchoolCollection')
                                  .doc(UserCredentialsController.schoolId)
                                  .collection('FeesCollection')
                                  .doc(batchId)
                                  .collection('Courses')
                                  .doc(courseid)
                                  .collection('Students')
                                  .orderBy('paidStatus')
                                  .snapshots(),
                          builder: (context, snaps) {
                            if (snaps.hasData && snaps.data!.docs.isNotEmpty) {
                              return ListView.separated(
                                itemBuilder: (context, index) {
                                  final data = snaps.data!.docs[index].data();
                                  return StreamBuilder(
                                      stream: server
                                          .collection('DrivingSchoolCollection')
                                          .doc(UserCredentialsController
                                              .schoolId)
                                          .collection('Students')
                                          .doc(data['studentID'])
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        final modeldata =
                                            snapshot.data?.data() ?? {};
                                        final studentModel =
                                            StudentModel.fromMap(modeldata);
                                        return StudentFeeDatalist(
                                          stdData: studentModel,
                                          index: index,
                                          feeData: data,
                                        );
                                      });
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 2,
                                  );
                                },
                                itemCount: snaps.data!.docs.length,
                              );
                            } else if (snaps.data == null) {
                              return const LoadingWidget();
                            } else {
                              return const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "No students Added to fees collection",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w400),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    // )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
