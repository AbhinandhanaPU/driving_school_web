import 'dart:developer';

import 'package:awesome_side_sheet/Enums/sheet_position.dart';
import 'package:awesome_side_sheet/side_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/constant/constant.validate.dart';
import 'package:new_project_driving/controller/fees_N_bills_Controller/fees_bills_controller.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/view/widget/blue_container_widget/blue_container_widget.dart';
import 'package:new_project_driving/view/widget/custom_showdialouge/custom_showdilog.dart';
import 'package:new_project_driving/view/widget/loading_widget/loading_widget.dart';
import 'package:new_project_driving/view/widget/progess_button/progress_button.dart';
import 'package:new_project_driving/view/widget/text_formfiled_container/textformfiled_blue_container.dart';

Future<void> createFeesFunction(BuildContext context) async {
  final FeesAndBillsController feesAndBillsController =
      Get.put(FeesAndBillsController());

  return aweSideSheet(
    context: context,
    sheetPosition: SheetPosition.right,
    backgroundColor: cWhite,
    footer: Container(),
    header: Container(),
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Row(
            children: [
              BackButton(),
              TextFontWidget(
                text: "Create Fees",
                fontsize: 21,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BlueContainerWidget(
                  title: "Add All Class",
                  fontSize: 12,
                  color: cBlack,
                  width: 100),
              const SizedBox(
                width: 10,
              ),
              Obx(() => feesAndBillsController.selectAllClass.value == false
                  ? Checkbox(
                      value: feesAndBillsController.selectAllClass.value,
                      onChanged: (value) {
                        feesAndBillsController.selectedClassList
                            .addAll(feesAndBillsController.allClassList);
                        feesAndBillsController.selectAllClass.value = true;
                        log("Select All: ${feesAndBillsController.selectedClassList}");
                      },
                    )
                  : Checkbox(
                      checkColor: cWhite,
                      activeColor: cBlue,
                      value: feesAndBillsController.selectAllClass.value,
                      onChanged: (value) {
                        feesAndBillsController.selectAllClass.value = false;
                        feesAndBillsController.selectedClassList.clear();
                        log("Deselect All: ${feesAndBillsController.selectedClassList}");
                      },
                    ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 20),
            child: SizedBox(
              height: 300,
              child: FutureBuilder(
                future: feesAndBillsController.fetchClass(),
                builder: (context, snapshot) {
                  log("Classes fetched...: ${snapshot.data}");
                        log("hyeeeeeeee${feesAndBillsController.selectedClassList.toString()}");
                  return snapshot.hasData
                      ? ListView.separated(
                          itemBuilder: (context, index) {
                            final data = snapshot.data![index];
                            return Obx(() => Container(
                                  color: feesAndBillsController
                                          .selectedClassList
                                          .where((element) => element.courseId
                                              .contains(feesAndBillsController
                                                  .allClassList[index].courseId))
                                          .isNotEmpty
                                      ? Colors.green.withOpacity(0.1)
                                      : Colors.blue.withOpacity(0.2),
                                  height: 35,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        TextFontWidget(
                                            text: data.courseName, fontsize: 12),
                                        const Spacer(),
                                        Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: cBlack
                                                        .withOpacity(0.1))),
                                            height: 30,
                                            child: feesAndBillsController
                                                    .selectedClassList
                                                    .where((element) =>
                                                        element.courseId.contains(
                                                            feesAndBillsController
                                                                .allClassList[
                                                                    index]
                                                                .courseId))
                                                    .isNotEmpty
                                                ? Checkbox(
                                                    checkColor: cWhite,
                                                    activeColor: cgreen,
                                                    value: true,
                                                    onChanged: (value) {
                                                      final indexx = feesAndBillsController
                                                          .selectedClassList
                                                          .indexWhere((element) =>
                                                              element.courseId ==
                                                              feesAndBillsController
                                                                  .allClassList[
                                                                      index]
                                                                  .courseId);

                                                      if (indexx != -1) {
                                                        //condition means hasdata in list
                                                        feesAndBillsController
                                                            .selectedClassList
                                                            .removeAt(indexx);
                                                      } else {
                                                        feesAndBillsController
                                                            .selectedClassList
                                                            .add(feesAndBillsController
                                                                    .allClassList[
                                                                index]);
                                                      }
                                                    },
                                                  )
                                                : GestureDetector(
                                                    onTap: () {
                                                      feesAndBillsController
                                                          .selectedClassList
                                                          .add(feesAndBillsController
                                                                  .allClassList[
                                                              index]);
                                                    },
                                                    child: const TextFontWidget(
                                                      text: 'Select',
                                                      fontsize: 12,
                                                      color: cBlack,
                                                    ),
                                                  ))
                                      ],
                                    ),
                                  ),
                                ));
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 05,
                            );
                          },
                          itemCount: snapshot.data!.length)
                      : const LoadingWidget();
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: GestureDetector(
              onTap: () => genrateFeesForClasses(context),
              child: BlueContainerWidget(
                  title: "Generate Class Fee",
                  fontSize: 12,
                  color: cBlack,
                  width: 200),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: GestureDetector(
              onTap: () => createCustomFeesForClasses(context),
              child: BlueContainerWidget(
                  title: "Create Custom Fee",
                  fontSize: 12,
                  color: cBlack,
                  width: 200),
            ),
          )
        ],
      ),
    ),
  );
}

genrateFeesForClasses(BuildContext context) async {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FeesAndBillsController feesAndBillsController =
      Get.find<FeesAndBillsController>();
  return customShowDilogBox2(
      context: context,
      title: "Create Fees",
      children: [
        const SizedBox(
          height: 10,
        ),
        Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                height: 71,
                child: TextFormFiledBlueContainerWidget(
                  color: Colors.transparent,
                  controller: feesAndBillsController.feestypeNameContoller,
                  hintText: " Enter Fee Type",
                  title: 'Fee Type',
                  validator: checkFieldEmpty,
                ),
              ),
              SizedBox(
                height: 71,
                child: TextFormFiledBlueContainerWidget(
                  color: Colors.transparent,
                  onTap: () => feesAndBillsController.selectMonth(context),
                  controller: feesAndBillsController.selectedFeeMonthContoller,
                  hintText: " 🗓️ Select Month",
                  title: 'Select Month',
                  keyboardType: TextInputType.number,
                  validator: checkFieldEmpty,
                ),
              ),
              SizedBox(
                height: 71,
                child: TextFormFiledBlueContainerWidget(
                  color: Colors.transparent,
                  onTap: () => feesAndBillsController.selectDate(context),
                  controller: feesAndBillsController.seletedFeeDateContoller,
                  hintText: " 🗓️ Select Date",
                  title: 'Select Date',
                  keyboardType: TextInputType.number,
                  validator: checkFieldEmpty,
                ),
              ),
              SizedBox(
                height: 71,
                child: TextFormFiledBlueContainerWidget(
                  color: Colors.transparent,
                  controller: feesAndBillsController.feesDueContoller,
                  hintText: " Enter Due Date in days eg 30,60..",
                  title: 'Due Date',
                  keyboardType: TextInputType.number,
                  validator: checkFieldEmpty,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                    height: 150,
                    width: 400,
                    child: Obx(
                      () => ListView.separated(
                          itemBuilder: (context, index) {
                            return Container(
                              color: Colors.green.withOpacity(0.1),
                              height: 35,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    TextFontWidget(
                                        text: feesAndBillsController
                                            .selectedClassList[index].courseName,
                                        fontsize: 12),
                                    const Spacer(),
                                    Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color:
                                                    cBlack.withOpacity(0.1))),
                                        height: 30,
                                        child: GestureDetector(
                                            onTap: () {
                                              feesAndBillsController
                                                  .selectedClassList
                                                  .removeAt(index);
                                            },
                                            child: const TextFontWidget(
                                                text: "Remove", fontsize: 12)))
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 05,
                            );
                          },
                          itemCount:
                              feesAndBillsController.selectedClassList.length),
                    )),
              ),
              Obx(() => ProgressButtonWidget(
                  buttonstate: feesAndBillsController.buttonstate.value,
                  text: 'Generate Fees',
                  function: () async {
                    if (formKey.currentState!.validate()) {
                      await feesAndBillsController.addFessAsignToClass();
                    }
                  }))
            ],
          ),
        )
      ],
      doyouwantActionButton: false);
}

createCustomFeesForClasses(BuildContext context) async {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FeesAndBillsController feesAndBillsController =
      Get.find<FeesAndBillsController>();
  return customShowDilogBox2(
      context: context,
      title: "Create Fees",
      children: [
        const SizedBox(
          height: 10,
        ),
        Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                height: 71,
                child: TextFormFiledBlueContainerWidget(
                  color: Colors.transparent,
                  controller: feesAndBillsController.feestypeNameContoller,
                  hintText: " Enter Fee Type",
                  title: 'Fee Type',
                  validator: checkFieldEmpty,
                ),
              ),
              SizedBox(
                height: 71,
                child: TextFormFiledBlueContainerWidget(
                  color: Colors.transparent,
                  controller: feesAndBillsController.feesContoller,
                  hintText: " Enter Fee Amount",
                  title: 'Fee Amount',
                  keyboardType: TextInputType.number,
                  validator: checkFieldEmpty,
                ),
              ),
              SizedBox(
                height: 71,
                child: TextFormFiledBlueContainerWidget(
                  color: Colors.transparent,
                  onTap: () => feesAndBillsController.selectMonth(context),
                  controller: feesAndBillsController.selectedFeeMonthContoller,
                  hintText: " 🗓️ Select Month",
                  title: 'Select Month',
                  keyboardType: TextInputType.number,
                  validator: checkFieldEmpty,
                ),
              ),
              SizedBox(
                height: 71,
                child: TextFormFiledBlueContainerWidget(
                  color: Colors.transparent,
                  onTap: () => feesAndBillsController.selectDate(context),
                  controller: feesAndBillsController.seletedFeeDateContoller,
                  hintText: " 🗓️ Select Date",
                  title: 'Select Date',
                  keyboardType: TextInputType.number,
                  validator: checkFieldEmpty,
                ),
              ),
              SizedBox(
                height: 71,
                child: TextFormFiledBlueContainerWidget(
                  color: Colors.transparent,
                  controller: feesAndBillsController.feesDueContoller,
                  hintText: " Enter Due Date in days eg 30,60..",
                  title: 'Due Date',
                  keyboardType: TextInputType.number,
                  validator: checkFieldEmpty,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                    height: 150,
                    width: 400,
                    child: Obx(
                      () => ListView.separated(
                          itemBuilder: (context, index) {
                            return Container(
                              color: Colors.green.withOpacity(0.1),
                              height: 35,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    TextFontWidget(
                                        text: feesAndBillsController
                                            .selectedClassList[index].courseName,
                                        fontsize: 12),
                                    const Spacer(),
                                    Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color:
                                                    cBlack.withOpacity(0.1))),
                                        height: 30,
                                        child: GestureDetector(
                                            onTap: () {
                                              feesAndBillsController
                                                  .selectedClassList
                                                  .removeAt(index);
                                            },
                                            child: const TextFontWidget(
                                                text: "Remove", fontsize: 12)))
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 05,
                            );
                          },
                          itemCount:
                              feesAndBillsController.selectedClassList.length),
                    )),
              ),
              Obx(() => ProgressButtonWidget(
                  buttonstate: feesAndBillsController.buttonstate.value,
                  text: 'Generate Fees',
                  function: () =>
                      feesAndBillsController.addCustomFessAsignToClass()))
            ],
          ),
        )
      ],
      doyouwantActionButton: false);
}
