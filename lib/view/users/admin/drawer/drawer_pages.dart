// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/view/widget/dashboard_textfont_widget.dart';

class DrawerSelectedPagesSectionAdmin extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;
  DrawerSelectedPagesSectionAdmin({
    required this.selectedIndex,
    required this.onTap,
    super.key,
  });

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: selectedIndex == 0
              ? themeColorBlue.withOpacity(0.1)
              : Colors.transparent,
          child: ListTile(
            leading: SizedBox(
                height: 20,
                width: 20,
                child: Image.asset('webassets/png/dashboard.png')),
            onTap: () {
              index = 0;
              onTap.call(index);
            },
            title: Row(
              children: [
                DashboardTextFontWidget(
                  title: 'Dashboard',
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          color: selectedIndex == 1
              ? themeColorBlue.withOpacity(0.1)
              : Colors.transparent,
          child: ListTile(
            leading: SizedBox(
                height: 25,
                width: 25,
                child: Image.asset('webassets/png/driving-lessons.png')),
            onTap: () {
              index = 1;
              onTap.call(index);
            },
            title: Row(
              children: [
                DashboardTextFontWidget(
                  title: 'Course',
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          color: selectedIndex == 2
              ? themeColorBlue.withOpacity(0.1)
              : Colors.transparent,
          child: ListTile(
            leading: SizedBox(
                height: 25,
                width: 25,
                child: Image.asset('webassets/png/createadmin.png')),
            onTap: () {
              index = 2;
              onTap.call(index);
            },
            title: DashboardTextFontWidget(
              title: 'Tutor Registration',
            ),
          ),
        ),
        Container(
          color: selectedIndex == 3
              ? themeColorBlue.withOpacity(0.1)
              : Colors.transparent,
          child: ListTile(
            leading: SizedBox(
                height: 20,
                width: 20,
                child: Image.asset('webassets/png/student.png')),
            onTap: () {
              index = 3;
              onTap.call(index);
            },
            title: DashboardTextFontWidget(
              title: 'All Students',
            ),
          ),
        ), //////////////////////////.............................5
        Container(
          color: selectedIndex == 4
              ? themeColorBlue.withOpacity(0.1)
              : Colors.transparent,
          child: ListTile(
            leading: SizedBox(
                height: 20,
                width: 20,
                child: Image.asset('webassets/png/teacher_1.png')),
            onTap: () {
              index = 4;
              onTap.call(index);
            },
            title: Row(
              children: [
                DashboardTextFontWidget(
                  title: 'All Tutors',
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ExpansionTile(
          leading: SizedBox(
              height: 25,
              width: 25,
              child: Image.asset('webassets/png/attendance.png')),
          title: DashboardTextFontWidget(
            title: 'Attendance',
          ),
          children: <Widget>[
            Container(
              color: selectedIndex == 5
                  ? themeColorBlue.withOpacity(0.1)
                  : Colors.transparent,
              child: ListTile(
                onTap: () {
                  index = 5;
                  onTap.call(index);
                },
                title: DashboardTextFontWidget(
                  title: 'Students',
                ),
              ),
            ),
            Container(
              color: selectedIndex == 6
                  ? themeColorBlue.withOpacity(0.1)
                  : Colors.transparent,
              child: ListTile(
                onTap: () {
                  index = 6;
                  onTap.call(index);
                },
                title: DashboardTextFontWidget(
                  title: 'Tutor',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          color: selectedIndex == 7
              ? themeColorBlue.withOpacity(0.1)
              : Colors.transparent,
          child: ListTile(
            leading: SizedBox(
                height: 20,
                width: 20,
                child: Image.asset('webassets/png/learners.png')),
            onTap: () {
              index = 7;
              onTap.call(index);
            },
            title: DashboardTextFontWidget(
              title: 'Learners Test',
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          color: selectedIndex == 8
              ? themeColorBlue.withOpacity(0.1)
              : Colors.transparent,
          child: ListTile(
            leading: SizedBox(
                height: 20,
                width: 20,
                child: Image.asset('webassets/png/cone.png')),
            onTap: () {
              index = 8;
              onTap.call(index);
            },
            title: DashboardTextFontWidget(
              title: 'Driving Test',
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          color: selectedIndex == 9
              ? themeColorBlue.withOpacity(0.1)
              : Colors.transparent,
          child: ListTile(
            leading: SizedBox(
                height: 20,
                width: 20,
                child: Image.asset('webassets/png/road-trip.png')),
            onTap: () {
              index = 9;
              onTap.call(index);
            },
            title: DashboardTextFontWidget(
              title: 'Road Test',
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          color: selectedIndex == 10
              ? themeColorBlue.withOpacity(0.1)
              : Colors.transparent,
          child: ListTile(
            leading: SizedBox(
                height: 20,
                width: 20,
                child: Image.asset('webassets/png/calendar.png')),
            onTap: () {
              index = 10;
              onTap.call(index);
            },
            title: DashboardTextFontWidget(
              title: 'Practice Shedule',
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          color: selectedIndex == 11
              ? themeColorBlue.withOpacity(0.1)
              : Colors.transparent,
          child: ListTile(
            leading: SizedBox(
                height: 20,
                width: 20,
                child: Image.asset('webassets/png/hand.png')),
            onTap: () {
              index = 11;
              onTap.call(index);
            },
            title: DashboardTextFontWidget(
              title: 'Fees and Bills',
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          color: selectedIndex == 12
              ? themeColorBlue.withOpacity(0.1)
              : Colors.transparent,
          child: ListTile(
            leading: SizedBox(
                height: 20,
                width: 20,
                child: Image.asset('webassets/png/createadmin.png')),
            onTap: () {
              index = 12;
              onTap.call(index);
            },
            title: DashboardTextFontWidget(
              title: 'Create Admin',
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          color: selectedIndex == 13
              ? themeColorBlue.withOpacity(0.1)
              : Colors.transparent,
          child: ListTile(
            leading: SizedBox(
                height: 20,
                width: 20,
                child: Image.asset('webassets/png/books.png')),
            onTap: () {
              index = 13;
              onTap.call(index);
            },
            title: DashboardTextFontWidget(
              title: 'Study Materials',
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          color: selectedIndex == 14
              ? themeColorBlue.withOpacity(0.1)
              : Colors.transparent,
          child: ListTile(
            leading: SizedBox(
                height: 20,
                width: 20,
                child: Image.asset('webassets/png/notice.png')),
            onTap: () {
              index = 14;
              onTap.call(index);
            },
            title: Row(
              children: [
                DashboardTextFontWidget(
                  title: 'Notices',
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          color: selectedIndex == 15
              ? themeColorBlue.withOpacity(0.1)
              : Colors.transparent,
          child: ListTile(
            leading: SizedBox(
                height: 20,
                width: 20,
                child: Image.asset('webassets/png/banner.png')),
            onTap: () {
              index = 15;
              onTap.call(index);
            },
            title: Row(
              children: [
                DashboardTextFontWidget(
                  title: 'Events',
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          color: selectedIndex == 16
              ? themeColorBlue.withOpacity(0.1)
              : Colors.transparent,
          child: ListTile(
            leading: SizedBox(
                height: 20,
                width: 20,
                child: Image.asset('webassets/png/video.png')),
            onTap: () {
              index = 16;
              onTap.call(index);
            },
            title: Row(
              children: [
                DashboardTextFontWidget(
                  title: 'Videos',
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          color: selectedIndex == 17
              ? themeColorBlue.withOpacity(0.1)
              : Colors.transparent,
          child: ListTile(
            leading: SizedBox(
                height: 20,
                width: 20,
                child: Image.asset('webassets/png/notification.png')),
            onTap: () {
              index = 17;
              onTap.call(index);
            },
            title: DashboardTextFontWidget(
              title: 'Notifications',
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          color: selectedIndex == 18
              ? themeColorBlue.withOpacity(0.1)
              : Colors.transparent,
          child: ListTile(
            leading: SizedBox(
                height: 20,
                width: 20,
                child: Image.asset('webassets/png/logout.png')),
            onTap: () {
              index = 18;
              onTap.call(index);
            },
            title: DashboardTextFontWidget(
              title: 'Login Histroy',
            ),
          ),
        ),
      ],
    );
  }
}
