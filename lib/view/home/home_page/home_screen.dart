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
                  SizedBox(
              // color: Colors.black,
              height: ResponsiveWebSite.isMobile(context) ? 500 : 350,
              // width: 600,
              child: ResponsiveWebSite.isDesktop(context)
                  ? ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      // shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      // controller: sscrollcontroller,
                      itemBuilder: (context, index) {
                        //  final data = CreateEmployeeClassModel.fromMap(snapshot.data!.docs[index].data());
                        return SizedBox(
                          height: 400,
                          width: 400,
                          child: Column(
                            children: [
                              Expanded(
                                child: Image.network(
                                  personPhotos[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.only(top: 05),
                              //   child: Text(
                              //    personNameList[index],
                              //     style: const TextStyle(
                              //         color: cWhite,
                              //         fontWeight: FontWeight.w400),
                              //   ),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.only(bottom: 20),
                              //   child: GooglePoppinsWidgets(
                              //     text: personOccu[index],
                              //     fontsize: 10,
                              //     color: cWhite,
                              //     fontWeight: FontWeight.w200,
                              //   ),
                              // )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 20,
                        );
                      },
                      itemCount: 4)
                  : GridView.count(
                      crossAxisCount: 2,
                      padding: const EdgeInsets.all(20),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      primary: false,
                      children: List.generate(4, (index) {
                        //    final data = CreateEmployeeClassModel.fromMap(snapshot.data!.docs[index].data());
                        return SizedBox(
                          // margin: ,
                          height: 100,
                          width: 100,
                          // color: Colors.amber,
                          child: Column(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Image.network(
                                    personPhotos[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ))
                ],
              ),
            ),
          ),


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

List<String> personPhotos = [
  'https://firebasestorage.googleapis.com/v0/b/driving-school-6e78e.appspot.com/o/driving_school_homeimages%2Fcar_interior.jpg?alt=media&token=a0bbc52a-6f02-46dd-8e4c-587dffd3075b',
  'https://firebasestorage.googleapis.com/v0/b/driving-school-6e78e.appspot.com/o/driving_school_homeimages%2Fidcard.jpg?alt=media&token=0e425c29-db53-4372-8b2c-4bfdc5050bef',
  'https://firebasestorage.googleapis.com/v0/b/driving-school-6e78e.appspot.com/o/driving_school_homeimages%2Fsignals.jpg?alt=media&token=ef6b7092-f99d-4546-9bfb-856be2b96b2e',
  'https://firebasestorage.googleapis.com/v0/b/driving-school-6e78e.appspot.com/o/driving_school_homeimages%2Fvehicles.jpg?alt=media&token=5b28c347-e6a2-46a3-b0e7-03b796e4ac79',
];
List<String> persion_text = [''];

List<String> headerText = [
  'Home',
  'About',
  'Sevices',
];
