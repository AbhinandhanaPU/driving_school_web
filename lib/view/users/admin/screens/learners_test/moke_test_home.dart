import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/controller/mocktest_controller/mocktest_controller.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/view/users/admin/screens/learners_test/choicerow_widget.dart';
import 'package:new_project_driving/view/users/admin/screens/learners_test/view_allquestions/view_allquestion.dart';
import 'package:new_project_driving/view/widget/blue_container_widget/blue_container_widget.dart';
import 'package:new_project_driving/view/widget/responsive/responsive.dart';

class MockTesttHome extends StatefulWidget {
  const MockTesttHome({super.key});

  @override
  State<MockTesttHome> createState() => _MockTesttHomeState();
}

class _MockTesttHomeState extends State<MockTesttHome> {
  final MockTestController mtController = Get.put(MockTestController());

  bool isActive = false;
  Uint8List? file;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => mtController.ontapViewAllQuestions.value == true
          ? ViewAllQuestionsUploaded()
          : SingleChildScrollView(
              scrollDirection: ResponsiveWebSite.isMobile(context)
                  ? Axis.horizontal
                  : Axis.vertical,
              child: Container(
                color: screenContainerbackgroundColor,
                height: 800,
                width: ResponsiveWebSite.isDesktop(context)
                    ? double.infinity
                    : 1200,
                padding: const EdgeInsets.only(
                  left: 08,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding:
                          const EdgeInsets.only(top: 20, right: 50, left: 50),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const TextFontWidget(
                                text: "Question",
                                fontsize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  mtController.ontapViewAllQuestions.value =
                                      true;
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: BlueContainerWidget(
                                      title: "View All Questions",
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.bold,
                                      color: themeColorBlue),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 150,
                            margin: const EdgeInsets.only(top: 20),
                            padding: const EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey.withOpacity(0.2),
                            ),
                            child: TextFormField(
                              controller: mtController.questionController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Lets ask your question',
                              ),
                              maxLines:
                                  null, // This allows the text field to expand vertically
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Row(
                              children: [
                                Transform.scale(
                                  scale: 0.65,
                                  child: Switch(
                                    activeColor: Colors.green,
                                    value: isActive,
                                    onChanged: (value) {
                                      setState(() {
                                        isActive =
                                            value; // Update the state when the switch is toggled
                                      });
                                    },
                                  ),
                                ),
                                const Text(
                                  'Single answer with image',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                if (isActive) // Conditionally display the container
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: GestureDetector(
                                      onTap: () async {
                                        FilePickerResult? result =
                                            await FilePicker.platform.pickFiles(
                                          type: FileType.image,
                                        );
                                        if (result != null) {
                                          file = result.files.first.bytes;
                                          mtController.imagePath =
                                              result.files.first.bytes;
                                        }
                                      },
                                      child: BlueContainerWidget(
                                        title: "Add Image",
                                        fontSize: 12.5,
                                        color: themeColorBlue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 05),
                            child: Text(
                              'Write down the Options',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, right: 10, bottom: 10),
                            child: Row(
                              children: [
                                ChoiceRowWidget(
                                  controller: mtController.optionAController,
                                  label: 'A',
                                  hintText: 'Lets ask your qn',
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                  letterSpacing: 0.5,
                                  iconColor: Colors.black,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: ChoiceRowWidget(
                                    controller: mtController.optionBController,
                                    label: 'B',
                                    hintText: 'Lets ask your qn',
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    letterSpacing: 0.5,
                                    iconColor: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Row(
                              children: [
                                ChoiceRowWidget(
                                  controller: mtController.optionCController,
                                  label: 'C',
                                  hintText: 'Lets ask your qn',
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                  letterSpacing: 0.5,
                                  iconColor: Colors.black,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: ChoiceRowWidget(
                                    controller: mtController.optionDController,
                                    label: 'D',
                                    hintText: 'Lets ask your qn',
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    letterSpacing: 0.5,
                                    iconColor: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(
                              top: 10,
                            ),
                            child: TextFontWidget(
                              text: "Select Correct Answer",
                              fontsize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Obx(() => Row(
                                children: [
                                  SizedBox(
                                    height: 100,
                                    width: 250,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            mtController.correctAns.value =
                                                mtController
                                                    .optionAController.text;

                                            mtController.optionA.value = true;
                                            mtController.optionB.value = false;
                                            mtController.optionC.value = false;
                                            mtController.optionD.value = false;
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              color:
                                                  mtController.optionA.value ==
                                                          true
                                                      ? cgreen
                                                      : cWhite,
                                              border: Border.all(color: cBlack),
                                            ),
                                            child: Center(
                                                child: TextFontWidget(
                                              text: 'A',
                                              fontsize: 12,
                                              color:
                                                  mtController.optionA.value ==
                                                          true
                                                      ? cWhite
                                                      : cBlack,
                                              fontWeight: FontWeight.bold,
                                            )),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            mtController.correctAns.value =
                                                mtController
                                                    .optionBController.text;
                                            mtController.optionA.value = false;
                                            mtController.optionB.value = true;
                                            mtController.optionC.value = false;
                                            mtController.optionD.value = false;
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              color:
                                                  mtController.optionB.value ==
                                                          true
                                                      ? cgreen
                                                      : cWhite,
                                              border: Border.all(color: cBlack),
                                            ),
                                            child: Center(
                                                child: TextFontWidget(
                                              text: 'B',
                                              color:
                                                  mtController.optionB.value ==
                                                          true
                                                      ? cWhite
                                                      : cBlack,
                                              fontsize: 12,
                                              fontWeight: FontWeight.bold,
                                            )),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            mtController.correctAns.value =
                                                mtController
                                                    .optionCController.text;
                                            mtController.optionA.value = false;
                                            mtController.optionB.value = false;
                                            mtController.optionC.value = true;
                                            mtController.optionD.value = false;
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              color:
                                                  mtController.optionC.value ==
                                                          true
                                                      ? cgreen
                                                      : cWhite,
                                              border: Border.all(color: cBlack),
                                            ),
                                            child: Center(
                                                child: TextFontWidget(
                                              text: 'C',
                                              fontsize: 12,
                                              color:
                                                  mtController.optionC.value ==
                                                          true
                                                      ? cWhite
                                                      : cBlack,
                                              fontWeight: FontWeight.bold,
                                            )),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            mtController.correctAns.value =
                                                mtController
                                                    .optionDController.text;
                                            mtController.optionA.value = false;
                                            mtController.optionB.value = false;
                                            mtController.optionC.value = false;
                                            mtController.optionD.value = true;
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              color:
                                                  mtController.optionD.value ==
                                                          true
                                                      ? cgreen
                                                      : cWhite,
                                              border: Border.all(color: cBlack),
                                            ),
                                            child: Center(
                                                child: TextFontWidget(
                                              text: 'D',
                                              fontsize: 12,
                                              color:
                                                  mtController.optionD.value ==
                                                          true
                                                      ? cWhite
                                                      : cBlack,
                                              fontWeight: FontWeight.bold,
                                            )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: GestureDetector(
                                      onTap: () async {
                                        mtController.uploadQuestionImage();
                                      },
                                      child: BlueContainerWidget(
                                        title: "Upload Question",
                                        fontSize: 12.5,
                                        color: themeColorBlue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                ],
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
