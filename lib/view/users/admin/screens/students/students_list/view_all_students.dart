import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/controller/admin_section/student_controller/student_controller.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/model/student_model/student_model.dart';
import 'package:new_project_driving/utils/firebase/firebase.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';
import 'package:new_project_driving/view/users/admin/screens/students/search_students/search_studentName.dart';
import 'package:new_project_driving/view/users/admin/screens/students/students_list/student_data_list.dart';
import 'package:new_project_driving/view/users/admin/screens/students/students_list/student_details.dart';
import 'package:new_project_driving/view/widget/loading_widget/loading_widget.dart';
import 'package:new_project_driving/view/widget/responsive/responsive.dart';
import 'package:new_project_driving/view/widget/reusable_table_widgets/category_table_header.dart';
import 'package:new_project_driving/view/widget/routeSelectedTextContainer/routeSelectedTextContainer.dart';

class AllStudentListContainer extends StatelessWidget {
  final StudentController studentController = Get.put(StudentController());
  // final RegistrationController regiControl = Get.put(RegistrationController());
  AllStudentListContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => studentController.ontapStudent.value == true
          ? StudentDetailsContainer()
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
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const TextFontWidget(
                            text: 'All Students List',
                            fontsize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () => searchStudentsByName(context),
                            child: Container(
                              height: 40,
                              width: 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey.withOpacity(0.2)),
                              child: const Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.search),
                                  ),
                                  TextFontWidget(
                                      text: " Search By Student Name",
                                      fontsize: 12)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Row(
                        children: [
                          RouteSelectedTextContainer(
                            title: 'All Students',
                            width: 200,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
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
                                    child: CatrgoryTableHeaderWidget(
                                        headerTitle: 'No')),
                                SizedBox(
                                  width: 02,
                                ),
                                Expanded(
                                    flex: 4,
                                    child: CatrgoryTableHeaderWidget(
                                        headerTitle: 'Name')),
                                SizedBox(
                                  width: 02,
                                ),
                                Expanded(
                                    flex: 3,
                                    child: CatrgoryTableHeaderWidget(
                                        headerTitle: 'Ph.NO')),
                                SizedBox(
                                  width: 02,
                                ),
                                Expanded(
                                    flex: 3,
                                    child: CatrgoryTableHeaderWidget(
                                        headerTitle: 'courses type')),
                                SizedBox(
                                  width: 02,
                                ),
                                Expanded(
                                    flex: 2,
                                    child: CatrgoryTableHeaderWidget(
                                        headerTitle: 'Join Date')),
                                SizedBox(
                                  width: 02,
                                ),
                                Expanded(
                                    flex: 2,
                                    child: CatrgoryTableHeaderWidget(
                                        headerTitle: 'Permission Status')),
                                SizedBox(
                                  width: 02,
                                ),
                                Expanded(
                                    flex: 2,
                                    child: CatrgoryTableHeaderWidget(
                                        headerTitle: 'Status')),
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
                          height: 400,
                          // width: 1200,
                          decoration: BoxDecoration(
                            color: cWhite,
                            border: Border.all(color: cWhite),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 5, left: 5),
                            child: SizedBox(
                              // width: 1100,
                              child: StreamBuilder(
                                stream:
                                    //  studentController.onClassWiseSearch.value ==
                                    //         true
                                    //     ? server
                                    //         .collection('DrivingSchoolCollection')
                                    //         .doc(UserCredentialsController.schoolId)
                                    //         .collection(UserCredentialsController.batchId!)
                                    //         .doc(UserCredentialsController.batchId!)
                                    //         .collection('classes')
                                    //         .doc(Get.find<ClassController>()
                                    //             .classDocID
                                    //             .value)
                                    //         .collection('Students')
                                    //         .snapshots()
                                    //     :
                                    server
                                        .collection('DrivingSchoolCollection')
                                        .doc(UserCredentialsController.schoolId)
                                        .collection('Students')
                                        .orderBy('studentName')
                                        .snapshots(),
                                builder: (context, snaPS) {
                                  if (snaPS.hasData) {
                                    return snaPS.data!.docs.isEmpty
                                        ? const Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                "Please create Students",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                          )
                                        : ListView.separated(
                                            itemBuilder: (context, index) {
                                              final data = StudentModel.fromMap(
                                                  snaPS.data!.docs[index]
                                                      .data());
                                              return GestureDetector(
                                                onTap: () {
                                                  studentController
                                                      .studentModelData
                                                      .value = data;
                                                  studentController.ontapStudent
                                                      .value = true;
                                                },
                                                child: AllStudentDataList(
                                                  data: data,
                                                  index: index,
                                                ),
                                              );
                                            },
                                            separatorBuilder: (context, index) {
                                              return const SizedBox(
                                                height: 02,
                                              );
                                            },
                                            itemCount: snaPS.data!.docs.length);
                                  } else if (snaPS.data == null) {
                                    return const LoadingWidget();
                                  } else {
                                    return const LoadingWidget();
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Future<void> searchStudentsByName(BuildContext context) async {
    studentController.fetchAllStudents();
    await showSearch(context: context, delegate: AllStudentSearchByName());
  }
}
