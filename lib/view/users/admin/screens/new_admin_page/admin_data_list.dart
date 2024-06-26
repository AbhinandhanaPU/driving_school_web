import 'package:flutter/material.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/model/new_admin_model/new_admin_model.dart';
import 'package:new_project_driving/utils/firebase/firebase.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';
import 'package:new_project_driving/view/widget/custom_showdialouge/custom_showdilog.dart';
import 'package:new_project_driving/view/widget/reusable_table_widgets/data_container.dart';

class AdminDataList extends StatelessWidget {
  final AdminDetailsModel data;

  final int index;
  const AdminDataList({
    required this.data,
    required this.index,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: index % 2 == 0
            ? const Color.fromARGB(255, 246, 246, 246)
            : Colors.blue[50],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: DataContainerWidget(
                rowMainAccess: MainAxisAlignment.center,
                color: cWhite,
                // width: 150,
                index: index,
                headerTitle: '${index + 1}'),
          ),
          const SizedBox(
            width: 01,
          ),
          Expanded(
            flex: 4,
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                  child: Center(
                    child: Image.asset(
                      'webassets/stickers/icons8-student-100 (1).png',
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFontWidget(
                      text: data.username,
                      fontsize: 12,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 01,
          ),
          Expanded(
            flex: 4,
            child: Row(
              children: [
                SizedBox(
                  width: 15,
                  child: Center(
                    child: Image.asset(
                      'webassets/png/gmail.png',
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFontWidget(
                      text: data.email,
                      fontsize: 12,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 01,
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                SizedBox(
                  width: 15,
                  child: Center(
                    child: Image.asset(
                      'webassets/png/telephone.png',
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFontWidget(
                      text: data.phoneNumber,
                      fontsize: 12,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 01,
          ),
          Expanded(
              flex: 3,
              child: GestureDetector(
                onTap: () {
                  data.active == true
                      ? customShowDilogBox2(
                          children: [
                            const TextFontWidget(
                                text: "Do you want deactive this admin now ?",
                                fontsize: 14)
                          ],
                          doyouwantActionButton: true,
                          context: context,
                          title: "Alert",
                          actiononTapfuction: () async {
                            server
                                .collection('DrivingSchoolCollection')
                                .doc(UserCredentialsController.schoolId)
                                .collection('Admins')
                                .doc(data.docid)
                                .update({"active": false}).then(
                                    (value) => Navigator.pop(context));
                          },
                        )
                      : customShowDilogBox2(
                          children: [
                              const TextFontWidget(
                                  text: "Do you want active this admin now ?",
                                  fontsize: 14)
                            ],
                          doyouwantActionButton: true,
                          context: context,
                          title: "Alert",
                          actiononTapfuction: () async {
                            server
                                .collection('DrivingSchoolCollection')
                                .doc(UserCredentialsController.schoolId)
                                .collection('Admins')
                                .doc(data.docid)
                                .update({"active": true}).then(
                                    (value) => Navigator.pop(context));
                          });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 15,
                      child: Image.asset(
                        data.active == true
                            ? 'webassets/png/active.png'
                            : 'webassets/png/shape.png',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFontWidget(
                        text: data.active == true ? "Active" : "Deactive",
                        fontsize: 12,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
