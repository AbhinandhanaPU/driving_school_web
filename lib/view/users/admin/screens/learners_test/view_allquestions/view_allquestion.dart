import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/controller/mocktest_controller/mocktest_controller.dart';
import 'package:new_project_driving/controller/mocktest_controller/model/answer_model.dart';
import 'package:new_project_driving/controller/mocktest_controller/model/question_model.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/utils/firebase/firebase.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';
import 'package:new_project_driving/view/users/admin/screens/learners_test/view_allquestions/edit_mock.dart';
import 'package:new_project_driving/view/widget/custom_delete_showdialog/custom_delete_showdialog.dart';
import 'package:new_project_driving/view/widget/responsive/responsive.dart';
import 'package:new_project_driving/view/widget/routeSelectedTextContainer/routeSelectedTextContainer.dart';
import 'package:new_project_driving/view/widget/routeSelectedTextContainer/route_NonSelectedContainer.dart';

class ViewAllQuestionsUploaded extends StatelessWidget {
  ViewAllQuestionsUploaded({super.key});

  final MockTestController mtController = Get.put(MockTestController());

   final RxMap<int, bool> expandedQuestionMap = <int, bool>{}.obs;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
     child: Container(
      height: 720,
      width: ResponsiveWebSite.isDesktop(context) ? double.infinity : 1200,
      color: screenContainerbackgroundColor,
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
             height: 680,
             width: ResponsiveWebSite.isDesktop(context) ? double.infinity : 1200,
             color: cWhite,
             padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
             child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
              Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   const Text(
                    'All Questions ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                   ),
                   Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: GestureDetector(
                          onTap: () {
                            mtController.ontapViewAllQuestions.value = false;
                          },
                          child: const SizedBox(
                            height: 35,
                            width: 100,
                            child: Padding(
                              padding: EdgeInsets.only(top: 5, left: 5),
                              child: RouteNonSelectedTextContainer(
                                title: 'Back',
                              ),
                            ),
                          ),
                        ),
                      ),const Spacer(),
                      Padding(
                          padding: const EdgeInsets.only(bottom: 10, left: 5),
                          child: StreamBuilder(
                            stream: server
                            .collection("DrivingSchoolCollection")
                            .doc(UserCredentialsController.schoolId)
                            .collection("MockTestCollection")
                            .snapshots(),
                            builder: (context, snapsh) {
                              //final noOfQuestions=snapsh.data?.docs.length;
                              return RouteSelectedTextContainer(
                                title:"No. Of Questions: ${snapsh.data?.docs.length}",
                              );
                            }
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 600,
                width: ResponsiveWebSite.isDesktop(context) ? double.infinity : 1200,
                child: StreamBuilder(
                    stream: server
                        .collection("DrivingSchoolCollection")
                        .doc(UserCredentialsController.schoolId)
                        .collection("MockTestCollection")
                        .orderBy('questionNo', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData || snapshot.data == null) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return ListView.separated(
                        itemBuilder: (context, index) {
                          QuizTestQuestionModel questiondata = 
                           QuizTestQuestionModel.fromMap( snapshot.data!.docs[index].data());
                          return Obx(() {
                               double containerHeight =
                                questiondata.imageID == null
                                ? 100 : 140;
                                bool isExpanded = expandedQuestionMap[index] ?? false;
          
                            if (isExpanded) {
                                containerHeight += 250; // Increase height when options are visible
                              }
                          return GestureDetector(
                            onTap: () {
                                  expandedQuestionMap[index] = !isExpanded;
                            },
                            child: Container(
                              height: containerHeight,
                              //questiondata.imageID == null ? 310 : 360,
                              width: ResponsiveWebSite.isDesktop(context)
                                  ? double.infinity : 1200,
                              color: const Color.fromARGB(255, 246, 246, 246),
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              height: questiondata.imageID == null
                                                  ? 50 : 100,
                                              color: themeColorBlue.withOpacity(0.1),
                                              alignment: Alignment.center,
                                              child: TextFontWidget(
                                                text: "  ${index + 1}",
                                                fontsize: 13,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 1),
                                          Expanded(
                                            flex: 15,
                                            child: questiondata.imageID == null
                                                ? Container(
                                                    height: 50,
                                                    color: themeColorBlue.withOpacity(0.1),
                                                    alignment: Alignment.centerLeft,
                                                    child: TextFontWidget(
                                                      text: questiondata.question,
                                                      fontsize: 14,
                                                      fontWeight:ResponsiveWebSite.isMobile(context)
                                                      ?FontWeight.w400: FontWeight.bold,
                                                    ),
                                                  )
                                                : Container(
                                                    height: 100,
                                                    color: themeColorBlue.withOpacity(0.1),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 3,
                                                          child: Image.network(
                                                            questiondata.imageID!,
                                                            height: 100,
                                                            errorBuilder: (context,
                                                                error, stackTrace) {
                                                              return const Icon(Icons.error);
                                                            },
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 10,
                                                          child: TextFontWidget(
                                                            text: questiondata.question,
                                                            fontsize:ResponsiveWebSite.isMobile(context)?12: 14,
                                                            fontWeight:ResponsiveWebSite.isMobile(context)?
                                                             FontWeight.w400:  FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                          ),
                                          const SizedBox(width: 1),
                                          Expanded(
                                            flex: 1,
                                            child: GestureDetector(
                                              onTap: () {
                                                mtController.editquestionController
                                                    .text = questiondata.question;
                                                editMockTestQuestions( context, questiondata);
                                              },
                                              child: Container(
                                                height: questiondata.imageID == null
                                                    ? 50 : 100,
                                                color: themeColorBlue.withOpacity(0.1),
                                                alignment: Alignment.center,
                                                child: const Icon(Icons.edit),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 1),
                                          Expanded(
                                            flex: 1,
                                            child: GestureDetector(
                                              onTap: () {
                                                customDeleteShowDialog(
                                                  context: context,
                                                  onTap: () async {
                                                    await mtController.deleteQuestion( questiondata.docid);
                                                  },
                                                );
                                              },
                                              child: Container(
                                                height: questiondata.imageID == null
                                                    ? 50 : 100,
                                                color: themeColorBlue.withOpacity(0.1),
                                                alignment: Alignment.center,
                                                child: const Icon(Icons.delete),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    isExpanded
                                            ? StreamBuilder(
                                            stream: server
                                                .collection( "DrivingSchoolCollection")
                                                .doc(UserCredentialsController.schoolId)
                                                .collection("MockTestCollection")
                                                .doc(questiondata.docid)
                                                .collection("Options")
                                                .snapshots(),
                                            builder: (context, optionSnap) {
                                              if (!optionSnap.hasData ||optionSnap.data == null) {
                                                return const CircularProgressIndicator();
                                              }
                                              return SizedBox(
                                                height: 220,
                                                width: ResponsiveWebSite.isDesktop( context)
                                                    ? double.infinity: 1200,
                                                child: ListView.separated(
                                                  itemBuilder: (context, optIndex) {
                                                    QuizTestAnswerModel optionDataModel =
                                                        QuizTestAnswerModel.fromMap( optionSnap.data!.docs[optIndex].data());
                                                   return Padding(
                                                      padding:  const EdgeInsets.all(5.0),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                              height: 38,
                                                              color: cWhite,
                                                              alignment: Alignment.center,
                                                              child: TextFontWidget(
                                                                text: String.fromCharCode( 65 + optIndex),
                                                                fontsize: 13,
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(width: 1),
                                                          Expanded(
                                                            flex: 15,
                                                            child: Container(
                                                              height: 38,
                                                              color: optionDataModel .isCorrect
                                                                  ? cgreen
                                                                  : cWhite,
                                                              alignment: Alignment.centerLeft,
                                                              child: TextFontWidget(
                                                                text: optionDataModel .options,
                                                                fontsize: 13,
                                                                color: optionDataModel .isCorrect
                                                                    ? cWhite
                                                                    : Colors.black,
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(width: 1),
                                                          Expanded(
                                                            flex: 2,
                                                            child: GestureDetector(
                                                              onTap: () {
                                                                mtController.editoptionController
                                                                    .text =  optionDataModel .options;
                                                                editMockTestOptions(
                                                                    context,
                                                                    questiondata,
                                                                    optionDataModel);
                                                              },
                                                              child: Container(
                                                                height: 38,
                                                                color: cWhite,
                                                                alignment:Alignment.center,
                                                                child: const Icon( Icons.edit),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                  itemCount: optionSnap .data?.docs.length ?? 0,
                                                  separatorBuilder: (context, index) =>
                                                      const SizedBox(height: 0),
                                                ),
                                              );
                                            })
                                        : const SizedBox.shrink(),
                                  ],
                                ),
                              ),
                            ),
                          );
                          },
                          );
                        },
                        itemCount: snapshot.data?.docs.length ?? 0,
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
