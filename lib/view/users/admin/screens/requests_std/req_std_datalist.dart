import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/controller/fee_controller/fee_controller.dart';
import 'package:new_project_driving/fonts/google_poppins_widget.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/model/course_model/course_model.dart';
import 'package:new_project_driving/model/student_model/student_model.dart';
import 'package:new_project_driving/utils/firebase/firebase.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';
import 'package:new_project_driving/view/widget/custom_showdialouge/custom_showdilog.dart';
import 'package:new_project_driving/view/widget/dropdown_widget/std_fees_level/std_fees_level.dart';
import 'package:new_project_driving/view/widget/reusable_table_widgets/data_container.dart';

class ReqStudentDataList extends StatelessWidget {
  final int index;
  final StudentModel studentModel;
  final CourseModel courseModel;
  ReqStudentDataList({
    required this.index,
    required this.studentModel,
    super.key,
    required this.courseModel,
  });
  final FeeController feeController = Get.put(FeeController());

  @override
  Widget build(BuildContext context) {
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
                  child: DataContainerWidget(
                      rowMainAccess: MainAxisAlignment.center,
                      color: cWhite,
                      index: index,
                      headerTitle: studentModel.studentName),
                ),
              ],
            ),
          ), //........................................... teacher Name
          const SizedBox(
            width: 02,
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                SizedBox(
                  width: 15,
                  child: Center(
                    child: Image.asset(
                      'webassets/png/gmail.png',
                    ),
                  ),
                ),
                Expanded(
                    child: TextFontWidget(
                  text: studentModel.studentemail,
                  fontsize: 12,
                  overflow: TextOverflow.ellipsis,
                )),
              ],
            ),
          ), // ................................... teacher Email
          const SizedBox(
            width: 02,
          ),
          Expanded(
            flex: 2,
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
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: DataContainerWidget(
                      rowMainAccess: MainAxisAlignment.center,
                      color: cWhite,
                      index: index,
                      headerTitle: studentModel.phoneNumber),
                ),
              ],
            ),
          ), //....................................... teacher Phone Number
          const SizedBox(
            width: 02,
          ),
          Expanded(
            flex: 3,
            child: DataContainerWidget(
              rowMainAccess: MainAxisAlignment.center,
              color: cWhite,
              index: index,
              headerTitle: courseModel.courseName,
            ),
          ), //................................................. course
          const SizedBox(
            width: 02,
          ),

          Expanded(
            flex: 2,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  customShowDilogBox2(
                    context: context,
                    title: 'Approval Status ',
                    children: [
                      const Text(
                          'Are you sure you want to accept offline payment request?')
                    ],
                    doyouwantActionButton: true,
                    actiononTapfuction: () {
                      Navigator.pop(context);
                      approvalDialogBox(context, courseModel, studentModel);
                    },
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 15,
                      child: Image.asset('webassets/png/active.png'),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    DataContainerWidget(
                        rowMainAccess: MainAxisAlignment.center,
                        color: cWhite,
                        index: index,
                        headerTitle: 'Accept'),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 02,
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  customShowDilogBox2(
                    context: context,
                    title: 'Approval Status',
                    children: [
                      const Text(
                          'Are you sure you want to decline offline payment request?')
                    ],
                    doyouwantActionButton: true,
                    actiononTapfuction: () {
                      Navigator.pop(context);
                      feeController.declineStudentToCourse(
                          studentModel, courseModel.courseId);
                    },
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 15,
                      child: Image.asset('webassets/png/shape.png'),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    DataContainerWidget(
                        rowMainAccess: MainAxisAlignment.center,
                        color: cWhite,
                        index: index,
                        headerTitle: 'Decline'),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 02,
          ),
        ],
      ),
    );
  }
}

approvalDialogBox(
  BuildContext context,
  CourseModel modelData,
  StudentModel data,
) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: cWhite,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back)),
            const SizedBox(
              width: 10,
            ),
            const TextFontWidget(
              text: "Payement Status",
              fontsize: 17,
              fontWeight: FontWeight.bold,
            )
          ],
        ),
        content: SizedBox(
          height: 80,
          width: 150,
          child: Column(
            children: [
              StreamBuilder(
                stream: server
                    .collection('DrivingSchoolCollection')
                    .doc(UserCredentialsController.schoolId)
                    .collection('FeesCollection')
                    .doc(data.batchId)
                    .collection('Courses')
                    .doc(modelData.courseId)
                    .collection('Students')
                    .doc(data.docid)
                    .snapshots(),
                builder: (context, snapshot) {
                  String feeStatus = 'not paid';
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasData && snapshot.data?.data() != null) {
                    final feeData = snapshot.data!.data();
                    feeStatus = feeData!['feeStatus'] ?? 'not paid';
                  }
                  return StdFeesLevelDropDown(
                    data: data,
                    course: modelData,
                    feeData: feeStatus,
                  );
                },
              ),
            ],
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 30,
              width: 80,
              decoration: const BoxDecoration(
                color: themeColorBlue,
              ),
              child: Center(
                child: GooglePoppinsWidgets(
                    text: 'Cancel',
                    color: cWhite,
                    fontsize: 12,
                    fontWeight: FontWeight.w500),
              ),
            ),
          )
        ],
      );
    },
  );
}
