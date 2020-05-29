import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:printing/printing.dart';

class PDFViewScreen extends StatelessWidget {
  final String path;
  final doc;
  final String title;

  PDFViewScreen(this.path,this.doc,this.title);

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(appBar: AppBar(
      actions: <Widget>[
        IconButton(icon: Icon(Icons.share), onPressed: () async{
          await Printing.sharePdf(bytes: doc.save(), filename: title+".pdf");
        })
      ],
    ),
      path: path,
    );
  }
}