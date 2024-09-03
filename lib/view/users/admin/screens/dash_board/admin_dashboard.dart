import 'package:flutter/material.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/view/users/admin/screens/dash_board/sections/attendence/driving_att/drving_attendence.dart';
import 'package:new_project_driving/view/users/admin/screens/dash_board/sections/attendence/total_students_attendence.dart';
import 'package:new_project_driving/view/users/admin/screens/dash_board/sections/exam_status/exam_status.dart';
import 'package:new_project_driving/view/users/admin/screens/dash_board/sections/road_attendance_graph/road_attendance.dart';
import 'package:new_project_driving/view/users/admin/screens/dash_board/sections/total_members/total_members_section.dart';
import 'package:new_project_driving/view/widget/responsive/responsive.dart';

class AdminDashBoardSections extends StatelessWidget {
  const AdminDashBoardSections({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1000,
      color: const Color.fromARGB(255, 240, 241, 243),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 25, top: 25),
                child: TextFontWidget(
                  text: 'Admin Dashboard',
                  fontsize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 25,
                    left: ResponsiveWebSite.isMobile(context) ? 05 : 10),
                child: const TotalMembersSection(),

                ///.............. Total Members Section
              ),
              ResponsiveWebSite.isMobile(context)
                  ? const Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: 10,
                          ),
                          child: TotalStudentAttendanceContainer(),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 10,
                          ),
                          child:
                              OthersTodayAttendanceContainer(), /////////........ Others --- Attendance
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10, right: 0, left: 0),
                          child: RoadTestAttendanceContainer(),
                        ),
                      ],
                    )
                  : const SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(top: 10, right: 0, left: 10),
                            child: TotalStudentAttendanceContainer(),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 10, right: 0, left: 10),
                            child:
                                OthersTodayAttendanceContainer(), /////////........ Others --- Attendance
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 10, right: 0, left: 10),
                            child: RoadTestAttendanceContainer(),
                          ),
                        ],
                      ),
                    ),
              const Padding(
                padding: EdgeInsets.only(
                  top: 10,
                ),
                child: ExamStatusContainer(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
