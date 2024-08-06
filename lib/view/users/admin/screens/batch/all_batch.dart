import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/controller/batch_controller/batch_controller.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/model/batch_model/batch_model.dart';
import 'package:new_project_driving/utils/firebase/firebase.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';
import 'package:new_project_driving/view/users/admin/screens/batch/batch_std_list.dart';
import 'package:new_project_driving/view/users/admin/screens/batch/data_table_batch/batch_datalist.dart';
import 'package:new_project_driving/view/users/admin/screens/batch/functions/batch_shift.dart';
import 'package:new_project_driving/view/users/admin/screens/batch/functions/create_batch.dart';
import 'package:new_project_driving/view/widget/button_container_widget/button_container_widget.dart';
import 'package:new_project_driving/view/widget/loading_widget/loading_widget.dart';
import 'package:new_project_driving/view/widget/responsive/responsive.dart';
import 'package:new_project_driving/view/widget/reusable_table_widgets/category_table_header.dart';
import 'package:new_project_driving/view/widget/routeSelectedTextContainer/routeSelectedTextContainer.dart';

class AllBatchsListContainer extends StatelessWidget {
  AllBatchsListContainer({super.key});

  final BatchController batchController =
      Get.put(BatchController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => batchController.onTapBtach.value == true
          ? BatchStudentListContainer()
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
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextFontWidget(
                            text: 'All Batches',
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
                          const RouteSelectedTextContainer(
                            title: 'All Students',
                            width: 200,
                          ),
                          const Spacer(),
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: GestureDetector(
                              onTap: () {
                                batchShift(context);
                              },
                              child: ButtonContainerWidget(
                                  curving: 30,
                                  colorindex: 0,
                                  height: 35,
                                  width: 120,
                                  child: const Center(
                                    child: TextFontWidgetRouter(
                                      text: 'Shift Batch',
                                      fontsize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: cWhite,
                                    ),
                                  )),
                                                       ),
                           ),
                          GestureDetector(
                            onTap: () {
                              createBatchFunction(context);
                            },
                            child: ButtonContainerWidget(
                                curving: 30,
                                colorindex: 0,
                                height: 35,
                                width: 120,
                                child: const Center(
                                  child: TextFontWidgetRouter(
                                    text: 'Create Batch',
                                    fontsize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: cWhite,
                                  ),
                                )),
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
                                      headerTitle: 'No'),
                                ),
                                SizedBox(
                                  width: 02,
                                ),
                                Expanded(
                                  flex: 3,
                                  child: CatrgoryTableHeaderWidget(
                                      headerTitle: 'Batch Name'),
                                ),
                                SizedBox(
                                  width: 02,
                                ),
                               
                                Expanded(
                                  flex: 3,
                                  child: CatrgoryTableHeaderWidget(
                                      headerTitle: 'Batch Date'),
                                ),
                                SizedBox(
                                  width: 02,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: CatrgoryTableHeaderWidget(
                                    headerTitle: 'Total Students',
                                  ),
                                ),
                                SizedBox(
                                  width: 02,
                                ),
                                Expanded(
                                  flex: 3,
                                  child: CatrgoryTableHeaderWidget(
                                      headerTitle: 'Edit'),
                                ),
                                SizedBox(
                                  width: 02,
                                ),
                                Expanded(
                                  flex: 3,
                                  child: CatrgoryTableHeaderWidget(
                                      headerTitle: 'Delete'),
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
                                    .collection('Batch')
                                    .orderBy('date',descending: true)
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
                                              final data =
                                                  BatchModel.fromMap(
                                                      snaPS.data!.docs[index]
                                                          .data());
                                              return GestureDetector(
                                                onTap: () {
                                                  batchController
                                                      .onTapBtach
                                                      .value = true;
                                                  batchController
                                                      .batchId
                                                      .value = data.batchId;
                                                      batchController.ontapBatchName.value=data.batchName;
                                                },
                                                child: BatchDataList(
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
}
