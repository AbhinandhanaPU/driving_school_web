import 'package:flutter/material.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/model/teacher_model/teacher_model.dart';
import 'package:new_project_driving/utils/firebase/firebase.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';
import 'package:new_project_driving/view/users/admin/screens/attendance/widget/data_container_marks.dart';
import 'package:new_project_driving/view/widget/loading_widget/loading_widget.dart';
import 'package:new_project_driving/view/widget/responsive/responsive.dart';
import 'package:new_project_driving/view/widget/reusable_table_widgets/category_table_header.dart';
import 'package:new_project_driving/view/widget/routeSelectedTextContainer/routeSelectedTextContainer.dart';

class AllTutorAttendance extends StatelessWidget {
  const AllTutorAttendance({super.key});

  @override
  Widget build(BuildContext context) {
    return
        //  Obx(
        //   () =>
        SingleChildScrollView(
      scrollDirection:
          ResponsiveWebSite.isMobile(context) ? Axis.horizontal : Axis.vertical,
      child: Container(
        color: screenContainerbackgroundColor,
        height: 700,
        width: ResponsiveWebSite.isDesktop(context) ? double.infinity : 1200,
        child: Padding(
          padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextFontWidget(
                text: 'Attendance List',
                fontsize: 18,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(
                height: 30,
              ),
              const Row(
                children: [
                  RouteSelectedTextContainer(
                      width: 150, title: 'Tutor Attendance'),
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
                            child:
                                CatrgoryTableHeaderWidget(headerTitle: 'No')),
                        SizedBox(
                          width: 1,
                        ),
                        Expanded(
                            flex: 6,
                            child: CatrgoryTableHeaderWidget(
                                headerTitle: "Tutor Name")),
                        SizedBox(
                          width: 1,
                        ),
                        // Expanded(flex: 2, child: CatrgoryTableHeaderWidget(headerTitle: "Class")),
                        // SizedBox(
                        //   width: 1,
                        // ),
                        Expanded(
                            flex: 2,
                            child:
                                CatrgoryTableHeaderWidget(headerTitle: "Date")),
                        SizedBox(
                          width: 1,
                        ),
                        Expanded(
                            flex: 2,
                            child:
                                CatrgoryTableHeaderWidget(headerTitle: "Time")),
                        SizedBox(
                          width: 1,
                        ),
                        // Expanded(
                        //     flex: 2, child: CatrgoryTableHeaderWidget(headerTitle: "Status from app")),
                        // SizedBox(
                        //   width: 1,
                        // ),
                        Expanded(
                            flex: 2,
                            child: CatrgoryTableHeaderWidget(
                                headerTitle: "Status from machine")),
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
                            return ListView.separated(
                              itemBuilder: (context, index) {
                                final data = TeacherModel.fromMap(
                                    snaPS.data!.docs[index].data());
                                return Container(
                                  color
                                      // : studentData['present'] == true
                                      //     ? Colors.green.withOpacity(0.1)
                                      : Colors.red.withOpacity(0.1),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: DataContainerMarksWidget(
                                            color
                                                // : studentData['present'] == true
                                                //     ? Colors.green.withOpacity(0.1)
                                                : Colors.red.withOpacity(0.1),
                                            wantColor: false,
                                            rowMainAccess:
                                                MainAxisAlignment.center,
                                            index: index,
                                            headerTitle: "${index + 1}"),
                                      ),
                                      const SizedBox(
                                        width: 1,
                                      ),
                                      Expanded(
                                        flex: 6,
                                        child: DataContainerMarksWidget(
                                            color
                                                // : studentData['present'] == true
                                                //     ? Colors.green.withOpacity(0.1)
                                                : Colors.red.withOpacity(0.1),
                                            rowMainAccess:
                                                MainAxisAlignment.start,
                                            index: index,
                                            headerTitle: //" ${studentData[
                                                data.teacherName!
                                            //   ]}"
                                            ),
                                      ),
                                      const SizedBox(
                                        width: 1,
                                      ),
                                      // Expanded(
                                      //   flex: 2,
                                      //   child: DataContainerMarksWidget(
                                      //       color
                                      //       // : studentData['present'] == true
                                      //       //     ? Colors.green.withOpacity(0.1)
                                      //           : Colors.red.withOpacity(0.1),
                                      //       rowMainAccess: MainAxisAlignment.start,
                                      //       index: index,
                                      //       headerTitle:
                                      //           " ${Get.find<ClassController>().className.value}"),
                                      // ),
                                      // const SizedBox(
                                      //   width: 1,
                                      // ),
                                      Expanded(
                                        flex: 2,
                                        child: DataContainerMarksWidget(
                                            color
                                                // : studentData['present'] == true
                                                //     ? Colors.green.withOpacity(0.1)
                                                : Colors.red.withOpacity(0.1),
                                            rowMainAccess:
                                                MainAxisAlignment.start,
                                            index: index,
                                            headerTitle: //"   $
                                                'formatted'),
                                      ),
                                      const SizedBox(
                                        width: 1,
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: DataContainerMarksWidget(
                                            color
                                                // : studentData['present'] == true
                                                //     ? Colors.green.withOpacity(0.1)
                                                : Colors.red.withOpacity(0.1),
                                            rowMainAccess:
                                                MainAxisAlignment.start,
                                            index: index,
                                            headerTitle:
                                                //  " ${stringTimeConvert(DateTime.parse(studentData[
                                                'Date'
                                            //    ]))}"
                                            ),
                                      ),
                                      const SizedBox(
                                        width: 1,
                                      ),
                                      // Expanded(
                                      //   flex: 2,
                                      //   child: DataContainerMarksWidget(
                                      //       color
                                      //       // : studentData['present'] == true
                                      //       //     ? Colors.green.withOpacity(0.1)
                                      //           : Colors.red.withOpacity(0.1),
                                      //       rowMainAccess: MainAxisAlignment.start,
                                      //       index: index,
                                      //       headerTitle
                                      //       // : studentData['present'] == true
                                      //       //     ? ' Present'
                                      //           : ' Absent'),
                                      // ),
                                      // const SizedBox(
                                      //   width: 1,
                                      // ),
                                      Expanded(
                                        flex: 2,
                                        child: DataContainerMarksWidget(
                                            color
                                                // : studentData['present'] == true
                                                //     ? Colors.green.withOpacity(0.1)
                                                : Colors.red.withOpacity(0.1),
                                            rowMainAccess:
                                                MainAxisAlignment.start,
                                            index: index,
                                            headerTitle
                                                // : studentData['present'] == true
                                                //     ? ' Present'
                                                : ' Absent'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              itemCount: snaPS.data!.docs.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 1,
                              ),
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
      //   ),
    );
  }
}
