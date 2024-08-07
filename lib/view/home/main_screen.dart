import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:new_project_driving/view/home/home_page/home_screen.dart';
import 'package:new_project_driving/view/widget/responsive/responsive.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    log('height    ${size.height}');
    log('Width    ${size.width}');
    return Scaffold(
      body: ResponsiveWebSite(
        mobile: HomeScreen(),
        tablet: HomeScreen(),
        desktop: HomeScreen(),
      ),
    );
  }
}
