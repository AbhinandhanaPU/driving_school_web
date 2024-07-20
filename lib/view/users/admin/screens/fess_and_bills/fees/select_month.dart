import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_project_driving/controller/fees_N_bills_Controller/fees_bills_controller.dart';

class SelectFeeMonthDropDown extends StatelessWidget {
  SelectFeeMonthDropDown({
    Key? key,
  }) : super(key: key);

  final feeCtrl = Get.put(FeesAndBillsController());

  @override
  Widget build(BuildContext context) {
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
        feeCtrl.feeMonthList.clear();

        return feeCtrl.fetchFeeMonthData();
      },
      itemAsString: (value) => value,
      onChanged: (value) async {
        if (value != null) {
          feeCtrl.feeMonthData.value = value;
        }
      },
      popupProps: const PopupProps.menu(
          searchFieldProps: TextFieldProps(
              decoration: InputDecoration(
                  hintText: "Search Month", border: OutlineInputBorder())),
          showSearchBox: true,
          searchDelay: Duration(microseconds: 10)),
      dropdownDecoratorProps: DropDownDecoratorProps(
        // dropdownSearchDecoration: InputDecoration(
        //   hintText: 'Select Month', ),
          baseStyle: GoogleFonts.poppins(
              fontSize: 13, color: Colors.black.withOpacity(0.7))),
    ));
  }
}
