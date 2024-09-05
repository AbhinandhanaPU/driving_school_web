import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/controller/course_controller/course_controller.dart';
import 'package:new_project_driving/controller/fee_controller/fee_controller.dart';
import 'package:new_project_driving/controller/notification_controller/notification_controller.dart';
import 'package:new_project_driving/model/course_model/course_model.dart';
import 'package:new_project_driving/utils/firebase/firebase.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';
import 'package:new_project_driving/view/users/admin/screens/batch/drop_down/batch_dp_dn.dart';
import 'package:new_project_driving/view/users/admin/screens/fess_and_bills/course_list/fee_courses_data_list.dart';
import 'package:new_project_driving/view/users/admin/screens/fess_and_bills/std_fees/std_fee_details.dart';
import 'package:new_project_driving/view/users/admin/screens/fess_and_bills/unpaid_std/unpaid_stds.dart';
import 'package:new_project_driving/view/widget/progess_button/progress_button.dart';
import 'package:new_project_driving/view/widget/responsive/responsive.dart';
import 'package:new_project_driving/view/widget/reusable_table_widgets/category_table_header.dart';
import 'package:new_project_driving/view/widget/routeSelectedTextContainer/routeSelectedTextContainer.dart';
import 'package:new_project_driving/view/widget/routeSelectedTextContainer/route_NonSelectedContainer.dart';

class FeeCoursesDetails extends StatefulWidget {
  const FeeCoursesDetails({super.key});

  @override
  State<FeeCoursesDetails> createState() => _FeeCoursesDetailsState();
}

class _FeeCoursesDetailsState extends State<FeeCoursesDetails> {
  final CourseController courseController = Get.put(CourseController());
  final FeeController feeController = Get.put(FeeController());
  final NotificationController notificationController =
      Get.put(NotificationController());
  @override
  void initState() {
    feeController.onTapBtach.value = false;
    courseController.ontapStudentDetail.value = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return courseController.ontapStudentDetail.value == true
            ? StudentsFeesStatus()
            : SingleChildScrollView(
                scrollDirection: ResponsiveWebSite.isMobile(context)
                    ? Axis.horizontal
                    : Axis.vertical,
                child: Container(
                  color: screenContainerbackgroundColor,
                  height: 650,
                  width: ResponsiveWebSite.isDesktop(context)
                      ? double.infinity
                      : 1200,
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
                        padding: const EdgeInsets.only(
                            bottom: 20, top: 10, right: 10),
                        child: Row(
                          children: [
                            const RouteSelectedTextContainer(
                              width: 180,
                              title: 'All Courses',
                            ),
                            const Spacer(),
                            const SizedBox(
                              height: 40,
                              width: 200,
                              child: Padding(
                                padding: EdgeInsets.only(top: 05, left: 05),
                                child: RouteNonSelectedTextContainer(
                                  title: 'Show Unpaid Student',
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Obx(
                              () => Checkbox(
                                value: feeController.onTapUnpaid.value,
                                checkColor: cWhite,
                                activeColor: cBlue,
                                onChanged: (value) {
                                  feeController.onTapUnpaid.value = value!;
                                },
                              ),
                            ),
                            feeController.onTapUnpaid.value == true
                                ? Obx(
                                    () => Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: ProgressButtonWidget(
                                        function: () async {
                                          // Get.find<NotificationController>()
                                          //     .fetchUnpaidUsers(
                                          //   batchID:
                                          //       feeController.batchId.value,
                                          //   bodyText: 'bodyText',
                                          //   titleText: 'Please pay on time',
                                          // );
                                        },
                                        buttonstate: notificationController
                                            .buttonstate.value,
                                        text: 'Send Notification',
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: SizedBox(
                                      height: 50,
                                      width: 250,
                                      child: BatchDropDown(
                                        onChanged: (batchModel) {
                                          feeController.onTapBtach.value = true;
                                          feeController.batchId.value =
                                              batchModel!.batchId;
                                        },
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      feeController.onTapUnpaid.value == true
                          ? UnpaidStudentDataTable()
                          : Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    color: cWhite,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 5,
                                        right: 5,
                                      ),
                                      child: Container(
                                        color: cWhite,
                                        height: 40,
                                        child: const Row(
                                          children: [
                                            Expanded(
                                                flex: 1,
                                                child:
                                                    CatrgoryTableHeaderWidget(
                                                        headerTitle: 'No')),
                                            SizedBox(
                                              width: 02,
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: CatrgoryTableHeaderWidget(
                                                  headerTitle: 'Course Name'),
                                            ),
                                            SizedBox(
                                              width: 01,
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: CatrgoryTableHeaderWidget(
                                                  headerTitle: 'Initial Rate'),
                                            ),
                                            SizedBox(
                                              width: 02,
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: CatrgoryTableHeaderWidget(
                                                  headerTitle:
                                                      'Total Students'),
                                            ),
                                            SizedBox(
                                              width: 02,
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: CatrgoryTableHeaderWidget(
                                                  headerTitle:
                                                      'Amount Collected'),
                                            ),
                                            SizedBox(
                                              width: 02,
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: CatrgoryTableHeaderWidget(
                                                  headerTitle:
                                                      'Pending Amount'),
                                            ),
                                            SizedBox(
                                              width: 02,
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: CatrgoryTableHeaderWidget(
                                                  headerTitle: 'Total Amount'),
                                            ),
                                            SizedBox(
                                              width: 02,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      width:
                                          ResponsiveWebSite.isDesktop(context)
                                              ? double.infinity
                                              : 1200,
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 5),
                                      decoration: BoxDecoration(
                                        color: cWhite,
                                        border: Border.all(color: cWhite),
                                      ),
                                      child: StreamBuilder(
                                        stream: feeController
                                                    .onTapBtach.value ==
                                                true
                                            ? server
                                                .collection(
                                                    'DrivingSchoolCollection')
                                                .doc(UserCredentialsController
                                                    .schoolId)
                                                .collection('FeesCollection')
                                                .doc(
                                                    feeController.batchId.value)
                                                .collection('Courses')
                                                .snapshots()
                                            : null,
                                        builder: (context, snapS) {
                                          if (snapS.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          }
                                          if (feeController.onTapBtach.value ==
                                              false) {
                                            return const Center(
                                              child: Text(
                                                'Select Batch',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            );
                                          }
                                          if (snapS.data == null ||
                                              snapS.data!.docs.isEmpty) {
                                            return const Center(
                                              child: Text(
                                                'No courses',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            );
                                          }

                                          return ListView.separated(
                                            itemCount: snapS.data!.docs.length,
                                            itemBuilder: (context, index) {
                                              final fee = snapS
                                                  .data!.docs[index]
                                                  .data();
                                              final courseId = fee['courseId'];
                                              return StreamBuilder(
                                                stream: server
                                                    .collection(
                                                        'DrivingSchoolCollection')
                                                    .doc(
                                                        UserCredentialsController
                                                            .schoolId)
                                                    .collection('Courses')
                                                    .doc(courseId)
                                                    .snapshots(),
                                                builder:
                                                    (context, courseSnapshot) {
                                                  if (courseSnapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return const SizedBox();
                                                  }
                                                  final data =
                                                      CourseModel.fromMap(
                                                          courseSnapshot.data!
                                                              .data()!);
                                                  feeController
                                                      .pendingAmountCalculate(
                                                    data.courseId,
                                                    feeController.batchId.value,
                                                  );
                                                  feeController
                                                      .getFeeTotalAmount(
                                                          data.courseId,
                                                          feeController
                                                              .batchId.value,
                                                          data.rate);
                                                  return GestureDetector(
                                                    onTap: () {
                                                      courseController
                                                          .setCourseData(data);
                                                      courseController
                                                          .ontapStudentDetail
                                                          .value = true;
                                                      courseController
                                                              .ontapCourseName
                                                              .value =
                                                          data.courseName;
                                                      courseController
                                                              .ontapCourseDocID
                                                              .value =
                                                          data.courseId;
                                                    },
                                                    child: FeeCoursesDataList(
                                                        data: data,
                                                        feeModel: fee,
                                                        index: index),
                                                  );
                                                },
                                              );
                                            },
                                            separatorBuilder:
                                                (context, index) =>
                                                    const SizedBox(height: 2),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                    ],
                  ),
                ),
              );
      },
    );
  }
}
