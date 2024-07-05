import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/controller/admin_section/student_controller/student_controller.dart';
import 'package:new_project_driving/controller/class_controller/class_controller.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/view/widget/profile_detail_widget/detail_tile_container.dart';
import 'package:new_project_driving/view/widget/responsive/responsive.dart';
import 'package:new_project_driving/view/widget/routeSelectedTextContainer/routeSelectedTextContainer.dart';
import 'package:new_project_driving/view/widget/routeSelectedTextContainer/route_NonSelectedContainer.dart';

class StudentDetailsContainer extends StatelessWidget {
  final StudentController studentController = Get.put(StudentController());
  StudentDetailsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final data = studentController.studentModelData.value;

    return DefaultTabController(
      length: 2,
      child: SingleChildScrollView(
        scrollDirection: ResponsiveWebSite.isMobile(context)
            ? Axis.horizontal
            : Axis.vertical,
        child: Container(
          color: screenContainerbackgroundColor,
          height: 1000,
          width: ResponsiveWebSite.isDesktop(context) ? double.infinity : 1200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 25, top: 25),
                child: TextFontWidget(
                  text: 'Student Details',
                  fontsize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
                child: Container(
                  color: cWhite,
                  height: 260,
                  child: Column(
                    children: [
                      Container(
                        height: 60,
                        width: double.infinity,
                        color: Colors.white10,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 0),
                          child: Column(
                            children: [
                              Get.find<ClassController>()
                                          .ontapStudentsDetail
                                          .value ==
                                      true
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 08,
                                              right: 05,
                                            ),
                                            child: GestureDetector(
                                              onTap: () {
                                                Get.find<ClassController>()
                                                    .ontapStudentsDetail
                                                    .value = false;
                                                Get.find<ClassController>()
                                                    .ontapClassStudents
                                                    .value = false;
                                                studentController
                                                    .ontapStudent.value = false;
                                              },
                                              child:
                                                  const RouteNonSelectedTextContainer(
                                                      title: 'Home'),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 08,
                                              right: 05,
                                            ),
                                            child: GestureDetector(
                                              onTap: () {
                                                Get.find<ClassController>()
                                                    .ontapStudentsDetail
                                                    .value = false;
                                              },
                                              child:
                                                  const RouteNonSelectedTextContainer(
                                                      title: 'Back'),
                                            ),
                                          ),
                                          const RouteSelectedTextContainer(
                                              width: 140,
                                              title: 'Student Deatils'),
                                        ],
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 08,
                                              right: 05,
                                            ),
                                            child: GestureDetector(
                                              onTap: () {
                                                Get.find<ClassController>()
                                                    .ontapStudentsDetail
                                                    .value = false;
                                                Get.find<ClassController>()
                                                    .ontapClassStudents
                                                    .value = false;
                                                studentController
                                                    .ontapStudent.value = false;
                                              },
                                              child:
                                                  const RouteNonSelectedTextContainer(
                                                      title: 'Home'),
                                            ),
                                          ),
                                          const RouteSelectedTextContainer(
                                              width: 140,
                                              title: 'Student Deatils'),
                                        ],
                                      ),
                                    )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.blue,
                        height: 02,
                      ),
                      Expanded(
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 05, left: 10),
                              child: CircleAvatar(
                                radius: 80,
                                backgroundColor: Colors.grey,
                                child: CircleAvatar(
                                  radius: 78,
                                  backgroundImage:
                                      AssetImage('webassets/png/student.png'),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Container(
                                      width: double.infinity,
                                      height: 100,
                                      color: Colors.blue.withOpacity(0.1),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, top: 10),
                                            child: TextFontWidget(
                                              text: data!.studentName,
                                              fontsize: 20,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20, left: 10),
                                            child: SizedBox(
                                              width: 500,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ProfileDetailTileContainer(
                                                    flex: 1,
                                                    title: 'Date of Birth',
                                                    subtitle: data.dateofBirth,
                                                  ),
                                                  ProfileDetailTileContainer(
                                                    flex: 1,
                                                    title: 'Parent/Spouse Name',
                                                    subtitle: data.guardianName,
                                                  ),
                                                  ProfileDetailTileContainer(
                                                    flex: 1,
                                                    title: 'Address',
                                                    subtitle: data.address,
                                                  ),
                                                  ProfileDetailTileContainer(
                                                    flex: 1,
                                                    title: 'Place',
                                                    subtitle: data.place,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    // flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(Icons.call),
                                              TextFontWidget(
                                                text:
                                                    " +91 ${data.phoneNumber} ",
                                                fontsize: 12,
                                                color: Colors.blue,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Icon(Icons.email),
                                              TextFontWidget(
                                                text: "  ${data.studentemail}",
                                                fontsize: 12,
                                                color: Colors.blue,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.blue,
                        height: 02,
                      ),
                    ],
                  ),
                ),
              ),

              // Padding(
              //   padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
              //   child: Column(
              //     children: [
              //       Container(
              //         color: cWhite,
              //         height: 40,
              //         child: const TabBar(
              //           indicatorColor: cWhite,
              //           tabAlignment: TabAlignment.start,
              //           isScrollable: true,
              //           labelColor: Colors.blue,
              //           labelStyle: TextStyle(
              //               fontWeight: FontWeight.w400, fontSize: 14),
              //           tabs: [
              //             // Tab(
              //             //   text: 'FEES',
              //             // ),
              //             Tab(
              //               text: 'ATTENDANCE',
              //             ),
              //             Tab(
              //               text: 'EXAM ',
              //             )
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 0, left: 20, right: 20),
              //   child: Container(
              //     width: double.infinity,
              //     color: Colors.blue,
              //     height: 02,
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 0, left: 20, right: 20),
              //   child: Container(
              //     height: 600,
              //     color: cWhite,
              //     // color: Colors.amber,

              //     // height: 300,
              //     child: TabBarView(children: [
              //       // PerStudentFeesHistory(), //........................ Student FEES
              //       PerStudentAttendenceHistory(), //.......................... Student Attendence
              //       PerStudentExamHistory() //............................ Student Exam History
              //     ]),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
