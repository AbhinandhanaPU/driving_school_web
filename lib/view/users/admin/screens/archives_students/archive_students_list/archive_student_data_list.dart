import 'package:flutter/material.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/constant/constant.validate.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/model/student_model/student_model.dart';
import 'package:new_project_driving/view/widget/reusable_table_widgets/data_container.dart';

class ArchiveAllStudentDataList extends StatelessWidget {
  final StudentModel data;
  final int index;
  const ArchiveAllStudentDataList({
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
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                  child: Center(
                    child: Image.asset(
                      'webassets/stickers/icons8-student-100 (1).png',
                    ),
                  ),
                ),
                Expanded(
                  child: TextFontWidget(
                    text: '  ${data.studentName}',
                    fontsize: 12,
                    overflow: TextOverflow.ellipsis,
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
            child: Row(
              children: [
                SizedBox(
                  width: 15,
                  child: Center(
                    child: Image.asset(
                      'webassets/png/telephone.png',
                    ),
                  ),
                ),
                Expanded(
                  child: TextFontWidget(
                    text: "  ${data.phoneNumber}",
                    fontsize: 12,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ), //....................................... Student Phone Number
          const SizedBox(
            width: 01,
          ),
          Expanded(
            flex: 4,
            child:  DataContainerWidget(
                rowMainAccess: MainAxisAlignment.center,
                color: cWhite,
                // width: 150,
                index: index,
                headerTitle: "  ${data.place}"),
            // StreamBuilder<List<String>>(
            //   stream: studentController.fetchStudentsCourse(data),
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return const Center(child: CircularProgressIndicator());
            //     } else if (snapshot.hasError) {
            //       return Text('Error: ${snapshot.error}');
            //     } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            //       return DataContainerWidget(
            //         rowMainAccess: MainAxisAlignment.center,
            //         color: cWhite,
            //         index: index,
            //         headerTitle: 'Course Not Found',
            //       );
            //     } else {
            //       String courses = snapshot.data!.join(', ');
            //       return DataContainerWidget(
            //         rowMainAccess: MainAxisAlignment.center,
            //         color: cWhite,
            //         index: index,
            //         headerTitle: courses,
            //       );
            //     }
            //   },
            // ),
          ), //............................. Student courses type
          const SizedBox(
            width: 01,
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: DataContainerWidget(
                rowMainAccess: MainAxisAlignment.center,
                color: cWhite,
                index: index,
                headerTitle: stringTimeToDateConvert(data.joiningDate),
              ),
            ),
          ), //............................. Student join date
          const SizedBox(
            width: 01,
          ),
          Expanded(
            flex: 2,
            child: DataContainerWidget(
                rowMainAccess: MainAxisAlignment.center,
                color: cWhite,
                // width: 150,
                index: index,
                headerTitle: ' Pass/Fail'),
          ), //............................. Student Permission Status
          const SizedBox(
            width: 01,
          ),
         
        ],
      ),
    );
  }
}
