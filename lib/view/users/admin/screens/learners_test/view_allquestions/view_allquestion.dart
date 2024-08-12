import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/controller/mocktest_controller/mocktest_Controller.dart';
import 'package:new_project_driving/controller/mocktest_controller/model/answerModel.dart';
import 'package:new_project_driving/controller/mocktest_controller/model/questionModel.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/utils/firebase/firebase.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';
import 'package:new_project_driving/view/users/admin/screens/learners_test/view_allquestions/edit_mock.dart';
import 'package:new_project_driving/view/widget/custom_delete_showdialog/custom_delete_showdialog.dart';
import 'package:new_project_driving/view/widget/responsive/responsive.dart';
import 'package:new_project_driving/view/widget/routeSelectedTextContainer/route_NonSelectedContainer.dart';

class ViewAllQuestionsUploaded extends StatelessWidget {
  ViewAllQuestionsUploaded({super.key});

  final MockTestController mtController = Get.put(MockTestController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 700,
        width: ResponsiveWebSite.isDesktop(context) ? double.infinity : 1200,
        color: screenContainerbackgroundColor,
        padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
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
                        padding: EdgeInsets.only(top: 05, left: 05),
                        child: RouteNonSelectedTextContainer(
                          title: 'Back',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 600,
              width:
                  ResponsiveWebSite.isDesktop(context) ? double.infinity : 1200,
              child: StreamBuilder(
                  stream: server
                      .collection("DrivingSchoolCollection")
                      .doc(UserCredentialsController.schoolId)
                      .collection("MockTestCollection")
                      .orderBy('questionNo', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        QuizTestQuestionModel questiondata =
                            QuizTestQuestionModel.fromMap(
                                snapshot.data!.docs[index].data());
                        //  final data = snapshot.data?.docs[index].data();
                        return Container(
                          height: 500,
                          width: ResponsiveWebSite.isDesktop(context)
                              ? double.infinity
                              : 1200,
                          color: const Color.fromARGB(255, 228, 229, 234),
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
                                        child:
                                            //    data?['imageID']
                                            questiondata.imageID == null
                                                ? Container(
                                                    height: 50,
                                                    color: Colors.blueGrey[100],
                                                    alignment: Alignment.center,
                                                    child: TextFontWidget(
                                                        text: "  ${index + 1}",
                                                        //data?['questionNo'] ?.toString() ??"",
                                                        fontsize: 13),
                                                  )
                                                : Container(
                                                    height: 100,
                                                    color: Colors.blueGrey[100],
                                                    alignment: Alignment.center,
                                                    child: TextFontWidget(
                                                      text: "  ${index + 1}",
                                                      //data?['questionNo']?.toString() ??  "",
                                                      fontsize: 13,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                      ),
                                      const SizedBox(
                                        width: 01,
                                      ),
                                      Expanded(
                                        flex: 15,
                                        child: questiondata.imageID
                                                // data?['imageID']
                                                ==
                                                null
                                            ? Container(
                                                height: 50,
                                                color: Colors.blueGrey[100],
                                                alignment: Alignment.centerLeft,
                                                child: TextFontWidget(
                                                  text: questiondata.question,
                                                  //data?['question'],
                                                  fontsize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            : Container(
                                                height: 100,
                                                color: Colors.blueGrey[100],
                                                child: Row(
                                                  children: [
                                                    Image.network(
                                                      questiondata.imageID ??
                                                          "",
                                                      // data?['imageID'],
                                                      height: 100,
                                                      errorBuilder: (context,
                                                          error, stackTrace) {
                                                        return const Icon(
                                                            Icons.error);
                                                      },
                                                    ),
                                                    TextFontWidget(
                                                      text:
                                                          questiondata.question,
                                                      //data?['question'],
                                                      fontsize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                      ),
                                      const SizedBox(
                                        width: 01,
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: GestureDetector(
                                          onTap: () {
                                            mtController.editquestionController
                                                .text = questiondata.question;
                                            editMockTestQuestions(
                                                context, questiondata);
                                          },
                                          child: questiondata.imageID == null
                                              ? Container(
                                                  height: 50,
                                                  color: Colors.blueGrey[100],
                                                  alignment: Alignment.center,
                                                  child: const Icon(Icons.edit),
                                                )
                                              : Container(
                                                  height: 100,
                                                  color: Colors.blueGrey[100],
                                                  alignment: Alignment.center,
                                                  child: const Icon(Icons.edit),
                                                ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 01,
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: GestureDetector(
                                          onTap: () {
                                            customDeleteShowDialog(
                                              context: context,
                                              onTap: () async {
                                                await mtController
                                                    .deleteQuestion(
                                                        questiondata.docid);
                                              },
                                            );
                                            //   mtController.deleteQuestion(questiondata.docid);
                                          },
                                          child: questiondata.imageID == null
                                              ? Container(
                                                  height: 50,
                                                  color: Colors.blueGrey[100],
                                                  alignment: Alignment.center,
                                                  child:
                                                      const Icon(Icons.delete),
                                                )
                                              : Container(
                                                  height: 100,
                                                  color: Colors.blueGrey[100],
                                                  alignment: Alignment.center,
                                                  child:
                                                      const Icon(Icons.delete),
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                StreamBuilder(
                                    stream: server
                                        .collection("DrivingSchoolCollection")
                                        .doc(UserCredentialsController.schoolId)
                                        .collection("MockTestCollection")
                                        .doc(questiondata.docid)
                                        .collection("Options")
                                        .snapshots(),
                                    builder: (context, optionSnap) {
                                      if (!optionSnap.hasData) {
                                        return const CircularProgressIndicator();
                                      }
                                      return SizedBox(
                                        height: 280,
                                        width:
                                            ResponsiveWebSite.isDesktop(context)
                                                ? double.infinity
                                                : 1200,
                                        child: ListView.separated(
                                          itemBuilder: (context, optIndex) {
                                            QuizTestAnswerModel
                                                optionDataModel =
                                                QuizTestAnswerModel.fromMap(
                                                    optionSnap
                                                        .data!.docs[optIndex]
                                                        .data());
                                            // final option = optionSnap
                                            //     .data?.docs[optIndex]
                                            //     .data();
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      height: 50,
                                                      color: cWhite,
                                                      alignment:
                                                          Alignment.center,
                                                      child: TextFontWidget(
                                                          text: String
                                                              .fromCharCode(65 +
                                                                  optIndex),
                                                          fontsize: 13),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 01,
                                                  ),
                                                  Expanded(
                                                    flex: 15,
                                                    child: optionDataModel
                                                                .isCorrect
                                                            // option?['isCorrect']
                                                            ==
                                                            false
                                                        ? Container(
                                                            height: 50,
                                                            color: cWhite,
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child:
                                                                TextFontWidget(
                                                                    text: optionDataModel
                                                                        .options,
                                                                    // option?[ 'options'],
                                                                    fontsize:
                                                                        13),
                                                          )
                                                        : Container(
                                                            height: 50,
                                                            color: cgreen,
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child:
                                                                TextFontWidget(
                                                              text:
                                                                  optionDataModel
                                                                      .options,
                                                              //option?['options'],
                                                              fontsize: 13,
                                                              color: cWhite,
                                                            ),
                                                          ),
                                                  ),
                                                  const SizedBox(
                                                    width: 01,
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        mtController
                                                                .editoptionController
                                                                .text =
                                                            optionDataModel
                                                                .options;
                                                        editMockTestOptions(
                                                            context,
                                                            questiondata,
                                                            optionDataModel);
                                                      },
                                                      child: Container(
                                                        height: 50,
                                                        color: cWhite,
                                                        alignment:
                                                            Alignment.center,
                                                        child: const Icon(
                                                            Icons.edit),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          itemCount:
                                              optionSnap.data?.docs.length ?? 0,
                                          separatorBuilder: (context, index) =>
                                              const SizedBox(
                                            height: 5,
                                          ),
                                          //  child:
                                        ),
                                      );
                                    }),
                                // Padding(
                                //   padding: const EdgeInsets.all(8.0),
                                //   child: Row(
                                //     children: [
                                //       Expanded(
                                //         flex: 1,
                                //         child: Container(
                                //           height: 50,
                                //           color: cWhite,
                                //           alignment: Alignment.center,
                                //           child: const TextFontWidget(
                                //               text: "B", fontsize: 13),
                                //         ),
                                //       ),
                                //       const SizedBox(
                                //         width: 01,
                                //       ),
                                //       Expanded(
                                //         flex: 15,
                                //         child: Container(
                                //           height: 50,
                                //           color: cWhite,
                                //           alignment: Alignment.centerLeft,
                                //           child: TextFontWidget(
                                //               text: option.options,
                                //               fontsize: 13),
                                //         ),
                                //       ),
                                //       const SizedBox(
                                //         width: 01,
                                //       ),
                                //       Expanded(
                                //         flex: 2,
                                //         child: Container(
                                //           height: 50,
                                //           color: cWhite,
                                //           alignment: Alignment.center,
                                //           child: const Icon(Icons.edit),
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                // Padding(
                                //   padding: const EdgeInsets.all(8.0),
                                //   child: Row(
                                //     children: [
                                //       Expanded(
                                //         flex: 1,
                                //         child: Container(
                                //           height: 50,
                                //           color: cWhite,
                                //           alignment: Alignment.center,
                                //           child: const TextFontWidget(
                                //               text: "C", fontsize: 13),
                                //         ),
                                //       ),
                                //       const SizedBox(
                                //         width: 01,
                                //       ),
                                //       Expanded(
                                //         flex: 15,
                                //         child: Container(
                                //           height: 50,
                                //           color: cWhite,
                                //           alignment: Alignment.centerLeft,
                                //           child: TextFontWidget(
                                //               text: option.options,
                                //               fontsize: 13),
                                //         ),
                                //       ),
                                //       const SizedBox(
                                //         width: 01,
                                //       ),
                                //       Expanded(
                                //         flex: 2,
                                //         child: Container(
                                //           height: 50,
                                //           color: cWhite,
                                //           alignment: Alignment.center,
                                //           child: const Icon(Icons.edit),
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                // Padding(
                                //   padding: const EdgeInsets.all(8.0),
                                //   child: Row(
                                //     children: [
                                //       Expanded(
                                //         flex: 1,
                                //         child: Container(
                                //           height: 50,
                                //           color: cWhite,
                                //           alignment: Alignment.center,
                                //           child: const TextFontWidget(
                                //               text: "D", fontsize: 13),
                                //         ),
                                //       ),
                                //       const SizedBox(
                                //         width: 01,
                                //       ),
                                //       Expanded(
                                //         flex: 15,
                                //         child: Container(
                                //           height: 50,
                                //           color: cWhite,
                                //           alignment: Alignment.centerLeft,
                                //           child: TextFontWidget(
                                //               text: option.options,
                                //               fontsize: 13),
                                //         ),
                                //       ),
                                //       const SizedBox(
                                //         width: 01,
                                //       ),
                                //       Expanded(
                                //         flex: 2,
                                //         child: Container(
                                //           height: 50,
                                //           color: cWhite,
                                //           alignment: Alignment.center,
                                //           child: const Icon(Icons.edit),
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                              ],
                            ),
                          ),
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
    );
  }
}
