import 'package:flutter/material.dart';

@immutable
class ReadyReportPage extends StatelessWidget {
   ReadyReportPage({Key? key, required this.numerRaportu, required this.data}) : super(key: key);

  final int numerRaportu;
  late String data;

  @override
  Widget build(BuildContext context) {

    // Pobranie informacji nt. wymiarów okna
    final Size rozmiar = MediaQuery.of(context).size;

    // Przygotowanie zmiennenych pomodniczych do rozmiarowania elementów
    double textHeighOffset = rozmiar.height * 0.04;
    double elementsOffset = rozmiar.height * 0.023;


    return Scaffold(

      /// Nagłówek aplikacji
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(0, 50, 39, 1),
        toolbarHeight: textHeighOffset * 2 + textHeighOffset,
        centerTitle: true,
        title: SizedBox(
          height: elementsOffset*3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Raport ${numerRaportu}",
                style: TextStyle(fontSize: textHeighOffset*0.75, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: elementsOffset*0.3,),
              Text(
                "${data}",
                style: TextStyle(fontSize: textHeighOffset*0.4, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(34),
            bottomRight: Radius.circular(34),
          ),
        ),
      ),

    );
  }
}

