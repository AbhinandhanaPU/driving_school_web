import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/controller/user_login_Controller/user_login_controller.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';
import 'package:new_project_driving/view/home/appbar/login_button.dart';
import 'package:new_project_driving/view/signup_section/student_signup_section.dart';
import 'package:new_project_driving/view/widget/responsive/responsive.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

void _launchURL(String url) async {
  if (await canLaunchUrlString(url)) {
    launchUrl;
  } else {
    throw 'Could not launch $url';
  }
}

class ResponsiveMobileAppBar extends StatelessWidget {
  const ResponsiveMobileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    double maxWidthValue;
    return LayoutBuilder(builder: (context, constrain) {
      maxWidthValue = constrain.maxWidth;

      return Container(
        color: const Color.fromARGB(255, 20, 37, 59),
        height: 100,
        // ResponsiveWebSite.isMobile(context) ? 150 : 100,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: ResponsiveWebSite.isMobile(context) ? 10 : 20),
          child: Row(
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          if (kDebugMode) {
                            print("logoutUser");
                          }
                          await Get.find<UserLoginController>()
                              .logoutSaveData()
                              .then((value) => logoutUser());
                          logoutUser();
                        },
                        child: Image.asset(
                          'assets/images/leptonlogo.png',
                          fit: BoxFit.contain,
                          height: ResponsiveWebSite.isMobile(context) ? 40 : 60,
                          width: ResponsiveWebSite.isMobile(context) ? 40 : 60,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: ResponsiveWebSite.isMobile(context) ? 40 : 30,
                        left: ResponsiveWebSite.isMobile(context) ? 10 : 70),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const StudentProfileCreationScreen();
                          },
                        ));
                      },
                      child: Container(
                        width: 100,
                        height: 30,
                        decoration: BoxDecoration(
                            color: excelkaroorThemeColor.withOpacity(0.2),
                            border: Border.all(color: cWhite),
                            borderRadius: BorderRadius.circular(10)),
                        alignment: Alignment.center,
                        child: const TextFontWidget(
                          text: "REGISTER",
                          fontsize: 13,
                          fontWeight: FontWeight.bold,
                          color: cWhite,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AppBarPhoneNumber(maxWidthValue),
                  Visibility(
                    visible: maxWidthValue > 220,
                    child: Expanded(
                      child: Row(
                        children: [
                          const LoginButton(),
                          ResponsiveWebSite.isMobile(context)
                              ? const SizedBox()
                              // ? Row(
                              //     children: [
                              //       IconButton(
                              //         icon: const FaIcon(
                              //           size: 15,
                              //           FontAwesomeIcons.facebook,
                              //           color: Colors.white,
                              //         ),
                              //         onPressed: () => _launchURL(
                              //             'https://www.facebook.com'),
                              //       ),
                              //       IconButton(
                              //         icon: const FaIcon(
                              //           size: 15,
                              //           FontAwesomeIcons.instagram,
                              //           color:
                              //               Color.fromARGB(255, 217, 83, 128),
                              //         ),
                              //         onPressed: () => _launchURL(
                              //             'https://www.instagram.com'),
                              //       ),
                              //       IconButton(
                              //         focusColor: Colors.black,
                              //         icon: const FaIcon(
                              //           size: 15,
                              //           FontAwesomeIcons.xTwitter,
                              //           color: Colors.white,
                              //         ),
                              //         onPressed: () =>
                              //             _launchURL('https://www.twitter.com'),
                              //       ),
                              //       IconButton(
                              //         icon: const FaIcon(
                              //           size: 15,
                              //           FontAwesomeIcons.youtube,
                              //           color: Colors.red,
                              //         ),
                              //         onPressed: () =>
                              //             _launchURL('https://www.youtube.com'),
                              //       ),
                              //     ],
                              //   )
                              : Row(
                                  children: [
                                    IconButton(
                                      icon: const FaIcon(
                                        size: 20,
                                        FontAwesomeIcons.facebook,
                                        color: Colors.white,
                                      ),
                                      onPressed: () => _launchURL(
                                          'https://www.facebook.com'),
                                    ),
                                    IconButton(
                                      icon: const FaIcon(
                                        size: 20,
                                        FontAwesomeIcons.instagram,
                                        color:
                                            Color.fromARGB(255, 217, 83, 128),
                                      ),
                                      onPressed: () => _launchURL(
                                          'https://www.instagram.com'),
                                    ),
                                    IconButton(
                                      focusColor: Colors.black,
                                      icon: const FaIcon(
                                        size: 20,
                                        FontAwesomeIcons.xTwitter,
                                        color: Colors.white,
                                      ),
                                      onPressed: () =>
                                          _launchURL('https://www.twitter.com'),
                                    ),
                                    IconButton(
                                      icon: const FaIcon(
                                        size: 20,
                                        FontAwesomeIcons.youtube,
                                        color: Colors.red,
                                      ),
                                      onPressed: () =>
                                          _launchURL('https://www.youtube.com'),
                                    ),
                                  ],
                                )

                          // ResponsiveWebSite.isDesktop(context)
                          //     ? const SocaiMedaAtAppbar()

                          //     : ResponsiveWebSite.isTablet(context)
                          //     ? const SocaiMedaAtAppbar():
                          //     const SocaiMedaAtAppbar()

                          // ListView(
                          //     shrinkWrap: true,
                          //     scrollDirection: Axis.horizontal,
                          //     physics: const NeverScrollableScrollPhysics(),
                          //     children: socailMediaList
                          //         .map((data) => Row(
                          //               children: [
                          //                 Padding(
                          //                   padding: const EdgeInsets.all(10),
                          //                   child: InkWell(
                          //                       onTap: data.tilteFunExecution,
                          //                       // child: data.assetImage!,
                          //                       child: Image.asset(
                          //                         data.imageString!,
                          //                         height: 20,
                          //                         width: 20,
                          //                         color: cBlack,
                          //                       )

                          //                       // data.assetImage!,
                          //                       ),
                          //                 ),
                          //               ],
                          //             ))
                          //         .toList()),
                        ],
                      ),
                    ),
                  ),
                  ResponsiveWebSite.isMobile(context)
                      ? const SizedBox()
                      : Visibility(
                          visible: maxWidthValue < 430,
                          child: const Row(
                            children: [
                              LoginButton(),
                            ],
                          ),
                        )
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}

class AppBarPhoneNumber extends StatelessWidget {
  final double maxWidthValue;
  const AppBarPhoneNumber(
    this.maxWidthValue, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: maxWidthValue < 430
          ? const Padding(
              padding: EdgeInsets.all(7),
              child: Column(
                children: [
                  MobNumber01(),
                  MobNumber02(),
                ],
              ),
            )
          : const Padding(
              padding: EdgeInsets.all(7),
              child: Row(
                children: [
                  MobNumber01(),
                  MobNumber02(),
                ],
              ),
            ),
    );
  }
}

class MobNumber02 extends StatelessWidget {
  const MobNumber02({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '✉️ info@drivingschool.com ',
      style: GoogleFonts.poppins(
          // themeColorBlue,
          color: cWhite,
          fontSize: ResponsiveWebSite.isMobile(context) ? 09 : 12,
          fontWeight: FontWeight.w400),
    );
  }
}

class MobNumber01 extends StatelessWidget {
  const MobNumber01({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '📞 +91 9562776043     ',
      style: GoogleFonts.poppins(
          color: cWhite,
          //Color(0xFF17BDB5),
          fontSize: ResponsiveWebSite.isMobile(context) ? 09 : 12,
          fontWeight: FontWeight.w500),
    );
  }
}
