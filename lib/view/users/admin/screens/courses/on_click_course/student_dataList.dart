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
    final modelData = courseController.courseModelData.value;
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
            child: StudentLevelDropDown(
              data: data,
              courseID: modelData!.courseId,
            ),
          ), //................................................. dropdwn
          const SizedBox(
            width: 02,
          ),
          Expanded(
            flex: 3,
            child: StreamBuilder(
              stream: server
                  .collection('DrivingSchoolCollection')
                  .doc(UserCredentialsController.schoolId)
                  .collection('FeeCollection')
                  .doc(modelData.courseId)
                  .collection('Students')
                  .doc(data.docid)
                  .snapshots(),
              builder: (context, snapshot) {
                String feeStatus = 'not paid';
                bool isActive = false;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

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
                  course: modelData,
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
                      courseController
                          .deleteStudentsFromCourse(data)
                          .then((value) {
                        Navigator.pop(context);
                      });
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
