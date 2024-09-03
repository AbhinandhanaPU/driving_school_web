import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/controller/practice_shedule_controller/practice_shedule_controller.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/model/practice_shedule_model/practice_shedule_model.dart';
import 'package:new_project_driving/model/student_model/student_model.dart';
import 'package:new_project_driving/view/users/admin/screens/practice_shedule/practise_functions/practice_shedule_edit.dart';
import 'package:new_project_driving/view/widget/custom_delete_showdialog/custom_delete_showdialog.dart';
import 'package:new_project_driving/view/widget/reusable_table_widgets/data_container.dart';

class PracticeSheduleDataList extends StatelessWidget {
  final PracticeSheduleController practiceshedulecontroller =
      Get.put(PracticeSheduleController());

  final PracticeSheduleModel data;
  final int index;
  PracticeSheduleDataList({
    required this.data,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: index % 2 == 0
            ? const Color.fromARGB(255, 246, 246, 246)
            : Colors.blue[50],
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
            width: 02,
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
          ), //........................................... practiceName
          const SizedBox(
            width: 02,
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
          ), //............................. Student startTime
          const SizedBox(
            width: 02,
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
          ), //............................. Student endTime
          const SizedBox(
            width: 02,
          ),
          Expanded(
            flex: 2,
            child: StreamBuilder<List<StudentModel>>(
                stream: practiceshedulecontroller
                    .fetchStudentsWithStatusTrue(data.practiceId),
                builder: (context, snapshot) {
                  final studentCount =
                      snapshot.hasData ? snapshot.data!.length : 0;
                  return Center(
                    child: DataContainerWidget(
                      rowMainAccess: MainAxisAlignment.center,
                      color: cWhite,
                      // width: 150,
                      index: index,
                      headerTitle: studentCount.toString(),
                    ),
                  );
                }),
          ), //............................. Student count
          const SizedBox(
            width: 02,
          ),
          Expanded(
            flex: 3,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  practiceshedulecontroller.practiceNameController.text =
                      data.practiceName;
                  practiceshedulecontroller.startTimeController.text =
                      data.startTime;
                  practiceshedulecontroller.endTimeController.text =
                      data.endTime;
                  editFunctionOfPractice(context, data);
                },
                child: DataContainerWidget(
                    rowMainAccess: MainAxisAlignment.center,
                    color: cWhite,
                    // width: 150,
                    index: index,
                    headerTitle: ' Update 🖋️'),
              ),
            ),
          ), //............................. Student Practce Status
          const SizedBox(
            width: 01,
          ),
          Expanded(
            flex: 3,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  customDeleteShowDialog(
                    context: context,
                    onTap: () {
                      practiceshedulecontroller.deletePractice(
                        data.practiceId,
                        context,
                      );
                      Navigator.pop(context);
                    },
                  );
                },
                child: DataContainerWidget(
                    rowMainAccess: MainAxisAlignment.center,
                    color: cWhite,
                    // width: 150,
                    index: index,
                    headerTitle: ' Remove 🗑️'),
              ),
            ),
          ), //............................. Student Sheduled Practce
        ],
      ),
    );
  }
}
