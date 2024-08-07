import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/controller/fees_N_bills_Controller/feeStudent_controller.dart';
import 'package:new_project_driving/controller/fees_N_bills_Controller/fees_bills_controller.dart';
import 'package:new_project_driving/model/student_model/student_model.dart';
import 'package:new_project_driving/utils/firebase/firebase.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';
import 'package:new_project_driving/view/users/admin/screens/fess_and_bills/create_fees/class_wise_status.dart';
import 'package:new_project_driving/view/users/admin/screens/fess_and_bills/std_fees/std_fee_datalist.dart';
import 'package:new_project_driving/view/widget/loading_widget/loading_widget.dart';
import 'package:new_project_driving/view/widget/responsive/responsive.dart';
import 'package:new_project_driving/view/widget/reusable_table_widgets/category_table_header.dart';
import 'package:new_project_driving/view/widget/routeSelectedTextContainer/routeSelectedTextContainer.dart';

class StudentsFeesStatus extends StatelessWidget {
  final FeesAndBillsController feesAndBillsController =
      Get.put(FeesAndBillsController());
  final StudentFeeController studentFeeController =
      Get.put(StudentFeeController());
  StudentsFeesStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => feesAndBillsController.ontapviewclasswiseFees.value == true
          ? const ClassWiseFeesStatus()
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 25, top: 25, right: 25),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 05, right: 05),
                            child: RouteSelectedTextContainer(
                                title: 'All Fees & Bills'),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 25),
                      child: Container(
                        width: ResponsiveWebSite.isDesktop(context)
                            ? double.infinity
                            : 1200,
                        height: // ResponsiveWebSite.isMobile(context) ? 800 :
                            500,
                        color: cWhite,
                        child: Column(
                          children: [
                            const Padding(
                              padding:
                                  EdgeInsets.only(top: 8, left: 8, right: 8),
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: CatrgoryTableHeaderWidget(
                                          headerTitle: 'No')),
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
                                          headerTitle: 'Pending')),
                                  SizedBox(
                                    width: 02,
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: CatrgoryTableHeaderWidget(
                                          headerTitle: 'Total')),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 8, left: 8, right: 8),
                                child: StreamBuilder(
                                  stream: server
                                      .collection('DrivingSchoolCollection')
                                      .doc(UserCredentialsController.schoolId)
                                      .collection('FeeCollection')
                                      .snapshots(),
                                  builder: (context, snaps) {
                                    if (snaps.hasData &&
                                        snaps.data!.docs.isNotEmpty) {
                                      return ListView.separated(
                                        itemBuilder: (context, index) {
                                          final data =
                                              snaps.data!.docs[index].data();
                                          return StreamBuilder(
                                              stream: server
                                                  .collection(
                                                      'DrivingSchoolCollection')
                                                  .doc(UserCredentialsController
                                                      .schoolId)
                                                  .collection('Students')
                                                  .doc(data['studentID'])
                                                  .snapshots(),
                                              builder: (context, snapshot) {
                                                final stddata =
                                                    StudentModel.fromMap(
                                                        snapshot.data!.data()!);
                                                return StudentFeeDatalist(
                                                  data: stddata,
                                                  index: index,
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
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            )
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
