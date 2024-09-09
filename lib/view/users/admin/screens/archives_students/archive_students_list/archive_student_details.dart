import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/controller/admin_section/student_controller/student_controller.dart';
import 'package:new_project_driving/controller/class_controller/class_controller.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/model/batch_model/batch_model.dart';
import 'package:new_project_driving/utils/firebase/firebase.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';
import 'package:new_project_driving/view/widget/loading_widget/lottie_widget.dart';
import 'package:new_project_driving/view/widget/profile_detail_widget/detail_tile_container.dart';
import 'package:new_project_driving/view/widget/responsive/responsive.dart';
import 'package:new_project_driving/view/widget/routeSelectedTextContainer/routeSelectedTextContainer.dart';
import 'package:new_project_driving/view/widget/routeSelectedTextContainer/route_NonSelectedContainer.dart';

class ArchivesStudentDetailsContainer extends StatelessWidget {
  final StudentController studentController = Get.put(StudentController());
  final ClassController classController = Get.put(ClassController());
  ArchivesStudentDetailsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final data = studentController.studentModelData.value;

    return SingleChildScrollView(
      scrollDirection:
          ResponsiveWebSite.isMobile(context) ? Axis.horizontal : Axis.vertical,
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
                text: 'Archives Student Details',
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
                            classController.ontapStudentsDetail.value == true
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
                                              classController
                                                  .ontapStudentsDetail
                                                  .value = false;
                                              classController.ontapClassStudents
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
                                              classController
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
                                            title: 'Student Details'),
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
                                              classController
                                                  .ontapStudentsDetail
                                                  .value = false;
                                              classController.ontapClassStudents
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
                                            title: 'Student Details'),
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
                                                  title: 'Parent/Spouse  ',
                                                  subtitle: data.guardianName,
                                                ),
                                                ProfileDetailTileContainer(
                                                  flex: 1,
                                                  title: ' Place',
                                                  subtitle: data.place,
                                                ),
                                                ProfileDetailTileContainer(
                                                  flex: 1,
                                                  title: 'Joining Date',
                                                  subtitle: DateFormat(
                                                          'yyyy-MM-dd')
                                                      .format(DateTime.parse(
                                                          data.joiningDate)),
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
                                              text: " +91 ${data.phoneNumber} ",
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
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Container(
                color: cWhite,
                height: 200,
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 100,
                            color: Colors.blue.withOpacity(0.1),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 10, top: 10),
                                  child: TextFontWidget(
                                    text: 'Course and Batch Details',
                                    fontsize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 20, left: 10),
                                  child: SizedBox(
                                    width: 500,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        FutureBuilder<List<String>>(
                                          future: studentController
                                              .fetchStudentsCourse(data),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const LottieLoadingWidet();
                                            } else if (snapshot.hasError) {
                                              return Text(
                                                  'Error: ${snapshot.error}');
                                            } else if (!snapshot.hasData ||
                                                snapshot.data!.isEmpty) {
                                              return const ProfileDetailTileContainer(
                                                flex: 1,
                                                title: 'Course Name',
                                                subtitle: 'N/A',
                                              );
                                            } else {
                                              String courses =
                                                  snapshot.data!.join(', ');
                                              return ProfileDetailTileContainer(
                                                flex: 1,
                                                title: 'Course Name',
                                                subtitle: courses,
                                              );
                                            }
                                          },
                                        ),
                                        StreamBuilder(
                                            stream: server
                                                .collection(
                                                    'DrivingSchoolCollection')
                                                .doc(UserCredentialsController
                                                    .schoolId)
                                                .collection('Batch')
                                                .doc(data.batchId)
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              final batchData =
                                                  BatchModel.fromMap(
                                                      snapshot.data!.data()!);
                                              return ProfileDetailTileContainer(
                                                flex: 1,
                                                title: 'Batch Name',
                                                subtitle:
                                                    batchData.batchName != ''
                                                        ? batchData.batchName
                                                        : "N/A",
                                              );
                                            }),
                                        // const ProfileDetailTileContainer(
                                        //   flex: 1,
                                        //   title: 'Practice Schedule',
                                        //   subtitle:
                                        //       // data['practiceName'] ??
                                        //       'N/A',
                                        // ),
                                        // const ProfileDetailTileContainer(
                                        //   flex: 1,
                                        //   title: 'Driving Test Date',
                                        //   subtitle:
                                        //       // data['testDate'] ??
                                        //       'N/A',
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Expanded(
                          //   child: Padding(
                          //     padding: const EdgeInsets.only(left: 20),
                          //     child: Column(
                          //       mainAxisAlignment:
                          //           MainAxisAlignment.spaceEvenly,
                          //       children: [
                          //         Row(
                          //           children: [
                          //             const TextFontWidget(
                          //               text: "Fee Status : ",
                          //               fontsize: 13,
                          //               color: cBlack,
                          //             ),
                          //             TextFontWidget(
                          //               text: data.['feeStatus'] ?? 'N/A',
                          //               fontsize: 12,
                          //               color: cBlue,
                          //             ),
                          //           ],
                          //         ),
                          //         Row(
                          //           children: [
                          //             const TextFontWidget(
                          //               text: "Pending Amount : ",
                          //               fontsize: 13,
                          //               color: cBlack,
                          //             ),
                          //             TextFontWidget(
                          //               text:
                          //                   data['pendingAmount']?.toString() ??
                          //                       'N/A',
                          //               fontsize: 12,
                          //               color: cBlue,
                          //             ),
                          //           ],
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      color: Colors.blue,
                      height: 2,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
