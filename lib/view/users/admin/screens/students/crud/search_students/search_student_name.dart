import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/controller/admin_section/student_controller/student_controller.dart';
import 'package:new_project_driving/fonts/google_poppins_widget.dart';
import 'package:new_project_driving/model/student_model/student_model.dart';
import 'package:new_project_driving/view/users/admin/screens/students/students_list/student_data_list.dart';
import 'package:new_project_driving/view/widget/reusable_table_widgets/category_table_header.dart';

class AllStudentSearchByName extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(
          Icons.clear,
          color: Colors.black,
        ));
    return null;
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<StudentModel> suggestionList;

    if (query.isEmpty) {
      suggestionList = Get.find<StudentController>().studentProfileList;
    } else {
      suggestionList = Get.find<StudentController>()
          .studentProfileList
          .where((item) =>
              item.studentName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    if (suggestionList.isEmpty) {
      return ListTile(
        title: GooglePoppinsWidgets(
          text: "User not found",
          fontsize: 18,
          fontWeight: FontWeight.w400,
        ),
      );
    }
    return Scaffold(
      body: SafeArea(
        child: ListView.separated(
          itemBuilder: (context, index) {
            final data = suggestionList[index];
            return GestureDetector(
              onTap: () async {
                // Get.find<StudentController>().studentModelData.value = data;
                // Get.find<StudentController>().ontapStudent.value = true;
                Get.back();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 75,
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child:
                                  CatrgoryTableHeaderWidget(headerTitle: 'No')),
                          SizedBox(
                            width: 02,
                          ),
                          Expanded(
                              flex: 4,
                              child: CatrgoryTableHeaderWidget(
                                  headerTitle: 'Name')),
                          SizedBox(
                            width: 02,
                          ),
                          Expanded(
                              flex: 3,
                              child: CatrgoryTableHeaderWidget(
                                  headerTitle: 'Ph.NO')),
                          SizedBox(
                            width: 02,
                          ),
                          Expanded(
                              flex: 3,
                              child: CatrgoryTableHeaderWidget(
                                  headerTitle: 'Courses type')),
                          SizedBox(
                            width: 02,
                          ),
                          Expanded(
                              flex: 2,
                              child: CatrgoryTableHeaderWidget(
                                  headerTitle: 'Join Date')),
                          SizedBox(
                            width: 02,
                          ),
                          Expanded(
                              flex: 2,
                              child: CatrgoryTableHeaderWidget(
                                  headerTitle: 'Permission Status')),
                          SizedBox(
                            width: 02,
                          ),
                          Expanded(
                              flex: 2,
                              child: CatrgoryTableHeaderWidget(
                                  headerTitle: 'Status')),
                          SizedBox(
                            width: 02,
                          ),
                        ],
                      ),
                      AllStudentDataList(data: data, index: index)
                    ],
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 10,
            );
          },
          itemCount: suggestionList.length,
        ),
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox();
  }
}
