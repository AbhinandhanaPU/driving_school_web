import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_project_driving/view/widget/responsive/responsive.dart';

class HomeMainImageScreenWidget extends StatelessWidget {
  const HomeMainImageScreenWidget({
    super.key,
    required this.screenSize,
  });

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ResponsiveWebSite.isMobile(context) ? 250 : 500,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/car1.jpg'),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: ResponsiveWebSite.isMobile(context)
                ? const EdgeInsets.only(bottom: 0, left: 0)
                : ResponsiveWebSite.isTablet(context)
                    ? const EdgeInsets.only(bottom: 0, left: 0)
                    : const EdgeInsets.only(bottom: 40, left: 200),
          ),
          ResponsiveWebSite.isDesktop(context)
              ? Padding(
                  padding:
                      const EdgeInsets.only(left: 120, top: 100, bottom: 80),
                  child: SizedBox(
                    height: 200,
                    // color: Colors.amber,
                    child: Row(
                      children: [
                        Text(
                          "Accelerate Your Skills \n      With Our Driving School",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFCE8F2E),
                            fontSize: screenSize.width / 36,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : ResponsiveWebSite.isTablet(context)
                  ? const Padding(
                      padding: EdgeInsets.only(top: 100, bottom: 10),
                      child: SizedBox(
                        height: 200,
                        // color: Colors.amber,
                        child: Row(
                          children: [
                            Text(
                              "Accelerate Your Skills \n      With Our Driving School",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFCE8F2E),
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 100, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Accelerate Your\nSkills With Our\nDriving School",
                            style: GoogleFonts.castoroTitling(
                              // color: Colors.white,
                              color: const Color(0xFFCE8F2E),
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
        ],
      ),
    );
  }
}
