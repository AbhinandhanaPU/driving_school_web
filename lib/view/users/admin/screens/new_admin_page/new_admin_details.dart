import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/controller/admin_section/admin_controller/admin_controller.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/model/new_admin_model/new_admin_model.dart';
import 'package:new_project_driving/utils/firebase/firebase.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';
import 'package:new_project_driving/view/users/admin/screens/new_admin_page/create_admin.dart';
import 'package:new_project_driving/view/users/admin/screens/new_admin_page/admin_data_list.dart';
import 'package:new_project_driving/view/widget/button_container_widget/button_container_widget.dart';
import 'package:new_project_driving/view/widget/loading_widget/loading_widget.dart';
import 'package:new_project_driving/view/widget/responsive/responsive.dart';
import 'package:new_project_driving/view/widget/reusable_table_widgets/category_table_header.dart';
import 'package:new_project_driving/view/widget/routeSelectedTextContainer/routeSelectedTextContainer.dart';

class AllAdminListPage extends StatelessWidget {
  final AdminController adminController = Get.put(AdminController());
  AllAdminListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => adminController.ontapCreateAdmin.value == true
          ? CreateAdmin()
          : SingleChildScrollView(
              scrollDirection: ResponsiveWebSite.isMobile(context)
                  ? Axis.horizontal
                  : Axis.vertical,
              child: Container(
                height: 700,
                width: ResponsiveWebSite.isDesktop(context)
                    ? double.infinity
                    : 1200,
                color: const Color.fromARGB(255, 242, 236, 236),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                    top: 40,
                    bottom: 30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'List Of Admins',
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: const RouteSelectedTextContainer(
                                width: 130, title: 'ALL ADMINS'),
                          ),
                          const Spacer(),
                          ResponsiveWebSite.isMobile(context)
                              ? Column(
                                  children: [
                                    // Add some spacing (optional)
                                    GestureDetector(
                                      onTap: () {
                                        adminController.ontapCreateAdmin.value =
                                            true;
                                      },
                                      child: ButtonContainerWidget(
                                        curving: 30,
                                        colorindex: 0,
                                        height: 35,
                                        width: 130,
                                        child: const Center(
                                          child: TextFontWidgetRouter(
                                            text: 'Create Admin',
                                            fontsize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: cWhite,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : GestureDetector(
                                  // Use GestureDetector on larger screens
                                  onTap: () {
                                    adminController.ontapCreateAdmin.value =
                                        true;
                                  },
                                  child: ButtonContainerWidget(
                                    curving: 30,
                                    colorindex: 0,
                                    height: 35,
                                    width: 150,
                                    child: const Center(
                                      child: TextFontWidgetRouter(
                                        text: 'Create Admin',
                                        fontsize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: cWhite,
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        color: cWhite,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: Container(
                            color: cWhite,
                            height: 40,
                            child: const Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: CatrgoryTableHeaderWidget(
                                        headerTitle: 'No')),
                                SizedBox(
                                  width: 01,
                                ),
                                Expanded(
                                    flex: 4,
                                    child: CatrgoryTableHeaderWidget(
                                        headerTitle: 'Admin Name')),
                                SizedBox(
                                  width: 02,
                                ),
                                Expanded(
                                    flex: 4,
                                    child: CatrgoryTableHeaderWidget(
                                        headerTitle: 'E mail')),
                                SizedBox(
                                  width: 02,
                                ),
                                Expanded(
                                    flex: 3,
                                    child: CatrgoryTableHeaderWidget(
                                        headerTitle: 'Phone Number')),
                                SizedBox(
                                  width: 02,
                                ),
                                Expanded(
                                    flex: 3,
                                    child: CatrgoryTableHeaderWidget(
                                        headerTitle: 'Active/Deactive')),
                                SizedBox(
                                  width: 02,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          // width: 1200,
                          decoration: BoxDecoration(
                            color: cWhite,
                            border: Border.all(color: cWhite),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: SizedBox(
                              // width: 1100,
                              child: StreamBuilder(
                                stream: server
                                    .collection('DrivingSchoolCollection')
                                    .doc(UserCredentialsController.schoolId)
                                    .collection('Admins')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return ListView.separated(
                                      itemBuilder: (context, index) {
                                        final data = AdminDetailsModel.fromMap(
                                            snapshot.data!.docs[index].data());
                                        return AdminDataList(
                                          index: index,
                                          data: data,
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(
                                        height: 1,
                                      ),
                                      itemCount: snapshot.data!.docs.length,
                                    );
                                  } else {
                                    return const LoadingWidget();
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
