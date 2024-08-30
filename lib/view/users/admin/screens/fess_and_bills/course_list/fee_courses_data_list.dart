import 'package:flutter/material.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/model/course_model/course_model.dart';
import 'package:new_project_driving/view/widget/reusable_table_widgets/data_container.dart';

class FeeCoursesDataList extends StatelessWidget {
  final CourseModel data;
  final Map<String, dynamic> feeModel;
  final int index;
  const FeeCoursesDataList({
    required this.data,
    required this.index,
    required this.feeModel,
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
            child: DataContainerWidget(
              rowMainAccess: MainAxisAlignment.center,
              color: cWhite,
              index: index,
              headerTitle: '  ${index + 1}', //....................No
            ),
          ),
          const SizedBox(
            width: 02,
          ),
          Expanded(
            flex: 2,
            child: TextFontWidget(
              text: '  ${data.courseName}',
              fontsize: 12,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(
            width: 02,
          ),
          Expanded(
            flex: 2,
            child: TextFontWidget(
              text: '${data.rate}',
              fontsize: 12,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 2),
          Expanded(
            flex: 2,
            child: TextFontWidget(
              text: feeModel['totalStudents']?.toString() ?? 'N/A',
              fontsize: 12,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 02),
          Expanded(
            flex: 2,
            child: TextFontWidget(
              text: feeModel['amountCollected']?.toString() ?? 'N/A',
              fontsize: 12,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(
            width: 02,
          ),
          Expanded(
            flex: 2,
            child: TextFontWidget(
              text: feeModel['pendingAmount']?.toString() ?? 'N/A',
              fontsize: 12,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(
            width: 02,
          ),
          Expanded(
            flex: 2,
            child: TextFontWidget(
              text: feeModel['totalAmount']?.toString() ?? 'N/A',
              fontsize: 12,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(
            width: 02,
          ),
        ],
      ),
    );
  }
}
