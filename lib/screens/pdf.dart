
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:holy_trinity_healthcare/constants/app_constants.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

class PdfViewer extends StatefulWidget{
  const PdfViewer({super.key, required this.data});
  final List<String> data;

  @override
  State<PdfViewer> createState() =>_PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer>{


  Future<Uint8List>  _generatePdf(List<String> data) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.nunitoExtraLight();
    final Directory appDocumentDirectory = await getApplicationDocumentsDirectory();

    final imageByteData = await rootBundle.load(AppConstants.logo);
    final imageUint8List = imageByteData.buffer
        .asUint8List(imageByteData.offsetInBytes, imageByteData.lengthInBytes);

    double fontSize = 14;

    final image = pw.MemoryImage(imageUint8List);
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
            pw.Row(
              children: [
                pw.Image(image, height: 100, width: 100, dpi: 200.0),
               pw.Padding(
                 padding: const pw.EdgeInsets.only(left: 20),
                 child:  pw.Column(
                   mainAxisAlignment: pw.MainAxisAlignment.start,
                   children: [
                     pw.FittedBox(
                       child: pw.Text(AppConstants.appName, style: pw.TextStyle(font: font,
                           fontSize: 30,
                           fontWeight: pw.FontWeight.bold
                       )),
                     ),
                     pw.FittedBox(
                       child: pw.Text(AppConstants.appDescription, style: pw.TextStyle(font: font,
                           fontSize: 15,
                           fontWeight: pw.FontWeight.bold
                       )),
                     ),
                   ]
                 )
               )
              ]
            ),
             pw.Padding(
               padding: const pw.EdgeInsets.only(top:20),
               child:  pw.Container(
                   height: 2,
                   decoration:const pw.BoxDecoration(
                       color: PdfColor.fromInt(20)
                   )
               ),
             ),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                  child: pw.Text('Name: ${data[0]}, ${data[1]} ${data[2]}', style: pw.TextStyle(font: font,
                  fontSize: fontSize
                  )),
                ),

              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text('Birthday: ${data[3]}', style: pw.TextStyle(font: font,
                    fontSize: fontSize
                )),
              ),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text('Age: ${data[4]}', style: pw.TextStyle(font: font,
                    fontSize: fontSize
                )),
              ),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text('Address: ${data[5]}', style: pw.TextStyle(font: font,
                    fontSize: fontSize
                )),
              ),
            ],
          );
        },
      ),
    );
    final file = File('${appDocumentDirectory.path}/example.pdf');
    await file.writeAsBytes(await pdf.save());
    return pdf.save();

  }
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body:PdfPreview(

          build: (context) => _generatePdf(widget.data),
        ) ,
      );
  }

}