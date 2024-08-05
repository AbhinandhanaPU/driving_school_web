import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/controller/admin_section/Tutor_controller/tutor_controller.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/model/teacher_model/teacher_model.dart';
import 'package:new_project_driving/view/widget/custom_delete_showdialog/custom_delete_showdialog.dart';
import 'package:new_project_driving/view/widget/reusable_table_widgets/data_container.dart';

class AllTutorDataList extends StatelessWidget {
  final int index;
  final TeacherModel data;
  const AllTutorDataList({
    required this.index,
    required this.data,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TutorController tutorController = Get.put(TutorController());
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
                // width: 150,
                index: index,
                headerTitle: '${index + 1}'), //....................No
          ),
          const SizedBox(
            width: 01,
          ),

          Expanded(
            flex: 4,
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
                    text: "  ${data.teacherName}",
                    fontsize: 12,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ), //........................................... teacher Name
          const SizedBox(
            width: 01,
          ),
          Expanded(
            flex: 4,
            child: Row(
              children: [
                SizedBox(
                  width: 15,
                  child: Center(
                    child: Image.asset(
                      'webassets/png/gmail.png',
                    ),
                  ),
                ),
                Expanded(
                    child: TextFontWidget(
                  text: "  ${data.teacheremail}",
                  fontsize: 12,
                  overflow: TextOverflow.ellipsis,
                )),
              ],
            ),
          ), // ................................... teacher Email
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
          ), //....................................... teacher Phone Number
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
                    text: "  ${data.licenceNumber}",
                    fontsize: 12,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ), //....................................... teacher licence number
          const SizedBox(
            width: 01,
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 15,
                  child: Image.asset(
                    'webassets/png/active.png',
                  ),
                ),
                const TextFontWidget(
                  text: "   ",
                  fontsize: 12,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ), //............................. Status [Active or DeActivate]
          const SizedBox(
            width: 01,
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  customDeleteShowDialog(
                    context: context,
                    onTap: () {
                      tutorController
                          .deleteTutor(data)
                          .then((value) => Navigator.pop(context));
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
          ), //........................................... delete
          const SizedBox(
            width: 01,
          ),
        ],
      ),
    );
  }
}
