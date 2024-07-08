import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/controller/study_materials/study_materials_controller.dart';
import 'package:new_project_driving/view/users/admin/screens/study_materials/study_materials_edit.dart';
import 'package:new_project_driving/view/widget/custom_delete_showdialog/custom_delete_showdialog.dart';
import 'package:new_project_driving/view/widget/reusable_table_widgets/data_container.dart';

class StudyMaterialsDataList extends StatelessWidget {
  final int index;
  final Map<String, dynamic> data;
  const StudyMaterialsDataList({
    super.key,
    required this.index,
    required this.data,
  });
  @override
  Widget build(BuildContext context) {
    StudyMaterialsController studyMaterialsController =
        Get.put(StudyMaterialsController());
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
                headerTitle: '${index + 1}'), //....................No
          ),
          const SizedBox(
            width: 02,
          ),
          Expanded(
            flex: 4,
            child: DataContainerWidget(
              rowMainAccess: MainAxisAlignment.center,
              color: cWhite,
              index: index,
              headerTitle: data['title'],
            ),
          ), //.............................Video Name
          const SizedBox(
            width: 02,
          ),
          Expanded(
            flex: 4,
            child: DataContainerWidget(
              rowMainAccess: MainAxisAlignment.center,
              color: cWhite,
              // width: 150,
              index: index,
              headerTitle: data['des'],
            ),
          ), // ...................................Video Description
          const SizedBox(
            width: 02,
          ),
          Expanded(
            flex: 4,
            child: DataContainerWidget(
              rowMainAccess: MainAxisAlignment.center,
              color: cWhite,
              // width: 150,
              index: index,
              headerTitle: data['category'],
            ),
          ), // ...................................Video Category
          const SizedBox(
            width: 02,
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  studyMaterialsController.titleEditController.text =
                      data['title'];
                  studyMaterialsController.desEditController.text = data['des'];
                  studyMaterialsController.cateEditController.text =
                      data['category'];
                  editFunctionOfStudyMaterials(context, data);
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
                      await studyMaterialsController.deleteStudyMaterial(
                          docId: data['docId']);
                      //  .then((value) => Navigator.pop(context));
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
        ],
      ),
    );
  }
}
