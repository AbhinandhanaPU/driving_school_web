import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/controller/admin_section/Tutor_controller/tutor_controller.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/model/teacher_model/teacher_model.dart';
import 'package:new_project_driving/utils/firebase/firebase.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';
import 'package:new_project_driving/view/users/admin/screens/tutor/tutor_data_list.dart';
import 'package:new_project_driving/view/users/admin/screens/tutor/tutor_details.dart';
import 'package:new_project_driving/view/widget/loading_widget/loading_widget.dart';
import 'package:new_project_driving/view/widget/responsive/responsive.dart';
import 'package:new_project_driving/view/widget/reusable_table_widgets/category_table_header.dart';
import 'package:new_project_driving/view/widget/routeSelectedTextContainer/routeSelectedTextContainer.dart';

class AllTutorListContainer extends StatelessWidget {
  final TutorController teacherController = Get.put(TutorController());
  AllTutorListContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => teacherController.ontapviewTutor.value == true
          ? TutorDetailsContainer()
          : SingleChildScrollView(
              scrollDirection: ResponsiveWebSite.isMobile(context)
                  ? Axis.horizontal
                  : Axis.vertical,
              child: Container(
                color: screenContainerbackgroundColor,
                height: 700,
                width: ResponsiveWebSite.isDesktop(context)
                    ? double.infinity
                    : 1200,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextFontWidget(
                        text: 'All Teachers List',
                        fontsize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Row(
                        children: [
                          RouteSelectedTextContainer(
                              width: 150, title: 'All Teachers'),
                          Spacer(),
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
                                  width: 01,
                                ),
                                Expanded(
                                    flex: 4,
                                    child: CatrgoryTableHeaderWidget(
                                        headerTitle: 'Name')),
                                SizedBox(
                                  width: 02,
                                ),
                                Expanded(
                                    flex: 4,
                                    child: CatrgoryTableHeaderWidget(
                                        headerTitle: 'E mail')),
                                SizedBox(
                                  width: 02,
                                ),
                                Expanded(
                                    flex: 3,
                                    child: CatrgoryTableHeaderWidget(
                                        headerTitle: 'Ph.No')),
                                SizedBox(
                                  width: 02,
                                ),
                                Expanded(
                                    flex: 3,
                                    child: CatrgoryTableHeaderWidget(
                                        headerTitle: 'Licence Number')),
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
                          // width: 1200,
                          decoration: BoxDecoration(
                            color: cWhite,
                            border: Border.all(color: cWhite),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: SizedBox(
                              // width: 1100,
                              child: StreamBuilder(
                                stream: server
                                    .collection('DrivingSchoolCollection')
                                    .doc(UserCredentialsController.schoolId)
                                    .collection('Teachers')
                                    .snapshots(),
                                builder: (context, snaPS) {
                                  //  if (!snaPS.hasData || snaPS.data!.docs.isEmpty) {
                                  //     return const Center(
                                  //         child: Text(
                                  //       'No Teachers Added',
                                  //       style: TextStyle(
                                  //           fontSize: 15, fontWeight: FontWeight.w500),
                                  //     ));
                                  //   }
                                  if (snaPS.hasData) {
                                    return snaPS.data!.docs.isEmpty
                                        ? const Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                "Please create Teacher",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                          )
                                        : ListView.separated(
                                            itemBuilder: (context, index) {
                                              final data = TeacherModel.fromMap(
                                                  snaPS.data!.docs[index]
                                                      .data());
                                              return GestureDetector(
                                                onTap: () {
                                                  teacherController
                                                      .tutorModelData
                                                      .value = data;
                                                  teacherController
                                                      .ontapviewTutor
                                                      .value = true;
                                                },
                                                child: AllTutorDataList(
                                                  index: index,
                                                  data: data,
                                                ),
                                              );
                                            },
                                            separatorBuilder: (context, index) {
                                              return const SizedBox(
                                                height: 02,
                                              );
                                            },
                                            itemCount: snaPS.data!.docs.length);
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
