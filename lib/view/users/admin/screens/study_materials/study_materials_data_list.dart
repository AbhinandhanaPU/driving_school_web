import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/controller/study_materials/study_materials_controller.dart';
import 'package:new_project_driving/view/users/admin/screens/study_materials/pdf_viewer.dart';
import 'package:new_project_driving/view/users/admin/screens/study_materials/study_materials_edit.dart';
import 'package:new_project_driving/view/widget/custom_delete_showdialog/custom_delete_showdialog.dart';
import 'package:new_project_driving/view/widget/reusable_table_widgets/data_container.dart';

class StudyMaterialsDataList extends StatelessWidget {
  final int index;
  final Map<String, dynamic> data;
  const StudyMaterialsDataList({
    super.key,
    required this.index,
    required this.data,
  });
  @override
  Widget build(BuildContext context) {
    StudyMaterialsController studyMaterialsController =
        Get.put(StudyMaterialsController());
    String fileName = data['fileName'];
    String fileExtension = fileName.split('.').last;

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
              headerTitle: data['title'],
            ),
          ), //............................. Name
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
              headerTitle: data['des'],
            ),
          ), // ................................... Description
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
              headerTitle: data['category'],
            ),
          ), // ................................... Category
          const SizedBox(
            width: 02,
          ),
          Expanded(
            flex: 3,
            child: DataContainerWidget(
              rowMainAccess: MainAxisAlignment.center,
              color: cWhite,
              // width: 150,
              index: index,
              headerTitle: fileExtension,
            ),
          ), // ................................... Type
          const SizedBox(
            width: 02,
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  studyMaterialsController.titleEditController.text =
                      data['title'];
                  studyMaterialsController.desEditController.text = data['des'];
                  studyMaterialsController.cateEditController.text =
                      data['category'];
                  editFunctionOfStudyMaterials(context, data);
                },
                child: DataContainerWidget(
                    rowMainAccess: MainAxisAlignment.center,
                    color: cWhite,
                    index: index,
                    headerTitle: ' Update 🖋️'),
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
                    onTap: () async {
                      await studyMaterialsController.deleteStudyMaterial(
                          docId: data['docId']);
                      //  .then((value) => Navigator.pop(context));
                    },
                  );
                },
                child: DataContainerWidget(
                    rowMainAccess: MainAxisAlignment.center,
                    color: cWhite,
                    index: index,
                    headerTitle: ' Remove 🗑️'),
              ),
            ),
          ), //....................Delete
             const SizedBox(
            width: 02,
          ),//////////////////////////view
          Expanded(
            flex: 2,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  customViewShowDialog(
                    context: context, data: data,
                   
                  );
                },
                child: DataContainerWidget(
                    rowMainAccess: MainAxisAlignment.center,
                    color: cWhite,
                    index: index,
                    headerTitle: ' View '),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

customViewShowDialog({
  required BuildContext context,
  required Map<String, dynamic> data,
}) {
  final String downloadUrl = data['downloadUrl'] ?? '';
  final String fileName = data['fileName'] ?? '';

  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: const Text(
        "View Study Material",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      content: SizedBox(
        height: 200,
        width: 300,
        child: FutureBuilder<String>(
          future: _getFileType(downloadUrl),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final String fileType = snapshot.data ?? 'unknown';

            switch (fileType) {
              case 'image':
                return Image.network(
                  downloadUrl,
                  errorBuilder: (context, error, stackTrace) {
                    print('Error loading image: $error');
                    return const Center(child: Text('Failed to load image'));
                  },
                );
              case 'pdf':
                return PDFViewer(fileUrl: downloadUrl);
              default:
                return const Text('Unsupported file type');
            }
          },
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        ),
      ],
    ),
  );
}






Future<String> _getFileType(String url) async {
  final uri = Uri.parse(url);
  final path = uri.path;
  print('File path: $path'); 
  
  if (path.endsWith('.jpg') || path.endsWith('.jpeg') || path.endsWith('.png')) {
    return 'image';
  } else if (path.endsWith('.pdf')) {
    return 'pdf';
  } 
  // else if (path.endsWith('.mp4')) {
  //   return 'video'; 
  // } 
  else {
    return 'unknown';
  }
}




