import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/controller/admin_section/student_controller/student_controller.dart';
import 'package:new_project_driving/controller/course_controller/course_controller.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/model/student_model/student_model.dart';
import 'package:new_project_driving/utils/firebase/firebase.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';
import 'package:new_project_driving/view/widget/custom_delete_showdialog/custom_delete_showdialog.dart';
import 'package:new_project_driving/view/widget/dropdown_widget/std_fees_level/std_fees_level.dart';
import 'package:new_project_driving/view/widget/dropdown_widget/student_level/student_level.dart';
import 'package:new_project_driving/view/widget/loading_widget/lottie_widget.dart';
import 'package:new_project_driving/view/widget/reusable_table_widgets/data_container.dart';

class AllCourseStudentDataList extends StatelessWidget {
  final int index;
  final StudentModel data;
  AllCourseStudentDataList({
    required this.index,
    required this.data,
    super.key,
  });
  final StudentController studentController = Get.put(StudentController());
  final CourseController courseController = Get.put(CourseController());

  @override
  Widget build(BuildContext context) {
    final courseModel = courseController.courseModelData.value!;
    return
        // Obx(() =>
        Container(
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
                // width: 150,
                index: index,
                headerTitle: '${index + 1}'), //....................No
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
                headerTitle: data.licenceNumber),
          ), //................................................. teacher ID
          const SizedBox(
            width: 02,
          ),
          // Expanded(
          //   flex: 2,
          //   child: DataContainerWidget(
          //       rowMainAccess: MainAxisAlignment.center,
          //       color: cWhite,
          //       index: index,
          //       headerTitle: data. place),
          // ), //................................................. teacher ID
          // const SizedBox(
          //   width: 01,
          // ),
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
                      headerTitle: data.studentName),
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
                  text: "  ${data.studentemail}",
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
                Expanded(
                  child: DataContainerWidget(
                      rowMainAccess: MainAxisAlignment.center,
                      color: cWhite,
                      index: index,
                      headerTitle: data.phoneNumber),
                ),
              ],
            ),
          ), //....................................... teacher Phone Number
          const SizedBox(
            width: 02,
          ),
          Expanded(
            flex: 2,
            child: StreamBuilder(
              stream: server
                  .collection('DrivingSchoolCollection')
                  .doc(UserCredentialsController.schoolId)
                  .collection('Courses')
                  .doc(courseModel.courseId)
                  .collection('Students')
                  .doc(data.docid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LottieLoadingWidet();
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
                String? level;
                if (snapshot.hasData && snapshot.data?.data() != null) {
                  final feeData = snapshot.data!.data();
                  level = feeData!['level'] ?? 'biginner';
                }
                return StudentLevelDropDown(
                  data: data,
                  courseID: courseModel.courseId,
                  level: level,
                );
              },
            ),
          ), //................................................. dropdwn
          const SizedBox(
            width: 02,
          ),
          Expanded(
            flex: 3,
            child: StreamBuilder(
              stream: data.batchId.isNotEmpty && data.docid.isNotEmpty
                  ? server
                      .collection('DrivingSchoolCollection')
                      .doc(UserCredentialsController.schoolId)
                      .collection('FeesCollection')
                      .doc(data.batchId)
                      .collection('Courses')
                      .doc(courseModel.courseId)
                      .collection('Students')
                      .doc(data.docid)
                      .snapshots()
                  : null,
              builder: (context, snapshot) {
                if (data.batchId.isEmpty || data.docid.isEmpty) {
                  return const Center(
                    child: Text('Batch Not Assigned'),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LottieLoadingWidet();
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
                bool isActive = false;
                String? feeStatus;
                if (snapshot.hasData && snapshot.data?.data() != null) {
                  final feeData = snapshot.data!.data();
                  feeStatus = feeData!['feeStatus'] ?? 'not paid';
                  if (feeData['active'] is String) {
                    isActive = feeData['active'] == "true";
                  } else if (feeData['active'] is bool) {
                    isActive = feeData['active'];
                  }
                }

                return StdFeesLevelDropDown(
                  data: data,
                  course: courseModel,
                  feeData: feeStatus,
                );
              },
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
                  customDeleteShowDialog(
                    context: context,
                    onTap: () {
                      courseController.deleteStudentsFromCourse(data);
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
          const SizedBox(
            width: 01,
          ), //............................. Status [Active or DeActivate]
        ],
      ),
      //  )
    );
  }
}
