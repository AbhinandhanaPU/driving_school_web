import 'dart:html' as html;
import 'dart:io' as io;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class PDFViewer extends StatefulWidget {
  final String fileUrl;

  const PDFViewer({super.key, required this.fileUrl});

  @override
  _PDFViewerState createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer> {
  String localFilePath = '';
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _downloadFile(widget.fileUrl);
  }

  Future<void> _downloadFile(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        if (kIsWeb) {
          _saveAndLaunchWebFile(bytes, 'temp.pdf');
        } else {
          final dir = await getApplicationDocumentsDirectory();
          final file = io.File('${dir.path}/temp.pdf');
          await file.writeAsBytes(bytes, flush: true);
          setState(() {
            localFilePath = file.path;
          });
        }
      } else {
        setState(() {
          errorMessage = 'Failed to load PDF. Status code: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return
    // localFilePath.isEmpty
        // ? errorMessage.isEmpty
        //     ? const Center(child: CircularProgressIndicator())
        //     : Center(child: Text(errorMessage))
        // :
         kIsWeb
            ? const Center(child: Text('PDF downloaded for web. Check your downloads.'))
            : PDFView(filePath: localFilePath);
  }

  void _saveAndLaunchWebFile(Uint8List bytes, String fileName) {
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", fileName)
      ..click();
    html.Url.revokeObjectUrl(url);
  }
}
