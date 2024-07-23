import 'package:flutter/material.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/fonts/google_poppins_widget.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/utils/firebase/firebase.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';
import 'package:new_project_driving/view/users/admin/screens/study_materials/study_materials_data_list.dart';
import 'package:new_project_driving/view/users/admin/screens/study_materials/upload_materials.dart';
import 'package:new_project_driving/view/widget/button_container_widget/button_container_widget.dart';
import 'package:new_project_driving/view/widget/loading_widget/loading_widget.dart';
import 'package:new_project_driving/view/widget/responsive/responsive.dart';
import 'package:new_project_driving/view/widget/reusable_table_widgets/category_table_header.dart';
import 'package:new_project_driving/view/widget/routeSelectedTextContainer/routeSelectedTextContainer.dart';

class StudyMaterialsList extends StatelessWidget {
  const StudyMaterialsList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection:
          ResponsiveWebSite.isMobile(context) ? Axis.horizontal : Axis.vertical,
      child: Container(
        color: screenContainerbackgroundColor,
        height: 650,
        width: ResponsiveWebSite.isDesktop(context) ? double.infinity : 1200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: GooglePoppinsWidgets(
                text: 'Study Materials ',
                fontsize: ResponsiveWebSite.isMobile(context) ? 18 : 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Row(
                children: [
                  const RouteSelectedTextContainer(
                      width: 180, title: 'Study Materials'),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      uploadStudyMaterials(context);
                    },
                    child: ButtonContainerWidget(
                      curving: 30,
                      colorindex: 0,
                      height: 40,
                      width: 180,
                      child: const Center(
                        child: TextFontWidgetRouter(
                          text: 'Upload Study Material',
                          fontsize: 14,
                          fontWeight: FontWeight.bold,
                          color: cWhite,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
              child: Container(
                color: cWhite,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Container(
                    width: ResponsiveWebSite.isDesktop(context)
                        ? double.infinity
                        : 1200,
                    color: cWhite,
                    height: 40,
                    child: const Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: CatrgoryTableHeaderWidget(headerTitle: 'No'),
                        ),
                        SizedBox(
                          width: 01,
                        ),
                        Expanded(
                          flex: 4,
                          child:
                              CatrgoryTableHeaderWidget(headerTitle: 'Title'),
                        ),
                        SizedBox(
                          width: 02,
                        ),
                        Expanded(
                          flex: 4,
                          child: CatrgoryTableHeaderWidget(
                              headerTitle: 'Description'),
                        ),
                        SizedBox(
                          width: 02,
                        ),
                        Expanded(
                          flex: 4,
                          child: CatrgoryTableHeaderWidget(
                              headerTitle: 'Category'),
                        ),
                        SizedBox(
                          width: 02,
                        ),
                        Expanded(
                          flex: 3,
                          child: CatrgoryTableHeaderWidget(headerTitle: 'Type'),
                        ),
                        SizedBox(
                          width: 02,
                        ),
                        Expanded(
                          flex: 2,
                          child: CatrgoryTableHeaderWidget(headerTitle: 'Edit'),
                        ),
                        SizedBox(
                          width: 02,
                        ),
                        Expanded(
                          flex: 2,
                          child:
                              CatrgoryTableHeaderWidget(headerTitle: 'Delete'),
                        ),
                        SizedBox(
                          width: 02,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  width: ResponsiveWebSite.isDesktop(context)
                      ? double.infinity
                      : 1200,
                  decoration: BoxDecoration(
                    color: cWhite,
                    border: Border.all(color: cWhite),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: SizedBox(
                      child: StreamBuilder(
                        stream: server
                            .collection('DrivingSchoolCollection')
                            .doc(UserCredentialsController.schoolId)
                            .collection('StudyMaterials')
                            .snapshots(),
                        builder: (context, snaPS) {
                          if (snaPS.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (snaPS.data!.docs.isEmpty) {
                            return const Center(
                              child: Text(
                                'No Study Materials',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                            );
                          }
                          if (snaPS.hasData) {
                            return ListView.separated(
                                itemBuilder: (context, index) {
                                  final data = snaPS.data!.docs[index].data();
                                  return GestureDetector(
                                    onTap: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) =>
                                      //         PDFSectionScreen(
                                      //       urlPdf: snaPS.data!.docs[index]
                                      //           ['downloadUrl'],
                                      //     ),
                                      //   ),
                                      // );
                                    },
                                    child: StudyMaterialsDataList(
                                      data: data,
                                      index: index,
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 02,
                                  );
                                },
                                itemCount: snaPS.data!.docs.length);
                          } else {
                            return const LoadingWidget();
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
