import 'package:flutter/material.dart';
import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:new_project_driving/fonts/google_monstre.dart';

class FeatureTile extends StatelessWidget {
  const FeatureTile(
      {super.key,
      required this.topMargin,
      required this.iconImageUrl,
      required this.title});

  final String title;
  final String iconImageUrl;
  final double? topMargin;

  String get _iconImageUrl => "";

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: topMargin!),
      child: Padding(
        padding: EdgeInsets.all(12.0.h),
        child: Container(
          height: 100.h,
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1),
              color: Colors.white,
              //   boxShadow: const [
              //     BoxShadow(
              //       color: Colors.grey,
              //       offset: Offset(
              //         15.0,
              //         15.0,
              //       ),
              //       blurRadius: 2.0,
              //       spreadRadius: 2.0,
              //     ), //BoxShadow
              //     BoxShadow(
              //       color: Colors.black,
              //       offset: Offset(0.15, 0.15),
              //       blurRadius: 0.0,
              //       spreadRadius: 0.0,
              //     ), //BoxShadow
              //  ],

              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(255, 0, 0, 0),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
              borderRadius: const BorderRadius.all(Radius.circular(0))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.h),
                child: Image.asset(
                  "webassets/images/$iconImageUrl",
                  height: 25.h,
                  width: 25.h,
                ),
              ),
              SizedBox(
                width: 20.h,
              ),
              Padding(
                padding: EdgeInsets.all(8.0.w),
                child: GoogleMonstserratWidgets(text: title, fontsize: 12.h),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _iconImageUrl {}
