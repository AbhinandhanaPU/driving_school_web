import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/controller/batch_controller/batch_controller.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/model/student_model/student_model.dart';
import 'package:new_project_driving/view/users/admin/screens/batch/data_table_batch/batch_studentsdatalist.dart';
import 'package:new_project_driving/view/users/admin/screens/batch/functions/add_students_batch.dart';
import 'package:new_project_driving/view/widget/button_container_widget/button_container_widget.dart';
import 'package:new_project_driving/view/widget/loading_widget/loading_widget.dart';
import 'package:new_project_driving/view/widget/responsive/responsive.dart';
import 'package:new_project_driving/view/widget/reusable_table_widgets/category_table_header.dart';
import 'package:new_project_driving/view/widget/routeSelectedTextContainer/routeSelectedTextContainer.dart';

class BatchStudentListContainer extends StatelessWidget {
  BatchStudentListContainer({super.key});
  final BatchController batchController = Get.put(BatchController());

  @override
  Widget build(BuildContext context) {
    // final namebth = batchController.batchModelData.value;
    log(batchController.batchId.value);

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
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFontWidget(
                    text: batchController.ontapBatchName.toString(),
                    fontsize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      batchController.onTapBtach.value = false;
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
                      addStudentsBatch(context);
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
                  const SizedBox(
                    width: 20,
                  ),
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
                          flex: 4,
                          child:
                              CatrgoryTableHeaderWidget(headerTitle: 'Course'),
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
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: StreamBuilder<List<StudentModel>>(
                      stream: batchController
                          .fetchFilteredStudents(batchController.batchId.value),
                      builder: (context, studentSnapshot) {
                        if (studentSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const LoadingWidget();
                        }
                        if (studentSnapshot.hasError) {
                          return Center(
                              child: Text('Error: ${studentSnapshot.error}'));
                        }
                        if (studentSnapshot.data == null ||
                            studentSnapshot.data!.isEmpty) {
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

                        final students = studentSnapshot.data!;

                        return ListView.separated(
                          itemBuilder: (context, index) {
                            final studentModel = students[index];
                            return BatchStdDataList(
                              data: studentModel,
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
