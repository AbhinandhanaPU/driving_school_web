import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/controller/admin_section/Tutor_controller/tutor_controller.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';
import 'package:new_project_driving/view/widget/profile_detail_widget/detail_tile_container.dart';
import 'package:new_project_driving/view/widget/responsive/responsive.dart';
import 'package:new_project_driving/view/widget/routeSelectedTextContainer/routeSelectedTextContainer.dart';
import 'package:new_project_driving/view/widget/routeSelectedTextContainer/route_NonSelectedContainer.dart';

class TutorDetailsContainer extends StatelessWidget {
  final TutorController teacherController = Get.put(TutorController());
  TutorDetailsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final data = teacherController.tutorModelData.value;
    return SingleChildScrollView(
      scrollDirection:
          ResponsiveWebSite.isMobile(context) ? Axis.horizontal : Axis.vertical,
      child: Container(
        color: screenContainerbackgroundColor,
        height: 1000,
        width: ResponsiveWebSite.isDesktop(context) ? double.infinity : 1200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 25, top: 25),
              child: TextFontWidget(
                text: 'Teacher Details',
                fontsize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
              child: Container(
                color: cWhite,
                height: 260,
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      width: double.infinity,
                      color: Colors.white10,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 08,
                                      right: 05,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        teacherController.ontapviewTutor.value =
                                            false;
                                      },
                                      child:
                                          const RouteNonSelectedTextContainer(
                                              title: 'Home'),
                                    ),
                                  ),
                                  const RouteSelectedTextContainer(
                                      width: 140, title: 'Teacher Deatils'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      color: adminePrimayColor,
                      height: 02,
                    ),
                    Expanded(
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 05, left: 10),
                            child: CircleAvatar(
                              radius: 80,
                              backgroundColor: Colors.grey,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    UserCredentialsController
                                            .teacherModel?.profileImageUrl ??
                                        ""),
                                radius: 78,
                              ),
                              //  CircleAvatar(
                              //   radius: 78,
                              //   backgroundImage: AssetImage(
                              //       'webassets/png/teacher (1).png'),
                              // ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Container(
                                    width: double.infinity,
                                    height: 110,
                                    color: adminePrimayColor.withOpacity(0.1),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 10),
                                          child: TextFontWidget(
                                            text: '${data!.teacherName}',
                                            fontsize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 20, left: 10),
                                          child: SizedBox(
                                            width: 600,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ProfileDetailTileContainer(
                                                  flex: 1,
                                                  title: 'Phone No.',
                                                  subtitle:
                                                      '${data.phoneNumber}',
                                                ),
                                                ProfileDetailTileContainer(
                                                  flex: 1,
                                                  title: 'Email Id',
                                                  subtitle:
                                                      '${data.teacheremail}',
                                                ),
                                                 ProfileDetailTileContainer(
                                                  flex: 1,
                                                  title: 'Place',
                                                  subtitle:
                                                      '${data.place}',
                                                ),
                                                 ProfileDetailTileContainer(
                                                  flex: 1,
                                                  title: 'DOB',
                                                  subtitle:
                                                      '${data.dateofBirth}',
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  // flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(Icons.call),
                                            TextFontWidget(
                                              text: " ${data.phoneNumber}",
                                              fontsize: 12,
                                              color: adminePrimayColor,
                                            ),
                                            const Spacer(),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Icon(Icons.location_on),
                                            TextFontWidget(
                                              text:
                                                  "${data.address} , ${data.place}",
                                              fontsize: 12,
                                              color: adminePrimayColor,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      color: adminePrimayColor,
                      height: 02,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
