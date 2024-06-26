import 'package:flutter/material.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/fonts/google_poppins_widget.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/view/users/admin/screens/events/event_create.dart';
import 'package:new_project_driving/view/users/admin/screens/videos/video_data_list.dart';
import 'package:new_project_driving/view/widget/button_container_widget/button_container_widget.dart';
import 'package:new_project_driving/view/widget/responsive/responsive.dart';
import 'package:new_project_driving/view/widget/routeSelectedTextContainer/routeSelectedTextContainer.dart';

class VideosList extends StatelessWidget {
  const VideosList({super.key});

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
                text: 'Videos ',
                fontsize: ResponsiveWebSite.isMobile(context) ? 18 : 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Row(
                children: [
                  const RouteSelectedTextContainer(
                      width: 180, title: 'All Videos'),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      createEventAdmin(context);
                    },
                    child: ButtonContainerWidget(
                      curving: 30,
                      colorindex: 0,
                      height: 40,
                      width: 180,
                      child: const Center(
                        child: TextFontWidgetRouter(
                          text: 'Upload Videos',
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Container(
                  width: ResponsiveWebSite.isDesktop(context)
                      ? double.infinity
                      : 1200,
                  decoration: BoxDecoration(
                    color: cWhite,
                    border: Border.all(color: cWhite),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: SizedBox(
                        child:
                            //  StreamBuilder(
                            //   stream: server
                            //       .collection('DrivingSchoolCollection')
                            //       .doc(UserCredentialsController.schoolId)
                            //       .collection('Videos')
                            //       .snapshots(),
                            //   builder: (context, snaPS) {
                            //     if (snaPS.connectionState ==
                            //         ConnectionState.waiting) {
                            //       return const Center(
                            //           child: CircularProgressIndicator());
                            //     }
                            //     if (snaPS.data!.docs.isEmpty) {
                            //       return const Center(
                            //           child: Text(
                            //         'No Videos',
                            //         style: TextStyle(
                            //             fontSize: 20, fontWeight: FontWeight.w500),
                            //       ));
                            //     }
                            //     if (snaPS.hasData) {
                            // return
                            GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 4.0,
                                  mainAxisSpacing: 4.0,
                                ),
                                itemBuilder: (context, index) {
                                  // final data = EventModel.fromMap(
                                  //     snaPS.data!.docs[index].data());
                                  return const VideoThumbnail(
                                      // data: data,
                                      // color: Colors.transparent,
                                      // index: index,
                                      );
                                },
                                itemCount: 3
                                // snaPS.data!.docs.length
                                )
                        //     } else {
                        //       return const LoadingWidget();
                        //     }
                        //   },
                        // ),
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
