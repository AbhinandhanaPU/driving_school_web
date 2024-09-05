import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/constant/constant.validate.dart';
import 'package:new_project_driving/controller/admin_section/student_controller/student_controller.dart';
import 'package:new_project_driving/model/batch_model/batch_model.dart';
import 'package:new_project_driving/model/student_model/student_model.dart';
import 'package:new_project_driving/utils/firebase/firebase.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';
import 'package:new_project_driving/view/widget/reusable_table_widgets/data_container.dart';

class UnpaidStudentDatalist extends StatelessWidget {
  final StudentModel stdData;
  final double amountPaid;
  final double totalAmount;
  final double pendingAmount;
  final int index;
  const UnpaidStudentDatalist({
    required this.index,
    required this.stdData,
    super.key,
    required this.amountPaid,
    required this.totalAmount,
    required this.pendingAmount,
  });

  @override
  Widget build(BuildContext context) {
    StudentController studentController = Get.put(StudentController());
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: index % 2 == 0
            ? const Color.fromARGB(255, 246, 246, 246)
            : Colors.blue[50],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: DataContainerWidget(
                rowMainAccess: MainAxisAlignment.center,
                color: cWhite,
                index: index,
                headerTitle: '${index + 1}'), //....................No
          ),
          const SizedBox(
            width: 02,
          ),
          Expanded(
            flex: 3,
            child: DataContainerWidget(
                rowMainAccess: MainAxisAlignment.start,
                color: cWhite,
                index: index,
                headerTitle: stdData.studentName),
          ),
          const SizedBox(
            width: 02,
          ),
          Expanded(
            flex: 2,
            child: DataContainerWidget(
                rowMainAccess: MainAxisAlignment.center,
                color: cWhite,
                index: index,
                headerTitle: stringTimeToDateConvert(stdData.joiningDate)),
          ),
          const SizedBox(
            width: 02,
          ),
          Expanded(
            flex: 2,
            child: FutureBuilder(
              future: server
                  .collection('DrivingSchoolCollection')
                  .doc(UserCredentialsController.schoolId)
                  .collection('Batch')
                  .doc(stdData.batchId)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  log('Error fetching batch data: ${snapshot.error}');
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || !snapshot.data!.exists) {
                  log('No data found for batchId: ${stdData.batchId}');
                  return const Text('Batch Not Found');
                } else {
                  final batchData = BatchModel.fromMap(snapshot.data!.data()!);
                  String batchName = batchData.batchName.isEmpty
                      ? "Not found"
                      : batchData.batchName;
                  log('Batch name for batchId ${stdData.batchId}: $batchName');
                  return Expanded(
                    child: DataContainerWidget(
                      color: cWhite,
                      index: index,
                      headerTitle: batchName,
                      rowMainAccess: MainAxisAlignment.center,
                    ),
                  );
                }
              },
            ),
          ),
          const SizedBox(
            width: 02,
          ),
          Expanded(
            flex: 2,
            child: FutureBuilder<List<String>>(
              future: studentController.fetchStudentsCourse(stdData),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return DataContainerWidget(
                    rowMainAccess: MainAxisAlignment.center,
                    color: cWhite,
                    index: index,
                    headerTitle: 'Course Not Found',
                  );
                } else {
                  String courses = snapshot.data!.join(', ');
                  return DataContainerWidget(
                    rowMainAccess: MainAxisAlignment.center,
                    color: cWhite,
                    index: index,
                    headerTitle: courses,
                  );
                }
              },
            ),
          ),
          const SizedBox(
            width: 02,
          ),
          Expanded(
            flex: 2,
            child: DataContainerWidget(
                rowMainAccess: MainAxisAlignment.center,
                color: cWhite,
                index: index,
                headerTitle: pendingAmount.toString()),
          ),
          const SizedBox(
            width: 02,
          ),
          Expanded(
            flex: 2,
            child: DataContainerWidget(
                rowMainAccess: MainAxisAlignment.center,
                color: cWhite,
                index: index,
                headerTitle: amountPaid.toString()),
          ),
          const SizedBox(
            width: 02,
          ),
          Expanded(
              flex: 2,
              child: DataContainerWidget(
                rowMainAccess: MainAxisAlignment.center,
                color: cWhite,
                index: index,
                headerTitle: totalAmount.toString(),
              )),
          const SizedBox(
            width: 02,
          ),
        ],
      ),
    );
  }
}
