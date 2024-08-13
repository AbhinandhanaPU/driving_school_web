import 'package:flutter/material.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/model/course_model/course_model.dart';
import 'package:new_project_driving/utils/firebase/firebase.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';
import 'package:new_project_driving/view/widget/reusable_table_widgets/data_container.dart';

class FeeCoursesDataList extends StatelessWidget {
  final CourseModel data;
  final int index;
  const FeeCoursesDataList({
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
              flex: 2,
              child: TextFontWidget(
                text: '  ${data.courseName}',
                fontsize: 12,
                overflow: TextOverflow.ellipsis,
              )), //................................................. courseType
          const SizedBox(
            width: 02,
          ),
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: TextFontWidget(
                text: '  ${data.duration} Days',
                fontsize: 12,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ), //........................................... duration
          const SizedBox(
            width: 02,
          ),
          Expanded(
            flex: 2,
            child: TextFontWidget(
              text: '  ${data.rate}',
              fontsize: 12,
              overflow: TextOverflow.ellipsis,
            ),
          ), //........................................... rate
          const SizedBox(
            width: 02,
          ),
          StreamBuilder(
            stream: server
                .collection('DrivingSchoolCollection')
                .doc(UserCredentialsController.schoolId)
                .collection('FeeCollection')
                .doc(data.courseId)
                .collection("Students")
                .snapshots(),
            builder: (context, snapCount) {
              return Expanded(
                flex: 2,
                child: TextFontWidget(
                  text: '${snapCount.data?.docs.length}',
                  fontsize: 12,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            },
          ),
          const SizedBox(
            width: 02,
          ),
        ],
      ),
    );
  }
}
