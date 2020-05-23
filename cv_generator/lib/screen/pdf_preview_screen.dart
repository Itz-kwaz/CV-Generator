import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';

class PdfViewScreen extends StatelessWidget{
  final String path;
  PdfViewScreen({this.path});
  @override
  Widget build(BuildContext context) {
    print("pdf view screen");
    return PDFViewerScaffold(
      path: path,
    );
  }

}