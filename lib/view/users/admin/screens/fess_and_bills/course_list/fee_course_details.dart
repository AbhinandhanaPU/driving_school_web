import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/controller/course_controller/course_controller.dart';
import 'package:new_project_driving/model/course_model/course_model.dart';
import 'package:new_project_driving/utils/firebase/firebase.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';
import 'package:new_project_driving/view/users/admin/screens/fess_and_bills/course_list/fee_courses_data_list.dart';
import 'package:new_project_driving/view/users/admin/screens/fess_and_bills/std_fees/std_fee_details.dart';
import 'package:new_project_driving/view/widget/responsive/responsive.dart';
import 'package:new_project_driving/view/widget/reusable_table_widgets/category_table_header.dart';
import 'package:new_project_driving/view/widget/routeSelectedTextContainer/routeSelectedTextContainer.dart';

class FeeCoursesDetails extends StatelessWidget {
  FeeCoursesDetails({super.key});

  final CourseController courseController = Get.put(CourseController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return courseController.ontapStudentDetail.value == true
            ? StudentsFeesStatus()
            : SingleChildScrollView(
                scrollDirection: ResponsiveWebSite.isMobile(context)
                    ? Axis.horizontal
                    : Axis.vertical,
                child: Container(
                  color: screenContainerbackgroundColor,
                  height: 650,
                  width: ResponsiveWebSite.isDesktop(context)
                      ? double.infinity
                      : 1200,
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Fees ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 10, top: 10),
                        child: Row(
                          children: [
                            RouteSelectedTextContainer(
                                width: 180, title: 'All Courses'),
                          ],
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
                                  width: 02,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: CatrgoryTableHeaderWidget(
                                      headerTitle: 'Course Type'),
                                ),
                                SizedBox(
                                  width: 01,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: CatrgoryTableHeaderWidget(
                                      headerTitle: 'Duration(In Days)'),
                                ),
                                SizedBox(
                                  width: 02,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: CatrgoryTableHeaderWidget(
                                      headerTitle: 'Rate'),
                                ),
                                SizedBox(
                                  width: 02,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: CatrgoryTableHeaderWidget(
                                      headerTitle: 'Total Students'),
                                ),
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
                                .collection('FeeCollection')
                                .snapshots(),
                            builder: (context, snapS) {
                              if (snapS.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              if (snapS.data == null ||
                                  snapS.data!.docs.isEmpty) {
                                return const Center(
                                  child: Text(
                                    'No courses',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                );
                              }

                              return ListView.separated(
                                itemCount: snapS.data!.docs.length,
                                itemBuilder: (context, index) {
                                  final fee = snapS.data!.docs[index].data();
                                  final courseId = fee['docId'];
                                  return StreamBuilder(
                                    stream: server
                                        .collection('DrivingSchoolCollection')
                                        .doc(UserCredentialsController.schoolId)
                                        .collection('Courses')
                                        .doc(courseId)
                                        .snapshots(),
                                    builder: (context, courseSnapshot) {
                                      if (courseSnapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      }
                                      if (!courseSnapshot.hasData ||
                                          !courseSnapshot.data!.exists) {
                                        return const SizedBox.shrink();
                                      }

                                      final data = CourseModel.fromMap(
                                          courseSnapshot.data!.data()!);
                                      return GestureDetector(
                                        onTap: () {
                                          courseController.setCourseData(data);
                                          courseController
                                              .ontapStudentDetail.value = true;
                                          courseController.ontapCourseName
                                              .value = data.courseName;
                                          courseController.ontapCourseDocID
                                              .value = data.courseId;
                                        },
                                        child: FeeCoursesDataList(
                                            data: data, index: index),
                                      );
                                    },
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 2),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
      },
    );
  }
}
