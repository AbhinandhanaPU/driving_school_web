import 'package:flutter/material.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/view/users/admin/admin_profile/admin_profile.dart';
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

                // ResponsiveWebSite.isMobile(context)
                //     ? const SizedBox(
                //         height: 0,
                //       )
                //     : Padding(
                //         padding: const EdgeInsets.only(top: 5),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Padding(
                //               padding: const EdgeInsets.only(
                //                 bottom: 5,
                //               ),
                //               child: Container(
                //                 height: 45,
                //                 width: 280,
                //                 decoration: BoxDecoration(
                //                   color: Colors.grey.withOpacity(0.2),
                //                   borderRadius: BorderRadius.circular(10),
                //                 ),
                //                 child: Row(
                //                   children: [
                //                     // const TextFontWidget(text: '🗓️', fontsize: 12),
                //                     const Padding(
                //                       padding: EdgeInsets.all(8.0),
                //                       child:
                //                           Icon(Icons.calendar_month_outlined),
                //                     ),
                //                     const Spacer(),
                //                     Padding(
                //                       padding: const EdgeInsets.only(right: 10),
                //                       child: GestureDetector(
                //                         onTap: () =>
                //                             academicYearSettingFunction(
                //                                 context),
                //                         child: Container(
                //                           height: 34,
                //                           width: 34,
                //                           decoration: BoxDecoration(
                //                               color: cWhite,
                //                               borderRadius:
                //                                   BorderRadius.circular(20)),
                //                           child: const Center(
                //                             child: Icon(
                //                               Icons.settings_outlined,
                //                               color: cBlack,
                //                             ),
                //                           ),
                //                         ),
                //                       ),
                //                     )
                //                   ],
                //                 ),
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),

                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 109,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // FutureBuilder(
                              //   future: Get.put(AdminProfileController())
                              //       .fetchData(),
                              //   builder: (context, snapshot) {
                              //     if (snapshot.connectionState ==
                              //         ConnectionState.waiting) {
                              //       return const Center(
                              //           child: CircularProgressIndicator());
                              //     } else if (snapshot.hasError) {
                              //       return const Center(
                              //           child:
                              //               Text('Error'));
                              //     } else {
                              //       final data = snapshot.data;
                              //       if (data != null &&
                              //           data.containsKey('collection1')) {
                              //         return Text(
                              //           data['collection1'] ['adminUserName'] ??'',
                              //           style: const TextStyle(fontSize: 12),
                              //         );
                              //       } else if (data != null &&
                              //           data.containsKey('collection2')) {
                              //         return Text(
                              //           data['collection2']['userName'] ?? '',
                              //           style: const TextStyle(fontSize: 12),
                              //         );
                              //       } else {
                              //         return const Center(
                              //             child: Text("--"));
                              //       }
                              //     }
                              //   },
                              // ),

                              Padding(
                                padding: const EdgeInsets.only(right: 0),
                                child: Text(
                                  'Admin',
                                  style: TextStyle(
                                      color: cBlack.withOpacity(0.5),
                                      fontSize: 10.7),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 15,
                            child: IconButton(
                                focusNode: textButtonFocusNode2,
                                onPressed: () {
                                  // showPopupMenu(context);
                                },
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  size: 18,
                                  color: cBlack,
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
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
                  width: 10,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> widgets = [
    Container(height: 40, width: 60, color: Colors.transparent),
    Container(height: 40, width: 60, color: Colors.transparent),
    Container(height: 40, width: 60, color: Colors.transparent),
    Column(
      children: [
        Container(
          color: const Color.fromARGB(255, 42, 215, 197),
          width: 500,
          height: 40,
          child: const Center(
            child: Text(
              'All Messages',
              style: TextStyle(
                fontSize: 16,
                color: cWhite,
              ),
            ),
          ),
        ),
        Container(
          color: themeColorGreen.withOpacity(0.1),
          width: 500,
          height: 300,
          child: ListView.separated(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: const ListTile(
                    leading: CircleAvatar(
                      radius: 05,
                    ),
                    title: Text(
                      'Title',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Messages',
                      style: TextStyle(fontSize: 11),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount: 20),
        ),
      ],
    ),
    Column(
      children: [
        Container(
          color: const Color.fromARGB(255, 255, 49, 49),
          width: 400,
          height: 40,
          child: const Center(
            child: Text(
              'All Notifications',
              style: TextStyle(
                fontSize: 15,
                color: cWhite,
              ),
            ),
          ),
        ),
        Container(
          color: themeColorGreen.withOpacity(0.1),
          width: 400,
          height: 300,
          child: ListView.separated(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: const ListTile(
                    leading: CircleAvatar(
                      radius: 05,
                    ),
                    title: Text(
                      'Title',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Messages',
                      style: TextStyle(fontSize: 11),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount: 20),
        ),
      ],
    ),
    Column(
      children: [
        Container(
          color: const Color.fromARGB(255, 255, 160, 1),
          width: 200,
          height: 40,
          child: const Center(
            child: Text(
              'Steven Zone',
              style: TextStyle(
                  fontSize: 15, color: cWhite, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        SizedBox(
          width: 200,
          height: 200,
          child: Column(
            children: [
              Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                    border: Border.all(color: cBlack.withOpacity(0.4))),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(7),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.transparent,
                        child: Image.asset('webassets/png/avathar.png'),
                      ),
                    ),
                    const TextFontWidget(
                      text: 'Stevne Zone',
                      fontsize: 12,
                      color: cBlack,
                      fontWeight: FontWeight.w400,
                    )
                  ],
                ),
              ),
              Container(
                height: 35,
                width: 200,
                decoration: BoxDecoration(
                    border: Border.all(color: cBlack.withOpacity(0.4))),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Icon(
                        Icons.account_circle_outlined,
                        size: 24,
                        color: cBlack,
                      ),
                    ),
                    TextFontWidget(
                      text: 'My Profile',
                      fontsize: 12,
                      color: cBlack,
                      fontWeight: FontWeight.w500,
                    )
                  ],
                ),
              ),
              Container(
                height: 35,
                width: 200,
                decoration: BoxDecoration(
                    border: Border.all(color: cBlack.withOpacity(0.4))),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Icon(
                        Icons.power_settings_new,
                        size: 24,
                        color: cBlack,
                      ),
                    ),
                    TextFontWidget(
                      text: 'Log Out',
                      fontsize: 12,
                      color: cBlack,
                      fontWeight: FontWeight.w500,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  ];
}
