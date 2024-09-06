import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/controller/fee_controller/fee_controller.dart';
import 'package:new_project_driving/model/student_model/student_model.dart';
import 'package:new_project_driving/view/users/admin/screens/fess_and_bills/unpaid_std/unpaid_std_datalist.dart';
import 'package:new_project_driving/view/widget/loading_widget/loading_widget.dart';
import 'package:new_project_driving/view/widget/responsive/responsive.dart';
import 'package:new_project_driving/view/widget/reusable_table_widgets/category_table_header.dart';

class UnpaidStudentDataTable extends StatelessWidget {
  UnpaidStudentDataTable({super.key});
  final FeeController feeController = Get.put(FeeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Container(
            width:
                ResponsiveWebSite.isDesktop(context) ? double.infinity : 1200,
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
                          child: CatrgoryTableHeaderWidget(headerTitle: 'No')),
                      SizedBox(width: 2),
                      Expanded(
                          flex: 4,
                          child: CatrgoryTableHeaderWidget(
                              headerTitle: 'Student Name')),
                      SizedBox(width: 2),
                      Expanded(
                          flex: 2,
                          child: CatrgoryTableHeaderWidget(
                              headerTitle: 'Joining Date')),
                      SizedBox(width: 2),
                      Expanded(
                          flex: 3,
                          child: CatrgoryTableHeaderWidget(
                              headerTitle: 'Student Batch')),
                      SizedBox(width: 2),
                      Expanded(
                          flex: 3,
                          child: CatrgoryTableHeaderWidget(
                              headerTitle: 'Student Courses')),
                      SizedBox(width: 2),
                      Expanded(
                          flex: 2,
                          child: CatrgoryTableHeaderWidget(
                              headerTitle: 'Pending Amount')),
                      SizedBox(width: 2),
                      Expanded(
                          flex: 2,
                          child: CatrgoryTableHeaderWidget(
                              headerTitle: 'Amount Paid')),
                      SizedBox(width: 2),
                      Expanded(
                          flex: 2,
                          child: CatrgoryTableHeaderWidget(
                              headerTitle: 'Total Amount')),
                      SizedBox(width: 2),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 8, left: 8, right: 8, top: 2),
                    child: FutureBuilder<Map<String, Map<String, dynamic>>>(
                      future: feeController.onTapBtach.value == true
                          ? feeController.fetchBatchStudents()
                          : feeController.fetchUnpaidStudents(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const LoadingWidget();
                        }
                        if (snapshot.hasError) {
                          return Center(
                              child:
                                  Text('Error: ${snapshot.error.toString()}'));
                        }

                        final studentsWithFeeData =
                            snapshot.data?.values.toList() ?? [];

                        if (studentsWithFeeData.isNotEmpty) {
                          return ListView.separated(
                            itemCount: studentsWithFeeData.length,
                            itemBuilder: (context, index) {
                              final studentData = studentsWithFeeData[index];
                              final studentModel =
                                  studentData['studentModel'] as StudentModel;
                              final amountPaid = studentData['amountPaid'];
                              final totalAmount = studentData['totalAmount'];
                              final pendingAmount = totalAmount - amountPaid;

                              return UnpaidStudentDatalist(
                                stdData: studentModel,
                                index: index,
                                amountPaid: amountPaid,
                                pendingAmount: pendingAmount,
                                totalAmount: totalAmount,
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 2),
                          );
                        } else {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "No students added to fees collection",
                                style: TextStyle(fontWeight: FontWeight.w400),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
