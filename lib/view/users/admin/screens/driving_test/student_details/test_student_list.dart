import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/controller/test_controller/test_controller.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/model/student_model/student_model.dart';
import 'package:new_project_driving/view/users/admin/screens/driving_test/student_details/test_add_students.dart';
import 'package:new_project_driving/view/users/admin/screens/driving_test/student_details/test_std_data_list.dart';
import 'package:new_project_driving/view/widget/button_container_widget/button_container_widget.dart';
import 'package:new_project_driving/view/widget/loading_widget/loading_widget.dart';
import 'package:new_project_driving/view/widget/responsive/responsive.dart';
import 'package:new_project_driving/view/widget/reusable_table_widgets/category_table_header.dart';
import 'package:new_project_driving/view/widget/routeSelectedTextContainer/routeSelectedTextContainer.dart';

class TestStudentListContainer extends StatelessWidget {
  TestStudentListContainer({super.key});
  final TestController testController = Get.put(TestController());

  @override
  Widget build(BuildContext context) {
    final testData = testController.testModelData.value;
    // log(testController.testId.value);
    // print('Test ID: ${testData?.docId}');

    if (testData == null) {
      return const Center(child: Text('Test data is not available'));
    }

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
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: GestureDetector(
                      onTap: () {},
                      child: ButtonContainerWidget(
                        curving: 0,
                        colorindex: 6,
                        height: 35,
                        width: 180,
                        child: const Center(
                          child: TextFontWidgetRouter(
                            text: 'Notify Students',
                            fontsize: 12,
                            fontWeight: FontWeight.bold,
                            color: cWhite,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      addStudents(context, testData.docId);
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
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                color: cWhite,
                child: const Padding(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: SizedBox(
                    height: 40,
                    child: Row(
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
                          flex: 3,
                          child:
                              CatrgoryTableHeaderWidget(headerTitle: 'Result'),
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
                  decoration: BoxDecoration(
                    color: cWhite,
                    border: Border.all(color: cWhite),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5, left: 5),
                    child: StreamBuilder<List<StudentModel>>(
                      stream: testController
                          .fetchStudentsWithStatusTrue(testData.docId),
                      builder: (context, studentSnapshot) {
                        if (studentSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const LoadingWidget();
                        }
                        if (studentSnapshot.hasError) {
                          return Center(
                              child: Text(
                                  'Error: ${studentSnapshot.error.toString()}'));
                        }
                        final students = studentSnapshot.data ?? [];
                        if (students.isEmpty) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Please add Students",
                                style: TextStyle(fontWeight: FontWeight.w400),
                              ),
                            ),
                          );
                        }
                        return ListView.separated(
                          itemBuilder: (context, index) {
                            return TestStdDataList(
                              data: students[index],
                              index: index,
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 2);
                          },
                          itemCount: students.length,
                        );
                      },
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
