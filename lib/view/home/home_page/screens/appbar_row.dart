import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_project_driving/view/widget/responsive/responsive.dart';

class ContentsHomePage1 extends StatelessWidget {
  const ContentsHomePage1({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {},
      child: Text(
        "About",
        style: GoogleFonts.roboto(
            fontSize: ResponsiveWebSite.isDesktop(context) ? screenSize.width / 90 : 6.5,
            fontWeight: ResponsiveWebSite.isDesktop(context) ? FontWeight.w500 : FontWeight.bold,
            color: Colors.black),
      ),
    );
  }
}

class ContentsHomePage2 extends StatelessWidget {
  const ContentsHomePage2({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Expanded(
      child: InkWell(
        onTap: () {},
        child: Text(
          "Schools",
          style: GoogleFonts.roboto(
              fontSize: ResponsiveWebSite.isDesktop(context) ? screenSize.width / 90 : 6.5,
              fontWeight: ResponsiveWebSite.isDesktop(context) ? FontWeight.w500 : FontWeight.bold,
              color: Colors.black),
        ),
      ),
    );
  }
}

class ContentsHomePage3 extends StatelessWidget {
  const ContentsHomePage3({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {},
      child: Text(
        "Colleges",
        style: GoogleFonts.roboto(
            fontSize: ResponsiveWebSite.isDesktop(context) ? screenSize.width / 90 : 6.5,
            fontWeight: ResponsiveWebSite.isDesktop(context) ? FontWeight.w500 : FontWeight.bold,
            color: Colors.black),
      ),
    );
  }
}

class ContentsHomePage4 extends StatelessWidget {
  const ContentsHomePage4({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {},
      child: Text(
        "Study Materials",
        style: GoogleFonts.roboto(
            fontSize: ResponsiveWebSite.isDesktop(context) ? screenSize.width / 90 : 6.5,
            fontWeight: ResponsiveWebSite.isDesktop(context) ? FontWeight.w500 : FontWeight.bold,
            color: Colors.black),
      ),
    );
  }
}

class ContentsHomePage5 extends StatelessWidget {
  const ContentsHomePage5({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {},
      child: Text(
        "Carriers",
        style: GoogleFonts.roboto(
            fontSize: ResponsiveWebSite.isDesktop(context) ? screenSize.width / 90 : 6.5,
            fontWeight: ResponsiveWebSite.isDesktop(context) ? FontWeight.w500 : FontWeight.bold,
            color: Colors.black),
      ),
    );
  }
}

class ContentsHomePage6 extends StatelessWidget {
  const ContentsHomePage6({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {},
      child: Text(
        "Contact Us",
        style: GoogleFonts.roboto(
            fontSize: ResponsiveWebSite.isDesktop(context) ? screenSize.width / 90 : 6.5,
            fontWeight: ResponsiveWebSite.isDesktop(context) ? FontWeight.w500 : FontWeight.bold,
            color: Colors.black),
      ),
    );
  }
}
