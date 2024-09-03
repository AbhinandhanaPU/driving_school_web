import 'package:flutter/material.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';
import 'package:new_project_driving/view/users/admin/admin_profile/admin_profile.dart';
import 'package:new_project_driving/view/users/admin/app_bar/batch/create_batch.dart';
import 'package:new_project_driving/view/widget/responsive/responsive.dart';
import 'package:sidebar_drawer/sidebar_drawer.dart';

// ignore: must_be_immutable
class AppBarAdminPanel extends StatelessWidget {
  AppBarAdminPanel({
    super.key,
  });

  final int index = 0;

  final layerLink = LayerLink();

  final textButtonFocusNode = FocusNode();

  final textButtonFocusNode1 = FocusNode();

  final textButtonFocusNode2 = FocusNode();

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(100.0),
      child: Container(
        color: Colors.white24,
        height: ResponsiveWebSite.isMobile(context) ? 112 : 70,
        width: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(14)),
                            color: Color.fromARGB(255, 61, 94, 225)),
                        child: const DrawerIcon(),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Container(
                          height: 45,
                          width: 150,
                          padding: const EdgeInsets.only(right: 10, left: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              const TextFontWidget(
                                text: 'Create Batch',
                                fontsize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  createBatchFunction(context);
                                },
                                child: Container(
                                  height: 34,
                                  width: 34,
                                  decoration: BoxDecoration(
                                      color: cWhite,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: const Center(
                                    child: Icon(
                                      Icons.add,
                                      color: cBlack,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        UserCredentialsController.adminModel!.adminName,
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 0),
                        child: Text(
                          'Admin',
                          style: TextStyle(
                              color: cBlack.withOpacity(0.5), fontSize: 10.7),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    adminProfileshowlist(context);
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 20,
                    child: Image.asset(
                      'webassets/png/avathar.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 25,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
