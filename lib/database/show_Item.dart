import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:inventory_app/components/color_palette.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:barcode/barcode.dart';
import 'package:barcode_widget/barcode_widget.dart';

class ShowItem extends StatelessWidget {
  final String name;
  final String roomId;
  final String floorId;
  final String itemtype;
  final String comment;

  ShowItem({
    Key? key,
    required this.name,
    required this.roomId,
    required this.floorId,
    required this.itemtype,
    required this.comment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 50, 39, 1),
        title: Text('Szczegóły $name'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Column(
              children: [
                Text(
                  'Barcode',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey,
                      width: 2,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                BarcodeWidget(
                  barcode: Barcode
                      .code128(), // Wybierz rodzaj kodu kreskowego, np. Code128
                  data: name, // Dane do wygenerowania kodu kreskowego
                  width: 200,
                  height: 100,
                  drawText:
                  false, // Ustawienie na true, jeśli chcesz wyświetlić tekst obok kodu kreskowego
                ),
              ],
            ),
          ),
          PdfGenerator(name: name, barcode: name),
          PrintPdf(name: name, barcode: name),
          ShowDetails(comment: comment)
        ],
      ),
    );
  }
}

class PdfGenerator extends StatelessWidget {
  final String name;
  final String barcode;

  const PdfGenerator({
    Key? key,
    required this.name,
    required this.barcode,
  }) : super(key: key);

  Future<void> generatePdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Text('Nazwa: $name'),
                pw.SizedBox(height: 20),
                pw.BarcodeWidget(
                  barcode: Barcode.code128(),
                  data: barcode,
                  width: 200,
                  height: 80,
                  drawText: false,
                ),
              ],
            ),
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final filePath = '${output.path}/details.pdf';
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    // Open the PDF file with the default PDF viewer
    await Printing.sharePdf(
        bytes: await file.readAsBytes(), filename: 'kod' + name + '.pdf');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton.icon(
        onPressed: () async {
          await generatePdf();
        },
        icon: Icon(Icons.picture_as_pdf),
        label: Text(
          'Wygeneruj plik PDF',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
      ),
    );
  }
}

class PrintPdf extends StatelessWidget {
  final String name;
  final String barcode;

  const PrintPdf({
    Key? key,
    required this.name,
    required this.barcode,
  }) : super(key: key);

  Future<void> printPdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Text('Nazwa: $name'),
                pw.SizedBox(height: 20),
                pw.BarcodeWidget(
                  barcode: Barcode.code128(),
                  data: barcode,
                  width: 200,
                  height: 80,
                  drawText: false,
                ),
              ],
            ),
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final filePath = '${output.path}/details.pdf';
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    // Print the PDF file
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async {
        final bytes = await file.readAsBytes();
        return bytes.buffer.asUint8List();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton.icon(
        onPressed: () async {
          await printPdf();
        },
        icon: Icon(Icons.print),
        label: Text(
          'Drukuj ',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
      ),
    );
  }
}

class ShowDetails extends StatelessWidget {
  final String comment;

  const ShowDetails({
    Key? key,
    required this.comment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: Icon(Icons.info_rounded, color: Colors.white),
          ),
          Text(
            "Komentarz",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Flexible(
            // Zmiana na Flexible dla treści komentarza
            child: Center(
              child: Text(
                CheckComment(comment),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String CheckComment(String comment) {
  if (comment.length < 1) {
    return "Brak komentarza";
  }
  return comment;
}