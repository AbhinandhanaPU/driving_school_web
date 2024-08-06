import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/controller/batch_controller/batch_controller.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/model/batch_model/batch_model.dart';
import 'package:new_project_driving/view/users/admin/screens/batch/functions/edit_batch.dart';
import 'package:new_project_driving/view/widget/custom_delete_showdialog/custom_delete_showdialog.dart';
import 'package:new_project_driving/view/widget/reusable_table_widgets/data_container.dart';

class BatchDataList extends StatelessWidget {
  final BatchController batchController = Get.put(BatchController());

  final BatchModel data;
  final int index;
  BatchDataList({
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
                      text: data.batchName,
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
                  headerTitle: data.date),
            ),
          ), //............................. Student endTime
          const SizedBox(
            width: 02,
          ),
          Expanded(
            flex: 2,
            child: StreamBuilder<int>(
                stream: batchController
                    .fetchTotalStudents(data.batchId),
                builder: (context, snapshot) {
                  return Center(
                    child: DataContainerWidget(
                      rowMainAccess: MainAxisAlignment.center,
                      color: cWhite,
                      // width: 150,
                      index: index,
                      headerTitle:
                          snapshot.hasData ? snapshot.data.toString() : '0',
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
                  batchController.batchNameController.text =
                      data.batchName;
                  batchController.dateController.text =
                      data.date;
                  editFunctionOfbatch(context, data);
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
                      batchController.deleteBatch(
                        data.batchId,
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
