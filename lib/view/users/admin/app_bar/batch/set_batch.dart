// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:new_project_driving/colors/colors.dart';
// import 'package:new_project_driving/controller/batch_controller/batch_controller.dart';
// import 'package:new_project_driving/fonts/text_widget.dart';
// import 'package:new_project_driving/view/users/admin/app_bar/batch/create_batch.dart';
// import 'package:new_project_driving/view/users/admin/screens/batch/drop_down/batch_dp_dn.dart';
// import 'package:new_project_driving/view/widget/responsive/responsive.dart';

// bacthSettingFunction(BuildContext context) {
//   final BatchController batchController = Get.put(BatchController());
//   final academicYearListWidegt = [
//     GestureDetector(
//       onTap: () {
//         createBatchFunction(context);
//       },
//       child: Container(
//         height: 40,
//         width: 150,
//         decoration: BoxDecoration(
//             color: themeColorBlue,
//             border: Border.all(color: themeColorBlue),
//             borderRadius: BorderRadius.circular(05)),
//         child: const Center(
//           child: TextFontWidgetRouter(
//             text: "Create Batch",
//             fontsize: 14,
//             color: cWhite,
//           ),
//         ),
//       ),
//     ), ///////////////////////.......0
//     GestureDetector(
//       onTap: () {
//         if (batchController.formKey.currentState!.validate()) {
//           batchController.onBatchWiseView.value = true;
//           Navigator.of(context).pop();
//         }
//       },
//       child: Container(
//         height: 40,
//         width: 150,
//         decoration: BoxDecoration(
//             color: themeColorBlue,
//             border: Border.all(color: themeColorBlue),
//             borderRadius: BorderRadius.circular(05)),
//         child: const Center(
//           child: TextFontWidgetRouter(
//             text: "Set Batch",
//             fontsize: 14,
//             color: cWhite,
//           ),
//         ),
//       ),
//     ), ////////////////...............1
//     GestureDetector(
//       onTap: () {
//         batchController.onBatchWiseView.value = false;
//         Navigator.of(context).pop();
//       },
//       child: Container(
//         height: 40,
//         width: 150,
//         decoration: BoxDecoration(
//             color: themeColorBlue,
//             border: Border.all(color: themeColorBlue),
//             borderRadius: BorderRadius.circular(05)),
//         child: const Center(
//           child: TextFontWidgetRouter(
//             text: "Clear Batch",
//             fontsize: 14, // fontWeight: FontWeight.w600,
//             color: cWhite,
//           ),
//         ),
//       ),
//     ), //////////////////.............2
//   ];
//   showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         title: const TextFontWidget(text: "Batch", fontsize: 15),
//         backgroundColor: cWhite,
//         content: SizedBox(
//           height: ResponsiveWebSite.isMobile(context) ? 240 : 170,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Form(
//                 key: batchController.formKey,
//                 child: SizedBox(
//                   height: 95,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const TextFontWidget(
//                           text: 'Select Batch*', fontsize: 12.5),
//                       const SizedBox(
//                         height: 05,
//                       ),
//                       BatchDropDown(
//                         onChanged: (batch) {
//                           batchController.batchView.value = batch!.batchId;
//                           log(batchController.batchView.value);
//                         },
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               ResponsiveWebSite.isMobile(context)
//                   ? Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(4.0),
//                           child: academicYearListWidegt[0],
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(4.0),
//                           child: academicYearListWidegt[1],
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(4.0),
//                           child: academicYearListWidegt[2],
//                         ),
//                       ],
//                     )
//                   : Row(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: academicYearListWidegt[0],
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: academicYearListWidegt[1],
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: academicYearListWidegt[2],
//                         ),
//                       ],
//                     ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }
