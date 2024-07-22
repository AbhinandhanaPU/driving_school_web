import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/fonts/google_poppins_widget.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/info/info.dart';
import 'package:new_project_driving/utils/firebase/firebase.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';
import 'package:new_project_driving/view/users/admin/app_bar/admin_appBar.dart';
import 'package:new_project_driving/view/users/admin/drawer/drawer_pages.dart';
import 'package:new_project_driving/view/users/admin/screens/attendance/student_attendance.dart';
import 'package:new_project_driving/view/users/admin/screens/attendance/tutor_attendance.dart';
import 'package:new_project_driving/view/users/admin/screens/courses/course_details.dart';
import 'package:new_project_driving/view/users/admin/screens/dash_board/admin_dashboard.dart';
import 'package:new_project_driving/view/users/admin/screens/driving_test/driving_student_list.dart';
import 'package:new_project_driving/view/users/admin/screens/events/all_event_view.dart';
import 'package:new_project_driving/view/users/admin/screens/fess_and_bills/create_fees/view_fees_status.dart';
import 'package:new_project_driving/view/users/admin/screens/learners_test/learners_student_list.dart';
import 'package:new_project_driving/view/users/admin/screens/login_histroy/login_histroy.dart';
import 'package:new_project_driving/view/users/admin/screens/new_admin_page/new_admin_details.dart';
import 'package:new_project_driving/view/users/admin/screens/notice/notice_all_ist.dart';
import 'package:new_project_driving/view/users/admin/screens/notifications/admin_notification_create.dart';
import 'package:new_project_driving/view/users/admin/screens/practice_shedule/practice_shedule_student_list.dart';
import 'package:new_project_driving/view/users/admin/screens/registration/teachers_regi_container.dart';
import 'package:new_project_driving/view/users/admin/screens/students/students_list/view_all_students.dart';
import 'package:new_project_driving/view/users/admin/screens/study_materials/study_materials_list.dart';
import 'package:new_project_driving/view/users/admin/screens/tutor/view_all_tutor.dart';
import 'package:new_project_driving/view/users/admin/screens/videos/video_list.dart';
import 'package:new_project_driving/view/widget/loading_widget/loading_widget.dart';
import 'package:new_project_driving/view/widget/responsive/responsive.dart';
import 'package:sidebar_drawer/sidebar_drawer.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  int selectedIndex = 0;

  void onPageSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: UserCredentialsController.schoolId !=
                FirebaseAuth.instance.currentUser!.uid
            ? server
                .collection('DrivingSchoolCollection')
                .doc(UserCredentialsController.schoolId)
                .collection('Admins')
                .doc(serverAuth.currentUser!.uid)
                .snapshots()
            : null,
        builder: (context, snap) {
          if (snap.hasData) {
            return snap.data?.data()?['active'] == false
                ? const Scaffold(
                    body: SafeArea(
                        child: Center(
                      child: TextFontWidget(
                          text: "Waiting for superadmin response.....",
                          fontsize: 20),
                    )),
                  )
                : Scaffold(
                    backgroundColor: cWhite,
                    body: SafeArea(
                      child: SidebarDrawer(
                          body: ListView(
                            children: [
                              AppBarAdminPanel(),
                              pages[selectedIndex],
                            ],
                          ),
                          drawer: Container(
                            color: Colors.white,
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(0),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            height: 60,
                                            child: Image.asset(
                                              logoImage,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          GooglePoppinsWidgets(
                                            text: institutionName,
                                            fontsize:
                                                ResponsiveWebSite.isMobile(
                                                        context)
                                                    ? 18
                                                    : 20,
                                            fontWeight: FontWeight.w500,
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 12),
                                      child: GestureDetector(
                                        child: Text(
                                          "Main Menu",
                                          style: TextStyle(
                                              color: cBlack.withOpacity(
                                                0.4,
                                              ),
                                              fontSize: 12),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    DrawerSelectedPagesSectionAdmin(
                                      selectedIndex: selectedIndex,
                                      onTap: onPageSelected,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )),
                    ),
                  );
          } else if (UserCredentialsController.schoolId ==
              FirebaseAuth.instance.currentUser!.uid) {
            return Scaffold(
              backgroundColor: cWhite,
              body: SafeArea(
                child: SidebarDrawer(
                    body: ListView(
                      children: [
                        AppBarAdminPanel(),
                        pages[selectedIndex],
                      ],
                    ),
                    drawer: Container(
                      color: Colors.white,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(
                              left:
                                  ResponsiveWebSite.isMobile(context) ? 0 : 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height:
                                          ResponsiveWebSite.isMobile(context)
                                              ? 40
                                              : 60,
                                      child: Image.asset(
                                        logoImage,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    GooglePoppinsWidgets(
                                      text: institutionName,
                                      fontsize:
                                          ResponsiveWebSite.isMobile(context)
                                              ? 12
                                              : 15,
                                      fontWeight: FontWeight.w500,
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 12),
                                child: Text(
                                  "Main Menu",
                                  style: TextStyle(
                                      color: cBlack.withOpacity(
                                        0.4,
                                      ),
                                      fontSize: 12),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              DrawerSelectedPagesSectionAdmin(
                                selectedIndex: selectedIndex,
                                onTap: onPageSelected,
                              )
                            ],
                          ),
                        ),
                      ),
                    )),
              ),
            );
          } else {
            return const Scaffold(body: LoadingWidget());
          }
        });
  }
}

List<Widget> pages = [
  // AdminDashBoardSections(),
  const AdminDashBoardSections(), // index 0
  CoursesDetails(), // index 1
  const AllTeacherRegistrationList(), // index 2
  AllStudentListContainer(), // index 3
  AllTutorListContainer(), // index 4
  const AllStudentsAttendance(), // index 5
  const AllTutorAttendance(), // index 6
  const LearnersStudentListContainer(), // index 7
  DrivingStudentListContainer(), // index 8
  const PracticeSheduleStudentListContainer(), // index 10
  CreatedFeesStatus(), // index 11
  AllAdminListPage(), // index 12
  const StudyMaterialsList(), // index 13
  NoticeAllList(), // index 14
  const AllEventsList(), // index 15
  const VideosList(), // index 16
  AdminNotificationCreate(), // index 17
  LoginHistroyContainer(), // index 18////////////////////////////////
];
