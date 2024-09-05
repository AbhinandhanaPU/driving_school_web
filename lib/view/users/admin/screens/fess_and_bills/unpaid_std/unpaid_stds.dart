import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/controller/fee_controller/fee_controller.dart';
import 'package:new_project_driving/model/student_model/student_model.dart';
import 'package:new_project_driving/view/users/admin/screens/fess_and_bills/unpaid_std/unpaid_std_datalist.dart';
import 'package:new_project_driving/view/widget/loading_widget/loading_widget.dart';
import 'package:new_project_driving/view/widget/reusable_table_widgets/category_table_header.dart';

class UnpaidStudentDataTable extends StatelessWidget {
  UnpaidStudentDataTable({super.key});
  final FeeController feeController = Get.put(FeeController());

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            color: cWhite,
            child: Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Container(
                color: cWhite,
                height: 40,
                child: const Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: CatrgoryTableHeaderWidget(headerTitle: 'No')),
                    SizedBox(width: 2),
                    Expanded(
                        flex: 3,
                        child: CatrgoryTableHeaderWidget(
                            headerTitle: 'Student Name')),
                    SizedBox(width: 2),
                    Expanded(
                        flex: 2,
                        child: CatrgoryTableHeaderWidget(
                            headerTitle: 'Joining Date')),
                    SizedBox(width: 2),
                    Expanded(
                        flex: 2,
                        child: CatrgoryTableHeaderWidget(
                            headerTitle: 'Student Batch')),
                    SizedBox(width: 2),
                    Expanded(
                        flex: 2,
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
            ),
          ),
          Expanded(
            child: Container(
              height: 400,
              // width: 1200,
              decoration: BoxDecoration(
                color: cWhite,
                border: Border.all(color: cWhite),
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 5, left: 5),
                child: Container(
                  color: cWhite,
                  height: 40,
                  child: FutureBuilder<Map<String, Map<String, dynamic>>>(
                    future: feeController.fetchUnpaidStudents(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const LoadingWidget();
                      }
                      if (snapshot.hasError) {
                        return Center(
                            child: Text('Error: ${snapshot.error.toString()}'));
                      }

                      final unpaidStudentsWithFeeData =
                          snapshot.data?.values.toList() ?? [];

                      if (unpaidStudentsWithFeeData.isNotEmpty) {
                        return ListView.separated(
                          itemCount: unpaidStudentsWithFeeData.length,
                          itemBuilder: (context, index) {
                            final studentData =
                                unpaidStudentsWithFeeData[index];
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
            ),
          ),
        ],
      ),
    );
  }
}
