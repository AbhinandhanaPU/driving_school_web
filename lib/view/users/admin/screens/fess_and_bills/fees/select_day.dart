import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_project_driving/controller/admin_section/student_controller/student_controller.dart';
import 'package:new_project_driving/controller/fees_N_bills_Controller/feeStudent_controller.dart';
import 'package:new_project_driving/controller/fees_N_bills_Controller/fees_bills_controller.dart';

class SelectFeeMonthDateDropDown extends StatelessWidget {
  SelectFeeMonthDateDropDown({
    Key? key,
  }) : super(key: key);

  final feeCtrl = Get.put(FeesAndBillsController());
  final stdFeeCtrl = Get.put(StudentFeeController());
  final StudentController studentController = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    final data = studentController.studentModelData.value;
    return Center(
        child: DropdownSearch(
      validator: (item) {
        if (item == null) {
          return "Required field";
        } else {
          return null;
        }
      },

      // autoValidateMode: AutovalidateMode.always,
      asyncItems: (value) {
        feeCtrl.feeDateList.clear();

        return feeCtrl.fetchFeeDateData();
      },
      itemAsString: (value) => value,
      onChanged: (value) async {
        if (value != null) {
          feeCtrl.feeDateData.value = value;
          stdFeeCtrl.getStudentFeeDetails(data!.docid);
        }
      },
      popupProps: const PopupProps.menu(
          searchFieldProps: TextFieldProps(
              decoration: InputDecoration(
                  hintText: "Search Date", border: OutlineInputBorder())),
          showSearchBox: true,
          searchDelay: Duration(microseconds: 10)),
      dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: GoogleFonts.poppins(
              fontSize: 13, color: Colors.black.withOpacity(0.7))),
    ));
  }
}
