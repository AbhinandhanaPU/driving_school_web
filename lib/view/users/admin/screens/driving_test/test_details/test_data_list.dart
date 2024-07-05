import 'package:flutter/material.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/view/widget/reusable_table_widgets/data_container.dart';

class TestDataList extends StatelessWidget {
  final Map<String, dynamic> data;
  final int index;
  const TestDataList({
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
                headerTitle: '${data['testDate']}'),
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
                headerTitle: '${data['testTime']}'),
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
                headerTitle: '${data['location']}'),
          ), //............................. test place
          const SizedBox(
            width: 02,
          ),
          Expanded(
            flex: 3,
            child: DataContainerWidget(
                rowMainAccess: MainAxisAlignment.center,
                color: cWhite,
                // width: 150,
                index: index,
                headerTitle: '2'),
          ), //............................. Student count
          const SizedBox(
            width: 02,
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  // videosController.videoEditTitleController.text =
                  //     data['videoTitle'];
                  // videosController.videoEditDesController.text =
                  //     data['videoDes'];
                  // videosController.videoEditCateController.text =
                  //     data['videoCategory'];
                  // editFunctionOfVideo(context, data);
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
                  // customDeleteShowDialog(
                  //   context: context,
                  //   onTap: () async {
                  //     await videosController.deletevideo(docId: data['docId']);
                  //   },
                  // );
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
