import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:holy_trinity_healthcare/constants/app_constants.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

import '../model/user.dart';
import '../utils/utils.dart';

class PdfViewer extends StatefulWidget {
  const PdfViewer(
      {super.key, required this.data, required this.form, required this.user});
  final List<String> data;
  final String form;

  final User user;

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  String form = '';

  @override
  void initState() {
    super.initState();
    form = widget.form;
  }

  //function to generate pdf. styling
  Future<Uint8List> _generatePdf(List<String> data) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.abhayaLibreRegular();
    final imageByteData = await rootBundle.load(AppConstants.logo);
    final imageUint8List = imageByteData.buffer
        .asUint8List(imageByteData.offsetInBytes, imageByteData.lengthInBytes);

    double fontSize = 14;
    double titleFontSize = 16;

    pw.Padding divisionWidget() => pw.Padding(
          padding: const pw.EdgeInsets.only(top: 10, bottom: 10),
          child: pw.Container(
              height: 2,
              decoration: const pw.BoxDecoration(color: PdfColor.fromInt(20))),
        );

    final image = pw.MemoryImage(imageUint8List);

    pw.Column basicDetails() => pw.Column(children: [
          pw.Row(children: [
            pw.Image(image, height: 80, width: 80, dpi: 200.0),
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
                            style:
                                pw.TextStyle(font: font, fontSize: fontSize)),
                      ),
                      pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text('Address: ${data[5]}',
                            style:
                                pw.TextStyle(font: font, fontSize: fontSize)),
                      ),
                      pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text(
                            'Date: ${Utils.formatDate(DateTime.now(), true)}',
                            style:
                                pw.TextStyle(font: font, fontSize: fontSize)),
                      ),
                    ]),
                pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Text('Birthday: ${data[3]}',
                            style:
                                pw.TextStyle(font: font, fontSize: fontSize)),
                      ),
                      pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Text('Age: ${data[4]} years old.',
                            style:
                                pw.TextStyle(font: font, fontSize: fontSize)),
                      ),
                      pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text('',
                            style:
                                pw.TextStyle(font: font, fontSize: fontSize)),
                      ),
                    ])
              ]),
          divisionWidget(),
        ]);

    pw.Align textWidget(String str, bool isCenter) {
      return pw.Align(
        alignment: !isCenter ? pw.Alignment.centerLeft : pw.Alignment.center,
        child: pw.Text(str,
            style: pw.TextStyle(
                font: font, fontSize: !isCenter ? fontSize : titleFontSize)),
      );
    }

    pw.Padding footer() => pw.Padding(
        padding: const pw.EdgeInsets.only(top: 50),
        child: pw.Column(children: [
          pw.Container(height: 30),
          pw.Footer(
              title: pw.Column(children: [
            textWidget(
                '${widget.user.firstName.toUpperCase()} ${widget.user.lastName.toUpperCase()}',
                true),
            pw.Text('${widget.user.empId}/${widget.user.position}',
                style: pw.TextStyle(font: font, fontSize: 10))
          ]))
        ]));
    pw.Column vitalSignsData() => pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.start,
          children: [
            basicDetails(),
            pw.Padding(
                padding: const pw.EdgeInsets.only(top: 20, bottom: 20),
                child: textWidget('Vital Signs', true)),
            textWidget('Temperature: ${data[6]}', false),
            textWidget('''Blood Pressure: Right Arm: ${data[7]}/${data[8]}
                                  Left Arm: ${data[9]}/${data[10]}''', false),
            textWidget('Heart Rate: ${data[11]}', false),
            textWidget('Respiratory Rate: ${data[12]}', false),
            textWidget('Diminished: ${data[13]}', false),
            textWidget('Oxygen Status: ${data[14]}', false),
            textWidget('Shortness of Breath: ${data[15]}', false),
            textWidget('Oxygen Use: ${data[16]}', false),
            textWidget('Pain Level Today: ${data[17]} - ${data[18]}', false),
            textWidget(
                'Pain Level Last Visit: ${data[19]} - ${data[20]}', false),
            textWidget('Medication Plan: ${data[21]}', false),
            footer()
          ],
        );

    pw.Column neurological() =>
        pw.Column(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
          basicDetails(),
          pw.Padding(
              padding: const pw.EdgeInsets.only(top: 10, bottom: 20),
              child: textWidget('Neurological', true)),
          textWidget('''${AppConstants.memoryIssuesPlaceholder}:
           • ${data[6]}''', false),
          textWidget('''${AppConstants.psychologicalIssues}:
           • ${data[7]}''', false),
          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                textWidget('''${AppConstants.cva}:
           • ${data[8]} / ${data[9]}''', false),
                textWidget('''${AppConstants.sinceWhen}
           • ${data[10]}''', false),
              ]),
          textWidget('''${AppConstants.mobility}:
           • ${data[11]}''', false),
          textWidget('''${AppConstants.adl}:
           • ${data[12]}''', false),
          textWidget('''${AppConstants.riskFall}:
           • ${data[13]}''', false),
          textWidget('''${AppConstants.dme}:
           • ${data[14]}''', false),
          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                textWidget('''${AppConstants.dmeStatus}:
           • ${data[15]}''', false),
                data[15] == AppConstants.dmeStatusList[1]
                    ? (textWidget('''${AppConstants.reason}:
           • ${data[16]}''', false))
                    : pw.Container(),
              ]),
          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                textWidget('''${AppConstants.cardiacIssues}:
           • ${data[17]}''', false),
                textWidget('''${AppConstants.peripheralPulses}:
           • ${data[18]}''', false),
              ]),
          textWidget('''${AppConstants.edema}:
           • ${data[19]}''', false),
          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                textWidget('''${AppConstants.diuretic}:
           • ${data[20]}''', false),
                textWidget('''${AppConstants.ivd}
           • ${data[21]}''', false),
              ]),
          footer()
        ]);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return (form == AppConstants.vitalSign)
              ? vitalSignsData()
              : neurological();
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
