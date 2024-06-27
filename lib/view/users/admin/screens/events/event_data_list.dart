import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/controller/event_controller/event_controller.dart';
import 'package:new_project_driving/model/event_model/events_model.dart';
import 'package:new_project_driving/view/users/admin/screens/events/event_edit.dart';
import 'package:new_project_driving/view/widget/custom_delete_showdialog/custom_delete_showdialog.dart';
import 'package:new_project_driving/view/widget/reusable_table_widgets/data_container.dart';

class AllEventsDataList extends StatelessWidget {
  final int index;
  final EventModel data;
  AllEventsDataList({
    required this.data,
    required this.index,
    super.key,
  });
  final EventController eventController = Get.put(EventController());

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
                headerTitle: '${index + 1}'), //....................No
          ),
          const SizedBox(
            width: 02,
          ),
          Expanded(
            flex: 4,
            child: DataContainerWidget(
                rowMainAccess: MainAxisAlignment.center,
                color: cWhite,
                index: index,
                headerTitle: data.eventName),
          ), //.............................Event Name
          const SizedBox(
            width: 02,
          ),
          Expanded(
            flex: 4,
            child: DataContainerWidget(
                rowMainAccess: MainAxisAlignment.center,
                color: cWhite,
                // width: 150,
                index: index,
                headerTitle: data.eventDescription),
          ), // ...................................Event Description
          const SizedBox(
            width: 02,
          ),
          Expanded(
            flex: 4,
            child: DataContainerWidget(
                rowMainAccess: MainAxisAlignment.center,
                color: cWhite,
                // width: 150,
                index: index,
                headerTitle: data.eventDate),
          ), // ...................................Event date
          const SizedBox(
            width: 02,
          ),
          Expanded(
            flex: 4,
            child: DataContainerWidget(
                rowMainAccess: MainAxisAlignment.center,
                color: cWhite,
                // width: 150,
                index: index,
                headerTitle: data.venue),
          ), // ...................................Event venue
          const SizedBox(
            width: 02,
          ),
          Expanded(
            flex: 4,
            child: DataContainerWidget(
                rowMainAccess: MainAxisAlignment.center,
                color: cWhite,
                // width: 150,
                index: index,
                headerTitle: data.signedBy),
          ), // ...................................Event signed by
          const SizedBox(
            width: 02,
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  eventController.editnameController.text = data.eventName;
                  eventController.editeventdateController.text = data.eventDate;
                  eventController.editvenueController.text = data.venue;
                  eventController.editdescriptionController.text =
                      data.eventDescription;
                  eventController.editsignedByController.text = data.signedBy;
                  editFunctionOfEvent(context, data);
                },
                child: DataContainerWidget(
                    rowMainAccess: MainAxisAlignment.center,
                    color: cWhite,
                    // width: 150,
                    index: index,
                    headerTitle: 'Update 🖋️'),
              ),
            ),
          ), //....................................... Edit
          const SizedBox(
            width: 02,
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  customDeleteShowDialog(
                      context: context,
                      onTap: () {
                        eventController.deleteEvent(
                          data.id,
                          context,
                        );
                        Navigator.pop(context);
                      });
                },
                child: DataContainerWidget(
                    rowMainAccess: MainAxisAlignment.center,
                    color: cWhite,
                    index: index,
                    headerTitle: ' Remove 🗑️'),
              ),
            ),
          ), //....................Delete
        ],
      ),
    );
  }
}
