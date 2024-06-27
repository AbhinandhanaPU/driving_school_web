import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/constant/const.dart';
import 'package:new_project_driving/constant/constant.validate.dart';
import 'package:new_project_driving/controller/admin_section/admin_controller/admin_controller.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';
import 'package:new_project_driving/view/widget/progess_button/progress_button.dart';
import 'package:new_project_driving/view/widget/responsive/responsive.dart';
import 'package:new_project_driving/view/widget/routeSelectedTextContainer/routeSelectedTextContainer.dart';
import 'package:new_project_driving/view/widget/routeSelectedTextContainer/route_NonSelectedContainer.dart';

class CreateAdmin extends StatelessWidget {
  final AdminController adminController = Get.put(AdminController());
  CreateAdmin({super.key});
  // final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final adminListWidgets = [
      Text(
        "Create A New Admin",
        style: TextStyle(
            fontSize: ResponsiveWebSite.isMobile(context) ? 15 : 17,
            fontWeight: FontWeight.bold),
      ), //////////////////////..............0
      SizedBox(
        width: ResponsiveWebSite.isMobile(context) ? 80 : 150,
        child: Text(
          "Admin Name",
          style: TextStyle(
              fontSize: ResponsiveWebSite.isMobile(context) ? 13 : 15,
              fontWeight: FontWeight.bold),
        ),
      ), ////////////////////..................1
      SizedBox(
        height: 50,
        width: ResponsiveWebSite.isMobile(context) ? 80 : 150,
        child: TextFormField(
          controller: adminController.nameController,
          validator: checkFieldEmpty,
          style: const TextStyle(fontSize: 14),
          decoration: const InputDecoration(
            // fillColor: Colors.white,
            border: OutlineInputBorder(),
            hintText: 'Enter Name',
            prefixIcon: Icon(
              Icons.person,
              size: 20,
            ),
            contentPadding: EdgeInsets.only(top: 5, bottom: 5),
          ),
        ),
      ), //////////////////////................2
      SizedBox(
        width: ResponsiveWebSite.isMobile(context) ? 80 : 150,
        child: Text(
          "Admin Email",
          style: TextStyle(
              fontSize: ResponsiveWebSite.isMobile(context) ? 13 : 15,
              fontWeight: FontWeight.bold),
        ),
      ), //////////////////////..............3
      Container(
        height: 50,
        color: screenContainerbackgroundColor,
        child: TextFormField(
          controller: adminController.emailController,
          validator: checkFieldEmailIsValid,
          style: const TextStyle(fontSize: 14),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter Email ID',
            prefixIcon: Icon(
              Icons.email,
              size: 20,
            ),
            contentPadding: EdgeInsets.only(top: 1, bottom: 1),
          ),
        ),
      ), //////////////////////////////............4
      SizedBox(
        width: ResponsiveWebSite.isMobile(context) ? 80 : 150,
        child: Text(
          "Phone Number",
          style: TextStyle(
              fontSize: ResponsiveWebSite.isMobile(context) ? 13 : 15,
              fontWeight: FontWeight.bold),
        ),
      ), /////////////////////////////....................5
      Container(
        height: 50,
        color: screenContainerbackgroundColor,
        child: TextFormField(
          controller: adminController.phoneNumberController,
          validator: checkFieldPhoneNumberIsValid,
          keyboardType: TextInputType.number,
          style: const TextStyle(fontSize: 14),
          decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.phone_android,
                size: 20,
              ),
              border: OutlineInputBorder(),
              hintText: 'Enter Phone Number',
              contentPadding: EdgeInsets.only(top: 5, bottom: 5),
              prefixText: "+91"),
        ),
      ), //////////////////////.............................6
      SizedBox(
        width: ResponsiveWebSite.isMobile(context) ? 80 : 150,
        child: Text(
          "Admin Password",
          style: TextStyle(
              fontSize: ResponsiveWebSite.isMobile(context) ? 13 : 15,
              fontWeight: FontWeight.bold),
        ),
      ), ////////////////////////////........................7
      Container(
        height: 50,
        color: screenContainerbackgroundColor,
        child: TextFormField(
          controller: adminController.passwordController,
          validator: checkFieldPasswordIsValid,
          style: const TextStyle(fontSize: 14),
          decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.lock,
              size: 20,
            ),
            border: OutlineInputBorder(),
            hintText: 'Enter Password',
            contentPadding: EdgeInsets.only(top: 5, bottom: 5),
          ),
        ),
      ), ////////////////////////.....................8
      SizedBox(
        width: ResponsiveWebSite.isMobile(context) ? 80 : 150,
        child: Text(
          "Confirm Password",
          style: TextStyle(
              fontSize: ResponsiveWebSite.isMobile(context) ? 13 : 15,
              fontWeight: FontWeight.bold),
        ),
      ), ///////////////////////.....................9
      Container(
        height: 50,
        color: screenContainerbackgroundColor,
        child: TextFormField(
          validator: checkFieldPasswordIsValid,
          controller: adminController.passwordController,
          style: const TextStyle(fontSize: 14),
          decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.lock,
              size: 20,
            ),
            border: OutlineInputBorder(),
            hintText: 'Confirm Password',
            contentPadding: EdgeInsets.only(top: 5, bottom: 5),
          ),
        ),
      ), ///////////////////......................10
      Obx(
        () => ProgressButtonWidget(
            function: () async {
              final currentUser = UserCredentialsController.currentUserDocid;

              if (UserCredentialsController.schoolId == currentUser) {
                if (adminController.formKey.currentState!.validate()) {
                  adminController.createNewAdmin(context);
                }
              } else {
                showToast(msg: "You are not a SuperAdmin");
              }
            },
            buttonstate: adminController.buttonstate.value,
            text: 'Create Admin'),
      ), ///////////////////......................11
    ];
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 80,
            color: screenContainerbackgroundColor,
            child: Padding(
              padding: const EdgeInsets.only(top: 30, left: 25),
              child: adminListWidgets[0],
              ///////////////////....................Create New Admin
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Container(
              height: 30,
              width: double.infinity,
              color: screenContainerbackgroundColor,
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        adminController.ontapCreateAdmin.value = false;
                      },
                      child: const RouteNonSelectedTextContainer(title: 'Home'),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const RouteSelectedTextContainer(
                      width: 140,
                      title: 'Create Admin',
                    ),
                  ],
                ),
              ),
            ),
          ),
          ResponsiveWebSite.isMobile(context)
              ? Container(
                  color: cWhite,
                  child: Form(
                    key: adminController.formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 5, right: 5, top: 20),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, bottom: 20, left: 20, right: 10),
                                child: adminListWidgets[1],
                                /////////////////.....................admin name
                              ),
                              Expanded(
                                child: Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: adminListWidgets[2]
                                    ///////////////////...............enter name
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: Row(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 20, left: 20, right: 10),
                                  child: adminListWidgets[3]
                                  ////////////////admin email
                                  ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: adminListWidgets[4],
                                  //////////////////////.................enter email ID
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, bottom: 20, left: 20, right: 10),
                                child: adminListWidgets[5],
                                /////////////////////....................Phone Number
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: adminListWidgets[6],
                                  /////////////////////////..................Enter Phone number
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, bottom: 20, left: 20, right: 10),
                                child: adminListWidgets[7],
                                ////////////////////////.....................Admin Password
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: adminListWidgets[8],
                                  ///////////////////////.................Enter Password
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, bottom: 20, left: 20, right: 10),
                                child: adminListWidgets[9],
                                ///////////////...............confirm password
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: adminListWidgets[10],
                                  ///////////////////////.................Enter Confirm Password
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 25, bottom: 15, top: 15),
                          child: adminListWidgets[11],
                          ///////////////////////.................submit button
                        ),
                      ],
                    ),
                  ),
                ) /////////////////////////////////////////////////////////////////////////////////////////..............mobile view
              : Container(
                  height: 700,
                  color: cWhite,
                  child: Form(
                    key: adminController.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, bottom: 20, left: 30, right: 30),
                                child: adminListWidgets[1],
                                //////////////////////////..............admin name
                              ),
                              Expanded(
                                flex: 1,
                                child: adminListWidgets[2],
                                ///////////////////////////////...enter name
                              ),
                              Expanded(flex: 1, child: Container())
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, bottom: 20, left: 30, right: 30),
                                child: adminListWidgets[3],
                                ////////////////admin email
                              ),
                              Expanded(
                                flex: 1,
                                child: adminListWidgets[4],
                                //////////////////////.................enter email ID
                              ),
                              Expanded(flex: 1, child: Container())
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, bottom: 20, left: 30, right: 30),
                                child: adminListWidgets[5],
                                //////////////////................Phone Number
                              ),
                              Expanded(
                                flex: 1,
                                child: adminListWidgets[6],
                                ////////////////////............Enter PHone Number
                              ),
                              Expanded(flex: 1, child: Container())
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, bottom: 20, left: 30, right: 30),
                                child: adminListWidgets[7],
                                ////////////////////..................Admin Password
                              ),
                              Expanded(
                                flex: 1,
                                child: adminListWidgets[8],
                                ///////////////////////..................Enter password
                              ),
                              Expanded(flex: 1, child: Container())
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 20, left: 30, right: 30),
                                  child: adminListWidgets[9],
                                  ///////////////.............Confirm Password
                                ),
                                Expanded(
                                  flex: 1,
                                  child: adminListWidgets[10],
                                  /////////////////////....................Enter Confirm Password
                                ),
                                Expanded(flex: 1, child: Container())
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 40, bottom: 25, top: 25),
                          child: adminListWidgets[11],
                          ///////////////////////....................submit button
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ), //////////////////////////////////////////////...................web view
    );
  }
}
