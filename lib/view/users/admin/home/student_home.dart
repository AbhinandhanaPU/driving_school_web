import 'package:flutter/material.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/fonts/google_poppins_widget.dart';
import 'package:new_project_driving/info/info.dart';
import 'package:new_project_driving/view/users/admin/app_bar/student_appBar.dart';
 
import 'package:new_project_driving/view/users/admin/drawer/drawer_pages.dart';
import 'package:new_project_driving/view/users/admin/screens/registration/teachers_regi_container.dart';
import 'package:sidebar_drawer/sidebar_drawer.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  int selectedIndex = 0;

  // get sHeight10 => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cWhite,
      body: SafeArea(
        child: SidebarDrawer(
            body: ListView(
              children: [
                AppBarStudentPanel(),
                pages[selectedIndex],
              ],
            ),
            drawer: Container(
              color: cWhite,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, bottom: 590),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(0),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 30,
                              child: Image.asset(
                                logoImage,
                                fit: BoxFit.fill,
                              ),
                            ),
                            GooglePoppinsWidgets(
                              text: name,
                              fontsize: 20,
                              fontWeight: FontWeight.w500,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 12),
                        child: Text(
                          "Main Menu",
                          style: TextStyle(
                              color: cBlack.withOpacity(
                                0.4,
                              ),
                              fontSize: 12),
                        ),
                      ),
                      // sHeight10,
                      DrawerSelectedPagesSection(
                        selectedIndex: selectedIndex,
                        onTap: (index) {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                      )
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}

List<Widget> pages = [
  // AdminDashBoardSections(),

  // AllClassListContainer(),
  const AllTeacherRegistrationList(),
  // AllNonTeachStaffListContainer(),

  // AllStudentListContainer(),
  // AllTeacherListContainer(),
  // AllParentsListContainer(),

  // AllClassListView(),

  // CreatedFeesStatus(),

  // PeriodWiseStudentsAttendance(),
  // AllTeachersAttendance(),

  // AllExamNotificationListView(),

  // NoticeEditRemove(),

  // const AllEventsList(),

  // AllMeetingsListPage(),

  // AdminNotificationCreate(),

  // AllAdminListPage(),

  // GeneralInsructions(),

  // const Achievements(),

  // BatchHistroyListPage(),
  // // const TimeTableMainScreen(),
  // // LoginHistroyContainer(),
  // // const Scaffold(body: LoginDashBoard())
  // const TimeTableMainScreen(),
  // LoginHistroyContainer(),
  // TherapyHomePage()
];
