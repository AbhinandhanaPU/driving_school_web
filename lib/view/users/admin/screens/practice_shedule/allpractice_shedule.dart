import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/controller/notification_controller/notification_controller.dart';
import 'package:new_project_driving/controller/practice_shedule_controller/practice_shedule_controller.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/model/practice_shedule_model/practice_shedule_model.dart';
import 'package:new_project_driving/utils/firebase/firebase.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';
import 'package:new_project_driving/view/users/admin/screens/practice_shedule/practise_functions/create_practice.dart';
import 'package:new_project_driving/view/users/admin/screens/practice_shedule/practise_functions/practice_showdialodue.dart';
import 'package:new_project_driving/view/users/admin/screens/practice_shedule/std_details/practice_shedule_data_list.dart';
import 'package:new_project_driving/view/users/admin/screens/practice_shedule/std_details/std_list.dart';
import 'package:new_project_driving/view/widget/button_container_widget/button_container_widget.dart';
import 'package:new_project_driving/view/widget/loading_widget/loading_widget.dart';
import 'package:new_project_driving/view/widget/responsive/responsive.dart';
import 'package:new_project_driving/view/widget/reusable_table_widgets/category_table_header.dart';
import 'package:new_project_driving/view/widget/routeSelectedTextContainer/routeSelectedTextContainer.dart';
import 'package:progress_state_button/progress_button.dart';

class AllPracticeShedules extends StatelessWidget {
  AllPracticeShedules({super.key});

  final PracticeSheduleController practiceSheduleController =
      Get.put(PracticeSheduleController());
  final NotificationController notificationController =
      Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => practiceSheduleController.onTapSchedule.value == true
          ? PracticeStudentListContainer()
          : SingleChildScrollView(
              scrollDirection: ResponsiveWebSite.isMobile(context)
                  ? Axis.horizontal
                  : Axis.vertical,
              child: Container(
                color: screenContainerbackgroundColor,
                height: 650,
                width: ResponsiveWebSite.isDesktop(context)
                    ? double.infinity
                    : 1200,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextFontWidget(
                            text: 'Practice schedule',
                            fontsize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          const RouteSelectedTextContainer(
                            title: 'Schedule List',
                            width: 200,
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              sendPracticeScheduleNotification(context);
                              practiceSheduleController
                                  .selectAllSchedule.value = false;
                              practiceSheduleController.buttonstate.value =
                                  ButtonState.idle;
                            },
                            child: ButtonContainerWidget(
                              curving: 0,
                              colorindex: 6,
                              height: 35,
                              width: 220,
                              child: const Center(
                                child: TextFontWidgetRouter(
                                  text: 'Send practice schedule to Students',
                                  fontsize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: cWhite,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              createPracticeAdmin(context);
                            },
                            child: ButtonContainerWidget(
                                curving: 30,
                                colorindex: 0,
                                height: 35,
                                width: 120,
                                child: const Center(
                                  child: TextFontWidgetRouter(
                                    text: 'Create Slot',
                                    fontsize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: cWhite,
                                  ),
                                )),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
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
                                      headerTitle: 'No'),
                                ),
                                SizedBox(
                                  width: 02,
                                ),
                                Expanded(
                                  flex: 3,
                                  child: CatrgoryTableHeaderWidget(
                                      headerTitle: 'Slot Name'),
                                ),
                                SizedBox(
                                  width: 02,
                                ),
                                Expanded(
                                  flex: 3,
                                  child: CatrgoryTableHeaderWidget(
                                      headerTitle: ' Start Time'),
                                ),
                                SizedBox(
                                  width: 02,
                                ),
                                Expanded(
                                  flex: 3,
                                  child: CatrgoryTableHeaderWidget(
                                      headerTitle: 'End Time'),
                                ),
                                SizedBox(
                                  width: 02,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: CatrgoryTableHeaderWidget(
                                    headerTitle: 'Total Students',
                                  ),
                                ),
                                SizedBox(
                                  width: 02,
                                ),
                                Expanded(
                                  flex: 3,
                                  child: CatrgoryTableHeaderWidget(
                                      headerTitle: 'Edit'),
                                ),
                                SizedBox(
                                  width: 02,
                                ),
                                Expanded(
                                  flex: 3,
                                  child: CatrgoryTableHeaderWidget(
                                      headerTitle: 'Delete'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 400,
                          // width: 1200,
                          decoration: BoxDecoration(
                            color: cWhite,
                            border: Border.all(color: cWhite),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 5, left: 5),
                            child: SizedBox(
                              // width: 1100,
                              child: StreamBuilder(
                                stream: server
                                    .collection('DrivingSchoolCollection')
                                    .doc(UserCredentialsController.schoolId)
                                    .collection('PracticeSchedule')
                                    .snapshots(),
                                builder: (context, snaPS) {
                                  if (snaPS.hasData) {
                                    return snaPS.data!.docs.isEmpty
                                        ? const Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                "Please create Students",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                          )
                                        : ListView.separated(
                                            itemBuilder: (context, index) {
                                              final data =
                                                  PracticeSheduleModel.fromMap(
                                                      snaPS.data!.docs[index]
                                                          .data());
                                              return GestureDetector(
                                                onTap: () {
                                                  practiceSheduleController
                                                      .onTapSchedule
                                                      .value = true;
                                                  practiceSheduleController
                                                      .scheduleId
                                                      .value = data.practiceId;
                                                },
                                                child: PracticeSheduleDataList(
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
                                  } else if (snaPS.data == null) {
                                    return const LoadingWidget();
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
