import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/constant/constant.validate.dart';
import 'package:new_project_driving/controller/admin_section/admin_controller/adminprofile_edit_controller.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';
import 'package:new_project_driving/view/widget/custom_showdialouge/custom_showdialouge.dart';
import 'package:new_project_driving/view/widget/text_formfiled_container/textformfiled_blue_container.dart';

editFunctionOfAdminProfile(BuildContext context) {
  final adminProfileEditController = Get.put(AdminProfileEditController());

  customShowDilogBox(
      context: context,
      title: 'Edit',
      children: [
        Form(
          key: adminProfileEditController.formKey,
          child: Column(
            children: [
              TextFormFiledHeightnoColor(
                  validator: checkFieldEmpty,
                  controller: adminProfileEditController.adminNameController,
                  hintText: UserCredentialsController.adminModel!.adminName,
                  title: 'admin name'),
              TextFormFiledHeightnoColor(
                  validator: checkFieldEmpty,
                  controller: adminProfileEditController.designationController,
                  hintText: UserCredentialsController.adminModel!.designation,
                  title: 'designation'),
              TextFormFiledHeightnoColor(
                  validator: checkFieldEmpty,
                  controller: adminProfileEditController.addressController,
                  hintText: UserCredentialsController.adminModel!.address,
                  title: 'address'),
              TextFormFiledHeightnoColor(
                  validator: checkFieldEmpty,
                  controller: adminProfileEditController.placeController,
                  hintText: UserCredentialsController.adminModel!.place,
                  title: 'place'),
              TextFormFiledHeightnoColor(
                  validator: checkFieldEmpty,
                  controller: adminProfileEditController.phoneNumberController,
                  hintText: UserCredentialsController.adminModel!.phoneNumber,
                  title: 'Phone Number'),
              TextFormFiledHeightnoColor(
                  validator: checkFieldEmpty,
                  controller: adminProfileEditController.schoolNameController,
                  hintText: UserCredentialsController.adminModel!.schoolName,
                  title: 'school name'),
              TextFormFiledHeightnoColor(
                  validator: checkFieldEmpty,
                  controller: adminProfileEditController.lisenceNumberController,
                  hintText: UserCredentialsController.adminModel!.schoolLicenceNumber,
                  title: 'Licence Number'),
              TextFormFiledHeightnoColor(
                  validator: checkFieldEmpty,
                  controller: adminProfileEditController.schoolCodeController,
                  hintText: UserCredentialsController.adminModel!.schoolCode,
                  title: 'schoolCode'),
              TextFormFiledHeightnoColor(
                  validator: checkFieldEmpty,
                  controller: adminProfileEditController.cityController,
                  hintText: UserCredentialsController.adminModel!.city,
                  title: 'city'),
              TextFormFiledHeightnoColor(
                  validator: checkFieldEmpty,
                  controller: adminProfileEditController.stateController,
                  hintText: UserCredentialsController.adminModel!.state,
                  title: 'state'),
              TextFormFiledHeightnoColor(
                  validator: checkFieldEmpty,
                  controller: adminProfileEditController.countryController,
                  hintText: UserCredentialsController.adminModel!.country,
                  title: 'country'),
            ],
          ),
        ),
      ],
      doyouwantActionButton: true,
      actiononTapfuction: () {
        if (adminProfileEditController.formKey.currentState!.validate()) {
          adminProfileEditController.updateAdminProfile(
            context,
          );
        }
      },
      actiontext: 'Update');
}
