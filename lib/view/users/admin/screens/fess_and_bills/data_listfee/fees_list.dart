import 'package:flutter/material.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/view/users/admin/screens/fess_and_bills/data_listfee/fees_data_list.dart';
import 'package:new_project_driving/view/widget/button_container_widget/button_container_widget.dart';
import 'package:new_project_driving/view/widget/responsive/responsive.dart';
import 'package:new_project_driving/view/widget/reusable_table_widgets/category_table_header.dart';
import 'package:new_project_driving/view/widget/routeSelectedTextContainer/routeSelectedTextContainer.dart';

class FeesAndBillsList extends StatelessWidget {
  const FeesAndBillsList({super.key});

  @override
  Widget build(BuildContext context) {
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
              padding: EdgeInsets.only(left: 10, top: 25),
              child: TextFontWidget(
                text: 'Fee Details',
                fontsize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 10, left: 10, right: 10),
              child: Row(
                children: [
                  const RouteSelectedTextContainer(
                    width: 140,
                    title: 'Fees Details',
                  ),
                  const Spacer(),
                  // GestureDetector(
                  //   onTap: () async {
                  //     Get.find<FeesAndBillsController>()
                  //         .sendMessageForUnPaidStudentandParentsbool
                  //         .value = true;
                  //     await Get.find<FeesAndBillsController>()
                  //         .sendMessageForUnPaidStudents();
                  //   },
                  // child: Obx(
                  //   () =>
                  //     child: Get.find<FeesAndBillsController>()
                  //                 .sendMessageForUnPaidStudentandParentsbool
                  //                 .value ==
                  //             true
                  //         ? const SizedBox(
                  //             child: CircularProgressIndicator.adaptive(),
                  //           )
                  //         :
                  ButtonContainerWidget(
                    curving: 0,
                    colorindex: 6,
                    height: 35,
                    width: 220,
                    child: const Center(
                      child: TextFontWidgetRouter(
                        text: 'Send Message For Unpaid Students',
                        fontsize: 12,
                        fontWeight: FontWeight.bold,
                        color: cWhite,
                      ),
                    ),
                  ),
                  // ),
                  // ),
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
                            child:
                                CatrgoryTableHeaderWidget(headerTitle: 'No')),
                        SizedBox(
                          width: 02,
                        ),
                        Expanded(
                            flex: 2,
                            child: CatrgoryTableHeaderWidget(
                                headerTitle: 'Student Name')),
                        SizedBox(
                          width: 02,
                        ),
                        Expanded(
                          flex: 2,
                          child: CatrgoryTableHeaderWidget(headerTitle: 'Fee'),
                        ),
                        SizedBox(
                          width: 02,
                        ),
                        Expanded(
                          flex: 2,
                          child: CatrgoryTableHeaderWidget(
                              headerTitle: 'Advance Amount'),
                        ),
                        SizedBox(
                          width: 02,
                        ),
                        Expanded(
                          flex: 2,
                          child: CatrgoryTableHeaderWidget(
                              headerTitle: 'Pending Amount'),
                        ),
                        SizedBox(
                          width: 02,
                        ),
                        Expanded(
                          flex: 2,
                          child: CatrgoryTableHeaderWidget(
                              headerTitle: 'Due Date'),
                        ),
                        SizedBox(
                          width: 02,
                        ),
                        Expanded(
                          flex: 2,
                          child:
                              CatrgoryTableHeaderWidget(headerTitle: 'status'),
                        ),
                        SizedBox(
                          width: 02,
                        ),
                        Expanded(
                          flex: 2,
                          child: CatrgoryTableHeaderWidget(headerTitle: 'Paid'),
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
                        child:
                            //  StreamBuilder(
                            //   stream: server
                            //       .collection('DrivingSchoolCollection')
                            //       .doc(UserCredentialsController.schoolId)
                            //       .collection('FeesCollection')
                            //       .orderBy(
                            //         'feepaid',
                            //       )
                            //       .snapshots(),
                            //   builder: (context, snaps) {
                            //     if (snaps.hasData) {
                            //       return
                            ListView.separated(
                                itemBuilder: (context, index) {
                                  // final data = snaps.data!.docs[index].data();
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: ClassWiseFeesDataListContainer(
                                        // studentFee: data['fee'],
                                        // studentdata: data,
                                        index: index),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 02,
                                  );
                                },
                                itemCount: 2
                                // snaps.data!.docs.length
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
