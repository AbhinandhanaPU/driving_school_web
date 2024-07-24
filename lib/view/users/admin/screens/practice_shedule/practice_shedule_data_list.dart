import 'package:flutter/material.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/model/practice_shedule_model/practice_shedule_model.dart';
import 'package:new_project_driving/view/widget/reusable_table_widgets/data_container.dart';

class PracticeSheduleDataList extends StatelessWidget {
  final PracticeSheduleModel data;
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
                  headerTitle: '${index + 1}'),
            ), //....................No
          ),
          const SizedBox(
            width: 01,
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(
                  child: Center(
                    child: TextFontWidget(
                      text: data.practiceName,
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
                  headerTitle: data.startTime),
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
                  headerTitle: data.endTime),
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
