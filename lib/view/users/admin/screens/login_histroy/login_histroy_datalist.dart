import 'package:flutter/material.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/constant/constant.validate.dart';
import 'package:new_project_driving/fonts/text_widget.dart';
import 'package:new_project_driving/model/login_history_model/login_history_model.dart';
import 'package:new_project_driving/view/widget/reusable_table_widgets/data_container.dart';

class AllLoginLogoutDataList extends StatelessWidget {
  final int index;
  final AdminLoginDetailHistoryModel data;
  const AllLoginLogoutDataList({
    required this.index,
    required this.data,
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
                Expanded(
                  child: TextFontWidget(
                    text: "  ${data.adminuserName}",
                    fontsize: 12,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 02,
          ),
          Expanded(
            flex: 4,
            child: Row(
              children: [
                Expanded(
                  child: TextFontWidget(
                    text: "  ${data.adminuserName}",
                    fontsize: 12,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 02,
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(
                  child: TextFontWidget(
                    text: "  ${timeConvert(DateTime.parse(data.loginTime))}",
                    fontsize: 12,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 02,
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(
                  child: TextFontWidget(
                    text: data.logoutTime == ''
                        ? 'Not found'
                        : timeConvert(DateTime.parse(data.logoutTime)),
                    fontsize: 12,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 02,
          ),
        ],
      ),
    );
  }
}
