// Elementy systemowe
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:list_picker/list_picker.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:scan/scan.dart';

// Linki do innych plików projekcie
import 'package:inventory_app/components/element_styling.dart';
import 'package:inventory_app/pages/scanner/finish_report.dart';
import 'package:inventory_app/pages/scanner/change_place.dart';


class DemoCamPage extends StatefulWidget {
  const DemoCamPage({
    Key? key,
    required this.budynek,
    required this.pietro,
    required this.pomieszczenie,
    required this.listaBudynkow,
    required this.listaPieter,
    required this.listaPomieszczen,
  }) : super(key: key);

late List<CameraDescription> _cameras;

  @override
  State<DemoCamPage> createState() => _DemoCamPageState();
}

class CameraPage extends StatefulWidget{
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraAppState();
}

  //
  //  Funkcje używane w tym pliku
  //
  
  /// Widget wyświetlający działąjący skanner
  Widget camera() => Container(
    height: rozmiar.height * 0.3 - 6,
    width: rozmiar.width * 0.8,
    child: ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20)
      ),
      child: ScanView(

        controller: controller,
        scanAreaScale: .8,
        scanLineColor: Colors.green.shade400,
        onCapture: (data) async {
          setState(() {
            scannedValue = data;
          });
          controller.pause(); /// Kod wstrzymujcy dziaanie kamery

          /// ... sprawdź czy element jest w bazie i ...
          var czyWBazie =
          await szukajAzZnajdziesz(_textEditingController.text.toString());

          /// ... w zależności od odopowiedzi odznacz i pokaż odpowiedni komunikat
          if (czyWBazie)
          {
            showTopSnackBar(
                Overlay.of(context),
                const CustomSnackBar.success(
                  message: 'Dodano element do zeskanowanych przedmiotów',
                ),
                animationDuration: const Duration(microseconds: 500));
          } else {
            showTopSnackBar(
                Overlay.of(context),
                const CustomSnackBar.error(
                  message: 'Elementu nie ma w bazie',
                ),
                animationDuration: const Duration(microseconds: 500));
          }
          await Future.delayed(const Duration(seconds: 1));
          controller.resume();
        },
      ),
    ),
  );

  /// Początkowa inicjalizacja ekranu
  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  /// Usuwanie stanu ekranu po wyjściu
  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return MaterialApp(
      home: CameraPreview(controller),
    );
  }

}
