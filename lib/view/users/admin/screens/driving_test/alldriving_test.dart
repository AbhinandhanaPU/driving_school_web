import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/controller/notification_controller/notification_controller.dart';
import 'package:new_project_driving/controller/test_controller/test_controller.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/model/test_model/test_model.dart';
import 'package:new_project_driving/utils/firebase/firebase.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';
import 'package:new_project_driving/view/users/admin/screens/driving_test/student_details/test_student_list.dart';
import 'package:new_project_driving/view/users/admin/screens/driving_test/test_details/schedule_test.dart';
import 'package:new_project_driving/view/users/admin/screens/driving_test/test_details/test_data_list.dart';
import 'package:new_project_driving/view/widget/button_container_widget/button_container_widget.dart';
import 'package:new_project_driving/view/widget/loading_widget/loading_widget.dart';
import 'package:new_project_driving/view/widget/responsive/responsive.dart';
import 'package:new_project_driving/view/widget/reusable_table_widgets/category_table_header.dart';
import 'package:new_project_driving/view/widget/routeSelectedTextContainer/routeSelectedTextContainer.dart';

class AllDrivingTestDetails extends StatelessWidget {
  AllDrivingTestDetails({super.key});
  final TestController testController = Get.put(TestController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => testController.onTapTest.value == true
          ? TestStudentListContainer()
          : SingleChildScrollView(
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextFontWidget(
                            text: 'Test details',
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
                            title: 'All Tests',
                            width: 200,
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: GestureDetector(
                              onTap: () {
                                Get.find<NotificationController>().fetchDrivingTestAllUsers(
                                  bodyText: 'Location',
                                  titleText: 'Drivning Test Notification',
                                );
                              },
                              child: ButtonContainerWidget(
                                  curving: 0,
                                  colorindex: 6,
                                  height: 35,
                                  width: 180,
                                  child: const Center(
                                    child: TextFontWidgetRouter(
                                      text: 'Notify Test Date',
                                      fontsize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: cWhite,
                                    ),
                                  )),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              sheduleTestDate(context);
                            },
                            child: ButtonContainerWidget(
                              curving: 30,
                              colorindex: 0,
                              height: 40,
                              width: 180,
                              child: const Center(
                                child: TextFontWidgetRouter(
                                  text: 'Add Test Schedule',
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
                                    headerTitle: 'No',
                                  ),
                                ),
                                SizedBox(
                                  width: 02,
                                ),
                                Expanded(
                                  flex: 3,
                                  child: CatrgoryTableHeaderWidget(
                                    headerTitle: 'Date',
                                  ),
                                ),
                                SizedBox(
                                  width: 02,
                                ),
                                Expanded(
                                  flex: 3,
                                  child: CatrgoryTableHeaderWidget(
                                    headerTitle: 'Time',
                                  ),
                                ),
                                SizedBox(
                                  width: 02,
                                ),
                                Expanded(
                                  flex: 3,
                                  child: CatrgoryTableHeaderWidget(
                                    headerTitle: 'Place',
                                  ),
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
                                  flex: 2,
                                  child: CatrgoryTableHeaderWidget(
                                    headerTitle: 'Edit',
                                  ),
                                ),
                                SizedBox(
                                  width: 02,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: CatrgoryTableHeaderWidget(
                                    headerTitle: 'Delete',
                                  ),
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
                            child: SizedBox(
                              child: StreamBuilder(
                                stream: server
                                    .collection('DrivingSchoolCollection')
                                    .doc(UserCredentialsController.schoolId)
                                    .collection('DrivingTest')
                                    .snapshots(),
                                builder: (context, snaPS) {
                                  if (snaPS.hasData) {
                                    return snaPS.data!.docs.isEmpty
                                        ? const Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                "Please schedule test",
                                                style: TextStyle(fontWeight: FontWeight.w400),
                                              ),
                                            ),
                                          )
                                        : ListView.separated(
                                            itemBuilder: (context, index) {
                                              final data =
                                                  TestModel.fromMap(snaPS.data!.docs[index].data());
                                              return GestureDetector(
                                                onTap: () {
                                                  testController.onTapTest.value = true;
                                                  testController.testModelData.value = data;
                                                },
                                                child: TestDataList(
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
                                            itemCount: snaPS.data!.docs.length,
                                          );
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
