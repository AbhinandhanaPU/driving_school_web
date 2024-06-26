import 'package:flutter/material.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/model/teacher_model/teacher_model.dart';
import 'package:new_project_driving/utils/firebase/firebase.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';
import 'package:new_project_driving/view/users/admin/screens/tutor/create_tutor/create_new_tutor.dart';
import 'package:new_project_driving/view/users/admin/screens/tutor/tutor_data_list.dart';
import 'package:new_project_driving/view/widget/loading_widget/loading_widget.dart';
import 'package:new_project_driving/view/widget/responsive/responsive.dart';
import 'package:new_project_driving/view/widget/reusable_table_widgets/category_table_header.dart';
import 'package:new_project_driving/view/widget/routeSelectedTextContainer/routeSelectedTextContainer.dart';

class AllTeacherRegistrationList extends StatelessWidget {
  const AllTeacherRegistrationList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection:
          ResponsiveWebSite.isMobile(context) ? Axis.horizontal : Axis.vertical,
      child: Container(
        color: screenContainerbackgroundColor,
        height: 600,
        width: ResponsiveWebSite.isDesktop(context) ? double.infinity : 1200,
        child: Padding(
          padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextFontWidget(
                text: 'All Tutor List 📃',
                fontsize: 18,
                fontWeight: FontWeight.bold,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
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
                              child:
                                  CatrgoryTableHeaderWidget(headerTitle: 'No')),
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
              ),
              Container(
                height: 400,
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
                        if (snaPS.hasData) {
                          return ListView.separated(
                              itemBuilder: (context, index) {
                                final data = TeacherModel.fromMap(
                                    snaPS.data!.docs[index].data());
                                return GestureDetector(
                                  onTap: () {
                                    // teacherController.teacherModelData.value =
                                    //     data;
                                    // teacherController.ontapviewteacher.value =
                                    //     true;
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
              Expanded(
                  child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      createTeacherFunction(context);
                    },
                    child: const SizedBox(
                      height: 30,
                      child:
                          RouteSelectedTextContainer(title: 'Create Teacher'),
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
