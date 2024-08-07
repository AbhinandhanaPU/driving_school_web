import 'package:flutter/material.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/fonts/google_poppins_widget.dart';
import 'package:new_project_driving/view/widget/responsive/responsive.dart';

class LeptonFooterBar extends StatelessWidget {
  const LeptonFooterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color.fromARGB(255, 1, 52, 93)),
      height: ResponsiveWebSite.isMobile(context) ? 500 : 200,
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(
            height: ResponsiveWebSite.isMobile(context) ? 500 : 200,
            width: double.infinity,
            child: ResponsiveWebSite.isMobile(context)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 100,
                        width: 150,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image:
                                AssetImage('webassets/images/leptonlogo.png'),
                          ),
                        ),
                      ),
                      SizedBox(
                        // color: Colors.red,
                        height: 190,
                        width: 350,
                        child: Center(
                          child: GooglePoppinsWidgets(
                              color: cWhite,
                              text:
                                  'Lepton Plus Communications is a customer oriented company offering digital solutions in Healthcare,E-Commerce Applications\nHome Automation and Social Networking.\nWe are commited to providing high end sustainable products and services that\nenhances the quality of life',
                              fontsize: 12),
                        ),
                      ),
                      SizedBox(
                        width: 350,
                          height: 90,
                          child: GooglePoppinsWidgets(text: 
                          '📌 Lepton Plus Communications (OPC) Pvt.Ltd\n'
                                '5 th Floor,Karimpanal Statue Avenue , G.H. Road \n'
                                'Statue,Thiruvanathapuram - 695001,Kerala,India\n'
                            '📞 +91 97469 66651 | +91 97463 66651 | +91 471 4053483\n'
                            '✉️ info@leptoncommunications.com\n'
                            '✉️ leptoncommunications@gmail.com',color: cWhite, fontsize: 11),
                        ),
                    ],
                  )
                : Row(
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image:
                                AssetImage('webassets/images/leptonlogo.png'),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 200),
                          child: SizedBox(
                            height: 150,
                            child: Center(
                              child: GooglePoppinsWidgets(
                                  color: cWhite,
                                  text:
                                      'Lepton Plus Communications is a customer oriented company offering digital solutions in Healthcare,E-Commerce Applications\nHome Automation and Social Networking.\nWe are commited to providing high end sustainable products and services that\nenhances the quality of life',
                                  fontsize: 13),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 150,
                          child: GooglePoppinsWidgets(text: 
                          '📌 Lepton Plus Communications (OPC) Pvt.Ltd\n'
                                '5 th Floor,Karimpanal Statue Avenue , G.H. Road \n'
                                'Statue,Thiruvanathapuram - 695001,Kerala,India\n'
                            '📞 +91 97469 66651 | +91 97463 66651 | +91 471 4053483\n'
                            '✉️ info@leptoncommunications.com\n'
                            '✉️ leptoncommunications@gmail.com',color: cWhite, fontsize: 13),
                        ),
                      )
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
