import 'package:flutter/material.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/fonts/google_poppins_widget.dart';
import 'package:new_project_driving/view/widget/responsive/responsive.dart';


class CopyRightWidget extends StatelessWidget {
  const CopyRightWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 2, 31, 54),
      height: 60,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GooglePoppinsWidgets(
            text: 'Copyright ©️ All right reserved | by LeptonCommunications',
            fontsize: ResponsiveWebSite.isMobile(context) ? 8 : 15,
            fontWeight: FontWeight.w500,
            color: cWhite,
          )
        ],
      ),
    );
  }
}