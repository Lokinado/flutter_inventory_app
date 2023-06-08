import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

class ShowItem extends StatelessWidget {
  final String name;
  final String roomId;
  final String floorId;
  
  final String itemId;
  final String comment;
  final String barcode;

  ShowItem({
    Key? key,
    required this.name,
    required this.roomId,
    required this.floorId,
    required this.itemId,
    required this.comment,
    required this.barcode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: const Color.fromRGBO(0, 50, 39, 1),
      title: Text('Szczegóły  $name'),
    ),
    body: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: SizedBox(
            height: 100,
            width: 240,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey,
                  width: 2,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  'Nazwa: $name \nBarcode: $barcode',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.grey,
                        blurRadius: 0.1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        PdfGenerator(name: name, barcode: barcode),
        PrintPdf(name: name, barcode: barcode),
      ],
    ),
  );
}

class PdfGenerator extends StatelessWidget {
  final String name;
  final String barcode;

  const PdfGenerator({
    Key? key,
    required this.name,
    required this.barcode,
  }) : super(key: key);

  Future<Uint8List> generatePdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text('Nazwa: $name \nBarcode: $barcode'),
          );
        },
      ),
    );

    return pdf.save();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final pdfBytes = await generatePdf();
        Printing.sharePdf(
          bytes: pdfBytes,
          filename: 'details.pdf',
        );
      },
      child: Text('Wygeneruj plik PDF'),
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
            child: pw.Text('Nazwa: $name \nBarcode: $barcode'),
          );
        },
      ),
    );

    final pdfBytes = pdf.save();

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdfBytes,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        printPdf();
      },
      child: Text('Drukuj jako plik PDF'),
    );
  }
}