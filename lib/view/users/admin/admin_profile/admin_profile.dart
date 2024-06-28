import 'dart:developer';

import 'package:awesome_side_sheet/Enums/sheet_position.dart';
import 'package:awesome_side_sheet/side_sheet.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/controller/user_login_Controller/user_login_controller.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';
import 'package:new_project_driving/view/widget/blue_container_widget/blue_container_widget.dart';
import 'package:new_project_driving/view/widget/responsive/responsive.dart';
import 'package:new_project_driving/view/widget/text_formfiled_container/textformfiled_blue_container.dart';

@override
adminProfileshowlist(BuildContext context) {
  // Rxn<Uint8List> image = Rxn();
  // final profileCtr = Get.put(AdminProfileController());

  aweSideSheet(
    context: context,
    sheetPosition: SheetPosition.right,
    backgroundColor: cWhite,
    header: Container(),
    showActions: false,
    footer: Container(),
    body: SingleChildScrollView(
      child: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const BackButton(),
              const TextFontWidget(
                text: "Profile",
                fontsize: 17,
                fontWeight: FontWeight.bold,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                    onPressed: () async {
                      if (kDebugMode) {
                        print("logoutUser");
                      }
                      await Get.find<UserLoginController>()
                          .logoutSaveData()
                          .then((value) => logoutUser());
                      logoutUser();
                    },
                    icon: const Icon(Icons.power_settings_new_sharp)),
              )
            ],
          ),
          // Obx(
          //   () =>
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child:
                //  profileCtr.onTapEdit.value == true
                // ? GestureDetector(
                //     onTap: () {
                //       // profileCtr.onTapEdit.value = false;
                //     },
                //     child: BlueContainerWidget(
                //         title: "Cancel",
                //         fontSize: ResponsiveWebSite.isMobile(context)
                //             ? 14
                //             : 16,
                //         color: cBlue,
                //         width: 80),
                //   )
                // :
                GestureDetector(
              onTap: () {
                // profileCtr.onTapEdit.value = true;
                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                //   return AdminProfileEdit();
                // },));
              },
              child: BlueContainerWidget(
                  title: "Edit",
                  fontSize: ResponsiveWebSite.isMobile(context) ? 14 : 16,
                  color: cBlue,
                  width: 80),
            ),
          ),
          // ),
          // Obx(
          //   () => profileCtr.onTapEdit.value == true
          //       ? AdminProfileEdit()
          const AdminProfileWidgetOne(),
          // )
        ],
      )),
    ),
  );
}

class AdminProfileEdit extends StatelessWidget {
  const AdminProfileEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Obx(
          //   () =>
          Stack(
            children: [
              Center(
                child: CircleAvatar(
                  radius: ResponsiveWebSite.isMobile(context) ? 50 : 70,
                  backgroundImage:
                      //  imageCtr.selectedImage.isNotEmpty
                      //     ? NetworkImage(imageCtr.selectedImage.value)
                      //     :
                      const AssetImage('webassets/png/avathar.png')
                          as ImageProvider,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 90, top: 60),
                child: Center(
                  child: CircleAvatar(
                    radius: ResponsiveWebSite.isMobile(context) ? 12 : 15,
                    backgroundColor: Colors.cyanAccent,
                  ),
                ),
              ),
              Center(
                  child: Padding(
                padding: const EdgeInsets.only(top: 65, left: 90),
                child: GestureDetector(
                  onTap: () async {
                    // imageCtr.pickImage();
                  },
                  child: Icon(
                    Icons.edit_square,
                    size: ResponsiveWebSite.isMobile(context) ? 15 : 18,
                  ),
                ),
              )),
            ],
          ),
          // ),
          TextFormFiledBlueContainerWidgetWithOutColor(
              // controller: profileCtr.nameController,
              hintText: ' Enter your name',
              title: 'Name'),
          TextFormFiledBlueContainerWidgetWithOutColor(
              // controller: profileCtr.designationController,
              hintText: ' Designation',
              title: 'Designation'),
          TextFormFiledBlueContainerWidgetWithOutColor(
              // controller: profileCtr.aboutController,
              hintText: ' About',
              title: 'About'),
          TextFormFiledBlueContainerWidgetWithOutColor(
              // controller: profileCtr.phoneController,
              hintText: ' phone no.',
              title: 'phone no.'),
          const TextFontWidget(text: 'Gender *', fontsize: 12.5),
          const SizedBox(height: 5),
          Container(
            color: screenContainerbackgroundColor,
            child: DropdownSearch(
              // selectedItem: profileCtr.gender.value,
              onSaved: (newValue) {
                // profileCtr.gender.value = newValue!;
              },
              onChanged: (value) {
                // profileCtr.gender.value = value!;
              },
              dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                      hintText: " Please Select Gender",
                      labelStyle: TextStyle(
                        fontSize: ResponsiveWebSite.isMobile(context) ? 13 : 15,
                      ),
                      contentPadding: const EdgeInsets.only(top: 5, bottom: 5),
                      prefixIcon: const Icon(
                        Icons.person_2,
                        size: 20,
                      ))),
              items: const ['Male', 'Female', 'Others'],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                // profileCtr.updateAdminProfile();
              },
              child: BlueContainerWidget(
                  title: "Save",
                  fontSize: ResponsiveWebSite.isMobile(context) ? 14 : 16,
                  color: cBlue,
                  width: 80),
            ),
          ),
        ],
      ),
    );
  }
}

class AdminProfileWidgetOne extends StatelessWidget {
  const AdminProfileWidgetOne({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                ),
                child: CircleAvatar(
                  radius: ResponsiveWebSite.isMobile(context) ? 50 : 70,
                  backgroundImage: NetworkImage(
                      UserCredentialsController.adminModel!.profileImageUrl),
                  //  const AssetImage('webassets/png/avathar.png')
                  //     as ImageProvider,
                  onBackgroundImageError: (error, stackTrace) {
                    log('Image load error: $error');
                  },
                ),
              ),
            ),
          ],
        ),
        ////////////////////////////////........................0
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Center(
              child: Text(
            UserCredentialsController.adminModel!.adminName,
            style: TextStyle(
                fontSize: ResponsiveWebSite.isMobile(context) ? 15 : 18,
                fontWeight: FontWeight.bold),
          )),
        ), ///////////////////////////////............1
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Center(
              child: Text(
            UserCredentialsController.adminModel!.designation,
            style: TextStyle(
                fontSize: ResponsiveWebSite.isMobile(context) ? 14 : 16,
                fontWeight: FontWeight.bold),
          )),
        ), /////////////////////////..............2
        const Divider(
          color: Colors.grey,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
          child: Text(
            "School details",
            style: TextStyle(
                fontSize: ResponsiveWebSite.isMobile(context) ? 14 : 17,
                fontWeight: FontWeight.bold),
          ),
        ), /////////////////////////.....................3
        SchoolProfileDetailsWidget(
          title: "School Name",
          profileData: UserCredentialsController.adminModel!.schoolName,
        ),
        ////////////////////////////////////////.............................6
        SchoolProfileDetailsWidget(
          title: "Licence Number",
          profileData:
              UserCredentialsController.adminModel!.schoolLicenceNumber,
        ),
        ////////////////////////////////////////.............................7
        SchoolProfileDetailsWidget(
          title: "School code",
          profileData: UserCredentialsController.adminModel!.schoolCode,
        ),
        ////////////////////////////////////////.............................8
        SchoolProfileDetailsWidget(
          title: "City",
          profileData: UserCredentialsController.adminModel!.city,
        ),
        ////////////////////////////////////////.............................8
        SchoolProfileDetailsWidget(
          title: "State",
          profileData: UserCredentialsController.adminModel!.state,
        ),
        ////////////////////////////////////////.............................4
        SchoolProfileDetailsWidget(
          title: "Country",
          profileData: UserCredentialsController.adminModel!.country,
        ),
        ////////////////////////////////////////.............................4
        const Divider(
          color: Colors.grey,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
          child: Text(
            "Contact Details",
            style: TextStyle(
                fontSize: ResponsiveWebSite.isMobile(context) ? 14 : 16,
                fontWeight: FontWeight.bold),
          ),
        ),
        ////////////////////////////////////////.............................5
        ProfileDetailsWidget(
          icon: Icons.phone_android,
          profileData: UserCredentialsController.adminModel!.phoneNumber,
        ),
        ////////////////////////////////////////.............................6
        ProfileDetailsWidget(
          icon: Icons.email,
          profileData: UserCredentialsController.adminModel!.adminEmail,
        ),
        ////////////////////////////////////////.............................7
        ProfileDetailsWidget(
          icon: Icons.home,
          profileData: UserCredentialsController.adminModel!.address,
        ),
        ////////////////////////////////////////.............................8
        ProfileDetailsWidget(
          icon: Icons.location_on,
          profileData: UserCredentialsController.adminModel!.place,
        ),
      ],
    );
  }
}

class ProfileDetailsWidget extends StatelessWidget {
  final IconData icon;
  final String profileData;

  const ProfileDetailsWidget({
    super.key,
    required this.icon,
    required this.profileData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
            ),
            child: Icon(
              icon,
              size: ResponsiveWebSite.isMobile(context) ? 14 : 16,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 10),
            child: Text(
              profileData,
              style: TextStyle(
                  fontSize: ResponsiveWebSite.isMobile(context) ? 14 : 16,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

class SchoolProfileDetailsWidget extends StatelessWidget {
  final String profileData;
  final String title;
  const SchoolProfileDetailsWidget({
    super.key,
    required this.title,
    required this.profileData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "$title  ",
              style: TextStyle(
                  fontSize: ResponsiveWebSite.isMobile(context) ? 14 : 15,
                  fontWeight: FontWeight.w600),
            ),
          ),
          const Flexible(child: Text(":")),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 10),
            child: Text(
              profileData,
              style: TextStyle(
                  fontSize: ResponsiveWebSite.isMobile(context) ? 14 : 15,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
