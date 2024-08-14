import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/controller/course_controller/course_controller.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/model/student_model/student_model.dart';
import 'package:new_project_driving/utils/firebase/firebase.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';
import 'package:new_project_driving/view/users/admin/screens/courses/crud_functions/add_studentfunction.dart';
import 'package:new_project_driving/view/users/admin/screens/courses/on_click_course/student_datalist.dart';
import 'package:new_project_driving/view/users/admin/screens/courses/regi_std/req_std_list.dart';
import 'package:new_project_driving/view/widget/button_container_widget/button_container_widget.dart';
import 'package:new_project_driving/view/widget/responsive/responsive.dart';
import 'package:new_project_driving/view/widget/reusable_table_widgets/category_table_header.dart';
import 'package:new_project_driving/view/widget/routeSelectedTextContainer/routeSelectedTextContainer.dart';
import 'package:new_project_driving/view/widget/routeSelectedTextContainer/route_NonSelectedContainer.dart';

class StudentsInCoursesDetails extends StatelessWidget {
  StudentsInCoursesDetails({super.key});
  final CourseController courseController = Get.put(CourseController());

  @override
  Widget build(BuildContext context) {
    //final data = courseController.courseModelData.value;
    final courseid = courseController.ontapCourseDocID.value;

    //  print('Course ID: ${data?.courseId}');

    // if (data == null) {
    //   return const Center(child: Text('Course data is not available'));
    // }

    return Obx(() => courseController.ontapReqStudent.value == true
        ? ReqStudentsInCourses()
        : SingleChildScrollView(
            scrollDirection: ResponsiveWebSite.isMobile(context)
                ? Axis.horizontal
                : Axis.vertical,
            child: Container(
              color: screenContainerbackgroundColor,
              height: 650,
              width:
                  ResponsiveWebSite.isDesktop(context) ? double.infinity : 1200,
              padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Students List ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 10),
                    child: Row(
                      children: [
                        RouteSelectedTextContainer(
                            width: 180,
                            title: courseController.ontapCourseName.toString()),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            courseController.ontapReqStudent.value = true;
                          },
                          child: const RouteSelectedTextContainer(
                              width: 200,
                              title: 'View Students Payment Request'),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            addStudentToCourse(context,
                                courseController.ontapCourseDocID.value);
                          },
                          child: ButtonContainerWidget(
                              curving: 30,
                              colorindex: 0,
                              height: 40,
                              width: 180,
                              child: const Center(
                                child: TextFontWidgetRouter(
                                  text: 'ADD STUDENT',
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
                    padding: const EdgeInsets.only(bottom: 10),
                    child: GestureDetector(
                      onTap: () {
                        courseController.ontapStudentDetail.value = false;
                      },
                      child: const SizedBox(
                        height: 35,
                        width: 100,
                        child: Padding(
                          padding: EdgeInsets.only(top: 05, left: 05),
                          child: RouteNonSelectedTextContainer(
                            title: 'Back',
                          ),
                        ),
                      ),
                    ),
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
                                child: CatrgoryTableHeaderWidget(
                                    headerTitle: 'No')),
                            SizedBox(
                              width: 01,
                            ),
                            Expanded(
                                flex: 2,
                                child: CatrgoryTableHeaderWidget(
                                    headerTitle: 'License No.')),
                            SizedBox(
                              width: 01,
                            ),
                            Expanded(
                                flex: 3,
                                child: CatrgoryTableHeaderWidget(
                                    headerTitle: 'Name')),
                            SizedBox(
                              width: 02,
                            ),
                            Expanded(
                                flex: 3,
                                child: CatrgoryTableHeaderWidget(
                                    headerTitle: 'E mail')),
                            SizedBox(
                              width: 02,
                            ),
                            Expanded(
                                flex: 2,
                                child: CatrgoryTableHeaderWidget(
                                    headerTitle: 'Ph.No')),
                            SizedBox(
                              width: 02,
                            ),
                            Expanded(
                                flex: 2,
                                child: CatrgoryTableHeaderWidget(
                                    headerTitle: 'Level')),
                            SizedBox(
                              width: 02,
                            ),
                            Expanded(
                                flex: 3,
                                child: CatrgoryTableHeaderWidget(
                                    headerTitle: 'Fees Status')),
                            SizedBox(
                              width: 02,
                            ),
                            Expanded(
                                flex: 2,
                                child: CatrgoryTableHeaderWidget(
                                    headerTitle: 'Delete')),
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
                      child: StreamBuilder(
                          stream: server
                              .collection('DrivingSchoolCollection')
                              .doc(UserCredentialsController.schoolId)
                              .collection('Courses')
                              .doc(courseid)
                              .collection("Students")
                              //  .orderBy('studentName')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            // ignore: prefer_is_empty
                            if (snapshot.data!.docs.length == 0) {
                              return const Center(
                                  child: Text(
                                'No Students',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ));
                            }
                            return ListView.separated(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                final data = StudentModel.fromMap(
                                    snapshot.data!.docs[index].data());
                                return AllCourseStudentDataList(
                                    data: data, index: index);
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 02,
                              ),
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ));
  }
}
