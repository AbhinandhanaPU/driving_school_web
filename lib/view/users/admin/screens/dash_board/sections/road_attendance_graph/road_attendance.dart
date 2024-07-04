import 'package:flutter/material.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/view/users/admin/screens/dash_board/sections/road_attendance_graph/road_attendance_graph.dart';
import 'package:new_project_driving/view/widget/responsive/responsive.dart';

class RoadTestAttendanceContainer extends StatelessWidget {
  const RoadTestAttendanceContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ResponsiveWebSite.isMobile(context) ? 320 : 420,
      decoration: BoxDecoration(
          color: cWhite, border: Border.all(color: cBlack.withOpacity(0.1))),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20, right: 0),
            child: TextFontWidget(
              text: "Road Attendance",
              fontsize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: ResponsiveWebSite.isMobile(context) ? 200 : 300,
            child: const RoadAttCircleGraph(),
          ),
          SizedBox(
            height: 50,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Container(
                          height: 04,
                          width: 60,
                          color: const Color.fromARGB(255, 48, 79, 254),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10, top: 05),
                        child: TextFontWidget(
                          text: 'Present',
                          fontsize: 11.5,
                          color: Colors.black.withOpacity(0.8),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 06),
                        child: TextFontWidget(
                          text: '500',
                          fontsize: 12,
                          color: Colors.black.withOpacity(0.4),
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: 01,
                    color: Colors.grey,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Container(
                          height: 04,
                          width: 60,
                          color: const Color.fromARGB(255, 255, 166, 1),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 05),
                        child: TextFontWidget(
                          text: 'Absent',
                          fontsize: 11.5,
                          color: Colors.black.withOpacity(0.8),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 06),
                        child: TextFontWidget(
                          text: '500',
                          fontsize: 12,
                          color: Colors.black.withOpacity(0.4),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
