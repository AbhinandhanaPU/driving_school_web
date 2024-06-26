import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/controller/notice_controller/notice_controller.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/model/notice_model/notice_model.dart';
import 'package:new_project_driving/utils/firebase/firebase.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';
import 'package:new_project_driving/view/users/admin/screens/notice/notice_create.dart';
import 'package:new_project_driving/view/users/admin/screens/notice/notice_data_list.dart';
import 'package:new_project_driving/view/widget/button_container_widget/button_container_widget.dart';
import 'package:new_project_driving/view/widget/responsive/responsive.dart';
import 'package:new_project_driving/view/widget/reusable_table_widgets/category_table_header.dart';
import 'package:new_project_driving/view/widget/routeSelectedTextContainer/routeSelectedTextContainer.dart';

class NoticeAllList extends StatelessWidget {
  final NoticeController noticeController = Get.put(NoticeController());
  NoticeAllList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection:
          ResponsiveWebSite.isMobile(context) ? Axis.horizontal : Axis.vertical,
      child: Container(
        color: screenContainerbackgroundColor,
        height: 650,
        width: ResponsiveWebSite.isDesktop(context) ? double.infinity : 1200,
        padding: const EdgeInsets.only(left: 25, right: 25, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Notice ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  const RouteSelectedTextContainer(
                      width: 180, title: 'All Notices'),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      createNoticeAdmin(context);
                    },
                    child: ButtonContainerWidget(
                        curving: 30,
                        colorindex: 0,
                        height: 40,
                        width: 180,
                        child: const Center(
                          child: TextFontWidgetRouter(
                            text: 'Create Notices',
                            fontsize: 14,
                            fontWeight: FontWeight.bold,
                            color: cWhite,
                          ),
                        )),
                  )
                ],
              ),
            ),
            Container(
              color: cWhite,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 5,
                  right: 5,
                ),
                child: Container(
                  color: cWhite,
                  height: 40,
                  child: const Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: CatrgoryTableHeaderWidget(
                              headerTitle: 'Heading')),
                      SizedBox(
                        width: 01,
                      ),
                      Expanded(
                          flex: 3,
                          child: CatrgoryTableHeaderWidget(
                              headerTitle: 'Subject')),
                      SizedBox(
                        width: 02,
                      ),
                      Expanded(
                          flex: 3,
                          child: CatrgoryTableHeaderWidget(
                              headerTitle: 'Published Date')),
                      SizedBox(
                        width: 02,
                      ),
                      Expanded(
                        flex: 2,
                        child:
                            CatrgoryTableHeaderWidget(headerTitle: 'Signed by'),
                      ),
                      SizedBox(
                        width: 02,
                      ),
                      Expanded(
                        flex: 1,
                        child: CatrgoryTableHeaderWidget(headerTitle: 'Edit'),
                      ),
                      SizedBox(
                        width: 02,
                      ),
                      Expanded(
                        flex: 1,
                        child: CatrgoryTableHeaderWidget(headerTitle: 'Delete'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: ResponsiveWebSite.isDesktop(context)
                    ? double.infinity
                    : 1200,
                padding: const EdgeInsets.only(left: 5, right: 5),
                decoration: BoxDecoration(
                  color: cWhite,
                  border: Border.all(color: cWhite),
                ),
                child: StreamBuilder(
                    stream: server
                        .collection('DrivingSchoolCollection')
                        .doc(UserCredentialsController.schoolId)
                        .collection('AdminNotices')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.data!.docs.isEmpty) {
                        return const Center(
                            child: Text(
                          'No Notices',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ));
                      }
                      return ListView.separated(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          NoticeModel data = NoticeModel.fromMap(
                              snapshot.data!.docs[index].data());
                          return AllNoticeDataList(data: data, index: index);
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 02,
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
