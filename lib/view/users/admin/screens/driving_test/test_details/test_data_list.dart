import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/controller/test_controller/test_controller.dart';
import 'package:new_project_driving/model/student_model/student_model.dart';
import 'package:new_project_driving/model/test_model/test_model.dart';
import 'package:new_project_driving/view/users/admin/screens/driving_test/test_details/test_edit.dart';
import 'package:new_project_driving/view/widget/custom_delete_showdialog/custom_delete_showdialog.dart';
import 'package:new_project_driving/view/widget/reusable_table_widgets/data_container.dart';

class TestDataList extends StatelessWidget {
  final TestModel data;

  ///Map<String, dynamic>
  final int index;
  TestDataList({
    required this.data,
    required this.index,
    super.key,
  });
  final TestController testController = Get.put(TestController());

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
                headerTitle: '  ${index + 1}'), //....................No
          ),
          const SizedBox(
            width: 01,
          ),
          Expanded(
            flex: 3,
            child: DataContainerWidget(
                rowMainAccess: MainAxisAlignment.center,
                color: cWhite,
                // width: 150,
                index: index,
                headerTitle: data.testDate
                // '${data['testDate']}'
                ),
          ), //.............................test Date
          const SizedBox(
            width: 01,
          ),
          Expanded(
            flex: 3,
            child: DataContainerWidget(
                rowMainAccess: MainAxisAlignment.center,
                color: cWhite,
                // width: 150,
                index: index,
                headerTitle: data.testTime
                // '${data['testTime']}'
                ),
          ), //.............................test Time
          const SizedBox(
            width: 01,
          ),
          Expanded(
            flex: 3,
            child: DataContainerWidget(
                rowMainAccess: MainAxisAlignment.center,
                color: cWhite,
                // width: 150,
                index: index,
                headerTitle: data.location
                // '${data['location']}'
                ),
          ), //............................. test place
          const SizedBox(
            width: 02,
          ),
          Expanded(
            flex: 2,
            child: StreamBuilder<List<StudentModel>>(
                stream: testController.fetchStudentsWithStatusTrue(data.docId),
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
            flex: 2,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  testController.testDateEditController.text = data.testDate;
                  testController.testTimeEditController.text = data.testTime;
                  testController.testLocationEditController.text =
                      data.location;
                  editFunctionOfTest(context, data);
                },
                child: DataContainerWidget(
                    rowMainAccess: MainAxisAlignment.center,
                    color: cWhite,
                    index: index,
                    headerTitle: ' Update 🖋️'),
              ),
            ),
          ), //....................................... Edit
          const SizedBox(
            width: 02,
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  customDeleteShowDialog(
                    context: context,
                    onTap: () async {
                      await testController.deleteTest(docId: data.docId);
                    },
                  );
                },
                child: DataContainerWidget(
                    rowMainAccess: MainAxisAlignment.center,
                    color: cWhite,
                    index: index,
                    headerTitle: ' Remove 🗑️'),
              ),
            ),
          ), //....................Delete

          const SizedBox(
            width: 01,
          ),
        ],
      ),
    );
  }
}
