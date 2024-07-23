import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/controller/test_controller/test_controller.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/model/student_model/student_model.dart';
import 'package:new_project_driving/utils/firebase/firebase.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';
import 'package:new_project_driving/view/users/admin/screens/driving_test/driving_data_list.dart';
import 'package:new_project_driving/view/users/admin/screens/driving_test/student_details/add_students.dart';
import 'package:new_project_driving/view/widget/button_container_widget/button_container_widget.dart';
import 'package:new_project_driving/view/widget/loading_widget/loading_widget.dart';
import 'package:new_project_driving/view/widget/responsive/responsive.dart';
import 'package:new_project_driving/view/widget/reusable_table_widgets/category_table_header.dart';
import 'package:new_project_driving/view/widget/routeSelectedTextContainer/routeSelectedTextContainer.dart';

class DrivingStudentListContainer extends StatelessWidget {
  DrivingStudentListContainer({super.key});
  final TestController testController = Get.put(TestController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection:
          ResponsiveWebSite.isMobile(context) ? Axis.horizontal : Axis.vertical,
      child: Container(
        color: screenContainerbackgroundColor,
        height: 650,
        width: ResponsiveWebSite.isDesktop(context) ? double.infinity : 1200,
        child: Padding(
          padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFontWidget(
                    text: 'Driving Test',
                    fontsize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      testController.onTapTest.value = false;
                    },
                    child: const RouteSelectedTextContainer(
                      title: 'Back',
                      width: 100,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const RouteSelectedTextContainer(
                    title: 'Students List',
                    width: 200,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      addStudents(context);
                    },
                    child: ButtonContainerWidget(
                      curving: 30,
                      colorindex: 0,
                      height: 40,
                      width: 180,
                      child: const Center(
                        child: TextFontWidgetRouter(
                          text: 'Add Students',
                          fontsize: 14,
                          fontWeight: FontWeight.bold,
                          color: cWhite,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
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
                          child: CatrgoryTableHeaderWidget(headerTitle: 'No'),
                        ),
                        SizedBox(
                          width: 02,
                        ),
                        Expanded(
                          flex: 4,
                          child: CatrgoryTableHeaderWidget(headerTitle: 'Name'),
                        ),
                        SizedBox(
                          width: 02,
                        ),
                        Expanded(
                          flex: 3,
                          child: CatrgoryTableHeaderWidget(
                              headerTitle: 'Joining Date'),
                        ),
                        SizedBox(
                          width: 02,
                        ),
                        Expanded(
                          flex: 3,
                          child: CatrgoryTableHeaderWidget(
                              headerTitle: 'Completed Days'),
                        ),
                        SizedBox(
                          width: 02,
                        ),
                        Expanded(
                          flex: 3,
                          child: CatrgoryTableHeaderWidget(
                              headerTitle: 'Number of Attempt'),
                        ),
                        SizedBox(
                          width: 02,
                        ),
                        Expanded(
                          flex: 2,
                          child:
                              CatrgoryTableHeaderWidget(headerTitle: 'Remove'),
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
                        stream: server
                            .collection('DrivingSchoolCollection')
                            .doc(UserCredentialsController.schoolId)
                            .collection('DrivingTest')
                            .doc(testController.testId.value)
                            .collection('Students')
                            .snapshots(),
                        builder: (context, snaPS) {
                          if (snaPS.hasData) {
                            return snaPS.data!.docs.isEmpty
                                ? const Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        "Please add Students",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  )
                                : ListView.separated(
                                    itemBuilder: (context, index) {
                                      final data = StudentModel.fromMap(
                                          snaPS.data!.docs[index].data());
                                      return DrivingDataList(
                                        data: data,
                                        index: index,
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
    );
  }
}
