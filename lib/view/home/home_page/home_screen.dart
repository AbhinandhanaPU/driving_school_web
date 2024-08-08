import 'package:flutter/material.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/fonts/google_monstre.dart';
import 'package:new_project_driving/fonts/google_poppins_widget.dart';
import 'package:new_project_driving/view/home/appbar/app_bar.dart';
import 'package:new_project_driving/view/home/home_page/HomeMainImageScreen/HomeMainImage_screen.dart';
import 'package:new_project_driving/view/home/home_page/about/about.dart';
import 'package:new_project_driving/view/home/home_page/screens/footer/footer.dart';
import 'package:new_project_driving/view/home/home_page/screens/footer/lepton_footerbar.dart';
import 'package:new_project_driving/view/home/home_page/screens/footer/widgets/copyright_widget.dart';
import 'package:new_project_driving/view/widget/responsive/responsive.dart';

class HomeScreen extends StatelessWidget {
  final ScrollController sscrollcontroller = ScrollController();
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: cWhite,
      appBar: const PreferredSize(
          preferredSize: Size(double.infinity, 100), child: ResponsiveMobileAppBar()),
      body: ListView(
        children: [
          HomeMainImageScreenWidget(screenSize: screenSize),

          /// Main Image Screen Section >>>>>>>>>>>>>>>

          const AboutWidget(), // Read More Section >>>>>>>>>
          //  const OurPracticesContainerWidget(),
          // Padding(
          //   padding: const EdgeInsets.only(top: 10),
          //   child: VideoSectionContainer(sscrollcontroller: sscrollcontroller),
          // ),

          Padding(
            padding: const EdgeInsets.only(top: 1),
            child: Container(
              height: ResponsiveWebSite.isMobile(context)
                  ? 350
                  : 500, 
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/images/blue_background.jpg',),fit: BoxFit.fill)
                  ),// Adjust the height of the containers as needed
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: GooglePoppinsWidgets(
                      text: 'OUR SERVICES',
                      fontsize: 25,
                      fontWeight: FontWeight.w800,
                      color: cred,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             ArticleView(
                                  //                 url: snapshot.data!
                                  //                         .docs[index]
                                  //                     ['articleUrl'])));
                                },
                                child: Container(
                                    margin: const EdgeInsets.all(8.0),
                                    width: ResponsiveWebSite.isMobile(context)
                                        ? 200
                                        : 400, // Adjust the width of each container as needed
                                    child: Container(
                                      color: Colors.white,
                                      child: Image.asset('assets/images/car_interior.jpg'),
                                    )),
                              ),
                              GoogleMonstserratWidgets(
                                text: "-----",
                                fontsize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ],
                          );
                        }),
                  )
                ],
              ),
            ),
          ),

          // Padding(
          //   padding: const EdgeInsets.only(top: 10),
          //   child: OurTeamContainerWidget(sscrollcontroller: sscrollcontroller),
          // ),

          // const Divider(
          //   height: 01,
          //   // thickness: 01,
          //   color: cWhite,
          // ),
          // const FooterSectionScreen(),
          // const Divider(
          //   height: 01,
          //   // thickness: 01,
          //   color: cWhite,
          // ),
          // const CopyRightWidget()

          const FooterSectionScreen(),
                 const Divider(
                  thickness: 01,
                  color: cBlack,
                ),
                const LeptonFooterBar(),
                const CopyRightWidget()
        ],
      ),
    );
  }
}

List<String> persionPhotos = [
  'assets/images/persion_4.jpeg',
  'assets/images/persion_2.jpeg',
  'assets/images/persion_1.jpeg',
  'assets/images/persion_3.jpeg',
];
List<String> persion_text = [''];

List<String> headerText = [
  'Home',
  'About',
  'Sevices',
];
