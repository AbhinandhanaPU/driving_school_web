import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/constant/constant.validate.dart';
import 'package:new_project_driving/controller/fees_N_bills_Controller/fee_student_controller.dart';
import 'package:new_project_driving/controller/fees_N_bills_Controller/fees_bills_controller.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/utils/firebase/firebase.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';
import 'package:new_project_driving/view/users/admin/screens/fess_and_bills/create_fees/class_wise_status.dart';
import 'package:new_project_driving/view/users/admin/screens/fess_and_bills/create_fees/create_fees.dart';
import 'package:new_project_driving/view/users/admin/screens/fess_and_bills/fees/select_month.dart';
import 'package:new_project_driving/view/widget/button_container_widget/button_container_widget.dart';
import 'package:new_project_driving/view/widget/loading_widget/loading_widget.dart';
import 'package:new_project_driving/view/widget/responsive/responsive.dart';
import 'package:new_project_driving/view/widget/reusable_table_widgets/category_table_header.dart';
import 'package:new_project_driving/view/widget/reusable_table_widgets/data_container.dart';
import 'package:new_project_driving/view/widget/routeSelectedTextContainer/routeSelectedTextContainer.dart';

class CreatedFeesStatus extends StatelessWidget {
  final FeesAndBillsController feesAndBillsController =
      Get.put(FeesAndBillsController());
  final StudentFeeController studentFeeController =
      Get.put(StudentFeeController());
  CreatedFeesStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => feesAndBillsController.ontapviewclasswiseFees.value == true
        ? const ClassWiseFeesStatus()
        : SingleChildScrollView(
            scrollDirection: ResponsiveWebSite.isMobile(context)
                ? Axis.horizontal
                : Axis.vertical,
            child: Container(
              color: screenContainerbackgroundColor,
              height: 650,
              width:
                  ResponsiveWebSite.isDesktop(context) ? double.infinity : 1200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 25, top: 25, right: 25),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 05, right: 05),
                          child: RouteSelectedTextContainer(
                              title: 'All Fees & Bills'),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: SizedBox(
                            width: 250,
                            height:
                                ResponsiveWebSite.isMobile(context) ? 80 : 80,
                            //color: cWhite,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const TextFontWidget(
                                    text: 'Month *', fontsize: 12.5),
                                const SizedBox(
                                  height: 05,
                                ),
                                SizedBox(
                                  height: 40,
                                  child: SelectFeeMonthDropDown(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            createFeesFunction(context);
                          },
                          child: ButtonContainerWidget(
                              curving: 30,
                              colorindex: 0,
                              height: 40,
                              width: 180,
                              child: const Center(
                                child: TextFontWidgetRouter(
                                  text: 'Create Fee',
                                  fontsize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: cWhite,
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 25),
                    child: Container(
                        width: ResponsiveWebSite.isDesktop(context) ? double.infinity: 1200,
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
                                    width: 01,
                                  ),
                                  Expanded(
                                      flex: 3,
                                      child: CatrgoryTableHeaderWidget(
                                          headerTitle: 'Fee Type Name')),
                                  SizedBox(
                                    width: 01,
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: CatrgoryTableHeaderWidget(
                                          headerTitle: 'Created Date')),
                                  SizedBox(
                                    width: 01,
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: CatrgoryTableHeaderWidget(
                                          headerTitle: 'Due Date')),
                                  SizedBox(
                                    width: 01,
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: CatrgoryTableHeaderWidget(
                                          headerTitle: 'Collected')),
                                  SizedBox(
                                    width: 01,
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: CatrgoryTableHeaderWidget(
                                          headerTitle: 'Pending')),
                                  SizedBox(
                                    width: 01,
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
                                        .collection('FeesCollection')
                                        .doc(feesAndBillsController
                                            .feeMonthData.value)
                                        .collection(feesAndBillsController
                                            .feeMonthData.value)
                                        .snapshots(),
                                    builder: (context, snaps) {
                                      if (snaps.hasData) {
                                        return ListView.separated(
                                          itemBuilder: (context, index) {
                                            if (snaps.data!.docs.isEmpty) {
                                              // If list is empty, show "please select the class" text
                                              return const Center(
                                                child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Please select the Month",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                              );
                                            } else {
                                              final data = snaps
                                                  .data!.docs[index]
                                                  .data();
                                              return GestureDetector(
                                                onTap: () {
                                                  log("Fee IDD ${feesAndBillsController.feeDateData.value}");
                                                  feesAndBillsController
                                                      .feeDateData
                                                      .value = data['docid'];
                                                  feesAndBillsController
                                                      .ontapviewclasswiseFees
                                                      .value = true;
                                                  feesAndBillsController
                                                          .feetypeName.value =
                                                      data['feestypeName'];
                                                  DateTime duedate = DateTime
                                                      .fromMillisecondsSinceEpoch(
                                                          data['dueDate']);
                                                  feesAndBillsController
                                                          .feeDueDateName
                                                          .value =
                                                      duedate.toString();
                                                },
                                                child: AllClassessFeesDataList(
                                                  data: data,
                                                  index: index,
                                                ),
                                              );
                                            }
                                          },
                                          separatorBuilder: (context, index) {
                                            return const SizedBox(
                                              height: 2,
                                            );
                                          },
                                          itemCount: snaps.data!.docs.isEmpty
                                              ? 1
                                              : snaps.data!.docs.length,
                                        );
                                      } else if (snaps.data == null) {
                                        return const LoadingWidget();
                                      } else {
                                        return const LoadingWidget();
                                      }
                                    }),
                              ),
                            )
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ));
  }
}

class AllClassessFeesDataList extends StatelessWidget {
  final Map<String, dynamic> data;
  final int index;
  const AllClassessFeesDataList({
    required this.index,
    required this.data,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Get.find<FeesAndBillsController>().pendingAmountCalculate(data['docid']);
    Get.find<FeesAndBillsController>().bugCalculateTotalamount(
        data['docid'] ?? '', data['totalStudents'] ?? 0);
    Get.find<FeesAndBillsController>().collectedAmountCalculate(
      data['docid'],
    );
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(data['createdDate']);
    DateTime duedate = DateTime.fromMillisecondsSinceEpoch(data['dueDate']);
    return SizedBox(
      height: 45,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: DataContainerWidget(
                rowMainAccess: MainAxisAlignment.center,
                color: cWhite,
                // width: 150,
                index: index,
                headerTitle: '${index + 1}'), //....................No
          ),
          const SizedBox(
            width: 01,
          ),
          Expanded(
            flex: 3,
            child: DataContainerWidget(
                rowMainAccess: MainAxisAlignment.start,
                color: cWhite,
                index: index,
                headerTitle: "    ${data['feestypeName'] ?? ''}"),
          ),
          const SizedBox(
            width: 01,
          ),
          Expanded(
            flex: 2,
            child: DataContainerWidget(
                rowMainAccess: MainAxisAlignment.center,
                color: cWhite,
                // width: 150,
                index: index,
                headerTitle: '   ${dateConvert(dateTime)}'),
          ), // ...................................Total Number
          const SizedBox(
            width: 01,
          ),
          Expanded(
            flex: 2,
            child: DataContainerWidget(
                rowMainAccess: MainAxisAlignment.center,
                color: cWhite,
                // width: 150,
                index: index,
                headerTitle: '   ${dateConvert(duedate)}'),
          ), //....................................... fee amount
          const SizedBox(
            width: 01,
          ),
          // Expanded(
          //   flex: 2,
          //   child: DataContainerWidget(
          //       rowMainAccess: MainAxisAlignment.center,
          //       color: cWhite,
          //       // width: 150,
          //       index: index,
          //       headerTitle: '   ${data['fees']}'),
          // ), /////////////...............................collected
          // const SizedBox(
          //   width: 01,
          // ),
          Expanded(
            flex: 2,
            child: DataContainerWidget(
                rowMainAccess: MainAxisAlignment.center,
                color: cWhite,
                // width: 150,
                index: index,
                headerTitle: '   ${data['collectedAmount']}'),
          ),
          Expanded(
            flex: 2,
            child: DataContainerWidget(
                rowMainAccess: MainAxisAlignment.center,
                color: cWhite,
                // width: 150,
                index: index,
                headerTitle: '   ${data['pendingAmount']}'),
          ),
          Expanded(
            flex: 2,
            child: DataContainerWidget(
                rowMainAccess: MainAxisAlignment.center,
                color: cWhite,
                // width: 150,
                index: index,
                headerTitle: '   ${data['totalAmount']}'),
          ),
        ],
      ),
    );
  }
}
