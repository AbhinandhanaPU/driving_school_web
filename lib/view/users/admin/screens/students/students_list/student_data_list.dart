import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/constant/constant.validate.dart';
import 'package:new_project_driving/controller/admin_section/student_controller/student_controller.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/model/batch_model/batch_model.dart';
import 'package:new_project_driving/model/student_model/student_model.dart';
import 'package:new_project_driving/utils/firebase/firebase.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';
import 'package:new_project_driving/view/users/admin/screens/students/crud/update_std_batch.dart';
import 'package:new_project_driving/view/widget/custom_delete_showdialog/custom_delete_showdialog.dart';
import 'package:new_project_driving/view/widget/loading_widget/lottie_widget.dart';
import 'package:new_project_driving/view/widget/reusable_table_widgets/data_container.dart';

class AllStudentDataList extends StatelessWidget {
  final StudentModel data;
  final int index;

  const AllStudentDataList({
    required this.data,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    StudentController studentController = Get.put(StudentController());
    log('batchid :$index ${data.batchId},${data.studentName}');
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
                headerTitle: '  ${index + 1}'), //....................No
          ),
          const SizedBox(width: 1),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                  child: Center(
                    child: Image.asset(
                      'webassets/stickers/icons8-student-100 (1).png',
                    ),
                  ),
                ),
                Expanded(
                  child: TextFontWidget(
                    text: '  ${data.studentName}',
                    fontsize: 12,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ), //........................................... Student Name
          const SizedBox(width: 2),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                SizedBox(
                  width: 15,
                  child: Center(
                    child: Image.asset(
                      'webassets/png/telephone.png',
                    ),
                  ),
                ),
                Expanded(
                  child: TextFontWidget(
                    text: "  ${data.phoneNumber}",
                    fontsize: 12,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ), //....................................... Student Phone Number
          const SizedBox(width: 2),
          Expanded(
            flex: 3,
            child: FutureBuilder<List<String>>(
              future: studentController.fetchStudentsCourse(data),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LottieLoadingWidet();
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
          ), //............................. Student courses type
          const SizedBox(
            width: 2,
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: DataContainerWidget(
                rowMainAccess: MainAxisAlignment.center,
                color: cWhite,
                index: index,
                headerTitle: stringTimeToDateConvert(data.joiningDate),
              ),
            ),
          ), //............................. Student join date
          const SizedBox(
            width: 2,
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                data.batchId.isEmpty
                    ? Expanded(
                        child: DataContainerWidget(
                          index: index,
                          headerTitle: 'Batch not Assigned',
                          rowMainAccess: MainAxisAlignment.center,
                        ),
                      )
                    : FutureBuilder(
                        future: server
                            .collection('DrivingSchoolCollection')
                            .doc(UserCredentialsController.schoolId)
                            .collection('Batch')
                            .doc(data.batchId)
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const LottieLoadingWidet();
                          } else if (snapshot.hasError) {
                            log('Error fetching batch data: ${snapshot.error}');
                            return Text('Error: ${snapshot.error}');
                          } else if (!snapshot.hasData ||
                              !snapshot.data!.exists) {
                            log('No data found for batchId: ${data.batchId}');
                            return const Text('Batch Not Found');
                          } else {
                            final batchData =
                                BatchModel.fromMap(snapshot.data!.data()!);
                            String batchName = batchData.batchName.isEmpty
                                ? "Not found"
                                : batchData.batchName;
                            log('Batch name for batchId ${data.batchId}: $batchName');
                            return Expanded(
                              child: DataContainerWidget(
                                index: index,
                                headerTitle: batchName,
                                rowMainAccess: MainAxisAlignment.center,
                              ),
                            );
                          }
                        },
                      ),
                IconButton(
                    onPressed: () {
                      updateStudentBatch(context: context, studentModel: data);
                    },
                    icon: const Icon(
                      Icons.edit,
                      size: 18,
                      color: themeColorBlue,
                    ))
              ],
            ),
          ), //............................. Student batch
          const SizedBox(width: 2),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: DataContainerWidget(
                    index: index,
                    headerTitle:
                        data.status == true ? "  Active" : "  Inactive",
                    rowMainAccess: MainAxisAlignment.center,
                  ),
                ),
                Transform.scale(
                  scale: 0.65,
                  child: Switch(
                    activeColor: Colors.green,
                    value: data.status == true,
                    onChanged: (value) {
                      final newStatus = value ? true : false;
                      studentController.updateStudentStatus(data, newStatus);
                    },
                  ),
                ),
              ],
            ),
          ), //............................. Status [Active or DeActivate]
          const SizedBox(width: 2),
          Expanded(
            flex: 2,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  customDeleteShowDialog(
                    context: context,
                    onTap: () {
                      studentController
                          .deleteStudents(data)
                          .then((value) => Navigator.pop(context));
                    },
                  );
                },
                child: DataContainerWidget(
                    rowMainAccess: MainAxisAlignment.center,
                    color: cWhite,
                    index: index,
                    headerTitle: ' Remove 🗑️'),
              ),
            ),
          ), //........................................... delete
          const SizedBox(width: 2),
        ],
      ),
    );
  }
}
