import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:holy_trinity_healthcare/constants/app_constants.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

import '../utils/utils.dart';

class PdfViewer extends StatefulWidget {
  const PdfViewer({super.key, required this.data});
  final List<String> data;

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {

  //function to generate pdf. styling
  Future<Uint8List> _generatePdf(List<String> data) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.abhayaLibreRegular();
    final fontFooter = await PdfGoogleFonts.courierPrimeItalic();


    final imageByteData = await rootBundle.load(AppConstants.logo);
    final imageUint8List = imageByteData.buffer
        .asUint8List(imageByteData.offsetInBytes, imageByteData.lengthInBytes);

    double fontSize = 14;
    double titleFontSize = 16;
    double footerFontSize = 10;

    pw.Padding divisionWidget() => pw.Padding(
          padding: const pw.EdgeInsets.only(top: 20, bottom: 10),
          child: pw.Container(
              height: 2,
              decoration: const pw.BoxDecoration(color: PdfColor.fromInt(20))),
        );

    final image = pw.MemoryImage(imageUint8List);
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Row(children: [
                pw.Image(image, height: 100, width: 100, dpi: 200.0),
                pw.Padding(
                    padding: const pw.EdgeInsets.only(left: 20),
                    child: pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        children: [
                          pw.FittedBox(
                            child: pw.Text(AppConstants.appName,
                                style: pw.TextStyle(
                                    font: font,
                                    fontSize: 30,
                                    fontWeight: pw.FontWeight.bold)),
                          ),
                          pw.FittedBox(
                            child: pw.Text(AppConstants.appDescription,
                                style: pw.TextStyle(
                                    font: font,
                                    fontSize: 15,
                                    fontWeight: pw.FontWeight.bold)),
                          ),
                        ]))
              ]),
              divisionWidget(),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                                'Name: ${Utils.getFullName(data[0], data[1], data[2])}',
                                style: pw.TextStyle(
                                    font: font, fontSize: fontSize)),
                          ),
                          pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text('Address: ${data[5]}',
                                style: pw.TextStyle(
                                    font: font, fontSize: fontSize)),
                          ),
                          pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text('Date: ${Utils.formatDate(DateTime.now(), true)}',
                                style: pw.TextStyle(
                                    font: font, fontSize: fontSize)),
                          ),
                        ]),
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Align(
                            alignment: pw.Alignment.centerRight,
                            child: pw.Text('Birthday: ${data[3]}',
                                style: pw.TextStyle(
                                    font: font, fontSize: fontSize)),
                          ),
                          pw.Align(
                            alignment: pw.Alignment.centerRight,
                            child: pw.Text('Age: ${data[4]}',
                                style: pw.TextStyle(
                                    font: font, fontSize: fontSize)),
                          ),
                          pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text('',
                                style: pw.TextStyle(
                                    font: font, fontSize: fontSize)),
                          ),
                        ])
                  ]),
              divisionWidget(),
              pw.Padding(
                  padding: const pw.EdgeInsets.only(top: 20, bottom: 20),
                  child: pw.Align(
                    alignment: pw.Alignment.center,
                    child: pw.Text('Vital Signs',
                        style:
                            pw.TextStyle(font: font, fontSize: titleFontSize)),
                  )),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text('Temperature: ${data[6]}',
                    style: pw.TextStyle(font: font, fontSize: fontSize)),
              ),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text('''Blood Pressure: Right Arm: ${data[7]}/${data[8]}
                                  Left Arm: ${data[9]}/${data[10]}''',
                    style: pw.TextStyle(font: font, fontSize: fontSize)),
              ),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text('Heart Rate: ${data[11]}',
                    style: pw.TextStyle(font: font, fontSize: fontSize)),
              ),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text('Respiratory Rate: ${data[12]}',
                    style: pw.TextStyle(font: font, fontSize: fontSize)),
              ),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text('Diminished: ${data[13]}',
                    style: pw.TextStyle(font: font, fontSize: fontSize)),
              ),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text('Oxygen Status: ${data[14]}',
                    style: pw.TextStyle(font: font, fontSize: fontSize)),
              ),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text('Shortness of Breath: ${data[15]}',
                    style: pw.TextStyle(font: font, fontSize: fontSize)),
              ),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text('Oxygen Use: ${data[16]}',
                    style: pw.TextStyle(font: font, fontSize: fontSize)),
              ),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text('Pain Level Today: ${data[17]} - ${data[18]}',
                    style: pw.TextStyle(font: font, fontSize: fontSize)),
              ),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                    'Pain Level Last Visit: ${data[19]} - ${data[20]}',
                    style: pw.TextStyle(font: font, fontSize: fontSize)),
              ),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text('Medication Plan: ${data[21]}',
                    style: pw.TextStyle(font: font, fontSize: fontSize)),
              ),
              pw.Padding(
                  padding: const pw.EdgeInsets.only(top: 50),
                  child: pw.Footer(
                      title: pw.Text('End of Document',
                          style: pw.TextStyle(
                              font: fontFooter, fontSize: footerFontSize))))
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PdfPreview(
        build: (context) => _generatePdf(widget.data),
      ),
    );
  }
}
