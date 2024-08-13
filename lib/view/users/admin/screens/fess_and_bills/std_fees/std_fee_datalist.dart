import 'package:flutter/material.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/constant/constant.validate.dart';
import 'package:new_project_driving/model/student_model/student_model.dart';
import 'package:new_project_driving/view/widget/reusable_table_widgets/data_container.dart';

class StudentFeeDatalist extends StatelessWidget {
  final StudentModel stdData;
  final Map<String, dynamic> feeData;
  final int index;
  const StudentFeeDatalist({
    required this.index,
    required this.stdData,
    super.key,
    required this.feeData,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: DataContainerWidget(
                rowMainAccess: MainAxisAlignment.center,
                color: cWhite,
                index: index,
                headerTitle: '${index + 1}'), //....................No
          ),
          const SizedBox(
            width: 02,
          ),
          Expanded(
            flex: 3,
            child: DataContainerWidget(
                rowMainAccess: MainAxisAlignment.start,
                color: cWhite,
                index: index,
                headerTitle: stdData.studentName),
          ),
          const SizedBox(
            width: 02,
          ),
          Expanded(
            flex: 2,
            child: DataContainerWidget(
                rowMainAccess: MainAxisAlignment.center,
                color: cWhite,
                index: index,
                headerTitle: stringTimeToDateConvert(stdData.joiningDate)),
          ),
          const SizedBox(
            width: 02,
          ),
          Expanded(
            flex: 2,
            child: DataContainerWidget(
                rowMainAccess: MainAxisAlignment.center,
                color: cWhite,
                index: index,
                headerTitle: '0'),
          ),
          const SizedBox(
            width: 02,
          ),
          Expanded(
            flex: 2,
            child: DataContainerWidget(
                rowMainAccess: MainAxisAlignment.center,
                color: cWhite,
                index: index,
                headerTitle: feeData['pendingAmount'].toString()),
          ),
          const SizedBox(
            width: 02,
          ),
          Expanded(
            flex: 2,
            child: DataContainerWidget(
                rowMainAccess: MainAxisAlignment.center,
                color: cWhite,
                index: index,
                headerTitle: feeData['feeStatus']),
          ),
        ],
      ),
    );
  }
}
