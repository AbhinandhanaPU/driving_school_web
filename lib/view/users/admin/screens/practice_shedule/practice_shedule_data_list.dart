import 'package:flutter/material.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/model/student_model/student_model.dart';
import 'package:new_project_driving/view/widget/reusable_table_widgets/data_container.dart';

class PracticeSheduleDataList extends StatelessWidget {
  final StudentModel data;
  final int index;
  const PracticeSheduleDataList({
    required this.data,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: index % 2 == 0 ? const Color.fromARGB(255, 246, 246, 246) : Colors.blue[50],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: DataContainerWidget(
                  rowMainAccess: MainAxisAlignment.center,
                  color: cWhite,
                  index: index,
                  headerTitle: '1'),
            ), //....................No
          ),
          const SizedBox(
            width: 01,
          ),
          const Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(
                  child: Center(
                    child: TextFontWidget(
                      text: '--',
                      fontsize: 12,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ), //........................................... Student Name
          const SizedBox(
            width: 01,
          ),
          Expanded(
            flex: 3,
            child: Center(
              child: DataContainerWidget(
                  rowMainAccess: MainAxisAlignment.center,
                  color: cWhite,
                  // width: 150,
                  index: index,
                  headerTitle: '--'),
            ),
          ), //............................. Student joining Date
          const SizedBox(
            width: 01,
          ),
          Expanded(
            flex: 3,
            child: Center(
              child: DataContainerWidget(
                  rowMainAccess: MainAxisAlignment.center,
                  color: cWhite,
                  // width: 150,
                  index: index,
                  headerTitle: '--'),
            ),
          ), //............................. Student Completed days
          const SizedBox(
            width: 01,
          ),
          Expanded(
            flex: 3,
            child: Center(
              child: DataContainerWidget(
                  rowMainAccess: MainAxisAlignment.center,
                  color: cWhite,
                  // width: 150,
                  index: index,
                  headerTitle: ' Update 🖋️'),
            ),
          ), //............................. Student Practce Status
          const SizedBox(
            width: 01,
          ),
          Expanded(
            flex: 3,
            child: Center(
              child: DataContainerWidget(
                  rowMainAccess: MainAxisAlignment.center,
                  color: cWhite,
                  // width: 150,
                  index: index,
                  headerTitle: ' Remove 🗑️'),
            ),
          ), //............................. Student Sheduled Practce
        ],
      ),
    );
  }
}
