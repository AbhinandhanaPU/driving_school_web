import 'package:flutter/material.dart';
import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:new_project_driving/colors/colors.dart';

class ExploreDrawer extends StatelessWidget {
  const ExploreDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 50.w),
        child: Drawer(
          child: Container(
            color: Colors.blueGrey.shade900,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: cWhite,
                        size: 35,
                      )),
                  SizedBox(
                    height: 150.w,
                    width: 160.w,
                    child: Image.asset('webassets/images/leptdujo.png'),
                  ),
                  InkWell(
                    onTap: () {
                      //    Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: Divider(
                      color: Colors.blueGrey.shade400,
                      thickness: 2,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      'Log Out',
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: Divider(
                      color: Colors.blueGrey.shade400,
                      thickness: 2,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      'Contact Us',
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: Divider(
                      color: Colors.blueGrey.shade400,
                      thickness: 2,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      '',
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        '',
                        style: TextStyle(
                          color: Colors.blueGrey.shade300,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
