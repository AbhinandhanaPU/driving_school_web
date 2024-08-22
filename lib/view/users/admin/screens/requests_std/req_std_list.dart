import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/controller/admin_section/student_controller/student_controller.dart';
import 'package:new_project_driving/model/course_model/course_model.dart';
import 'package:new_project_driving/model/student_model/student_model.dart';
import 'package:new_project_driving/view/users/admin/screens/requests_std/req_std_datalist.dart';
import 'package:new_project_driving/view/widget/loading_widget/loading_widget.dart';
import 'package:new_project_driving/view/widget/responsive/responsive.dart';
import 'package:new_project_driving/view/widget/reusable_table_widgets/category_table_header.dart';

class ReqStudentsInCourses extends StatelessWidget {
  ReqStudentsInCourses({super.key});
  final StudentController studentController = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection:
          ResponsiveWebSite.isMobile(context) ? Axis.horizontal : Axis.vertical,
      child: Container(
        color: screenContainerbackgroundColor,
        height: 650,
        width: ResponsiveWebSite.isDesktop(context) ? double.infinity : 1200,
        padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Requested Students List ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
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
                          child: CatrgoryTableHeaderWidget(headerTitle: 'No')),
                      SizedBox(
                        width: 02,
                      ),
                      Expanded(
                          flex: 3,
                          child:
                              CatrgoryTableHeaderWidget(headerTitle: 'Name')),
                      SizedBox(
                        width: 02,
                      ),
                      Expanded(
                          flex: 3,
                          child:
                              CatrgoryTableHeaderWidget(headerTitle: 'Email')),
                      SizedBox(
                        width: 02,
                      ),
                      Expanded(
                          flex: 2,
                          child:
                              CatrgoryTableHeaderWidget(headerTitle: 'Ph.No')),
                      SizedBox(
                        width: 02,
                      ),
                      Expanded(
                          flex: 3,
                          child: CatrgoryTableHeaderWidget(
                              headerTitle: 'Requested Course')),
                      SizedBox(
                        width: 02,
                      ),
                      Expanded(
                          flex: 2,
                          child:
                              CatrgoryTableHeaderWidget(headerTitle: 'Accept')),
                      SizedBox(
                        width: 02,
                      ),
                      Expanded(
                          flex: 2,
                          child:
                              CatrgoryTableHeaderWidget(headerTitle: 'Decline')),
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
                width: ResponsiveWebSite.isDesktop(context)
                    ? double.infinity
                    : 1200,
                padding: const EdgeInsets.only(left: 5, right: 5),
                decoration: BoxDecoration(
                  color: cWhite,
                  border: Border.all(color: cWhite),
                ),
                child: StreamBuilder<List<Map<String, dynamic>>>(
                  stream: studentController.streamStudentsFromAllCourses(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const LoadingWidget();
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                          child: Text("No students Requested to Join Courses"));
                    } else {
                      final studentCourseList = snapshot.data!;
                      return ListView.separated(
                        itemCount: studentCourseList.length,
                        itemBuilder: (context, index) {
                          final course =
                              studentCourseList[index]["course"] as CourseModel;
                          final student = studentCourseList[index]["student"]
                              as StudentModel;
                          return ReqStudentDataList(
                              studentModel: student,
                              courseModel: course,
                              index: index);
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 02),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
