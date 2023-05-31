import 'package:flutter/material.dart';
import 'package:inventory_app/components/color_palette.dart';

@immutable // zalecane dla wydajności - podpowiedz ide
class ReadyReportPage extends StatelessWidget {
   ReadyReportPage({Key? key, required this.numerRaportu, required this.data}) : super(key: key);

  final int numerRaportu; /// Numer raportu przekazany z zewnątrz
  late String data; /// Data raportu przekazana z zewnątrz

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: rozmiar.height*0.64,
          ),
          Container(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop("reset");
              },
              child: Container(
                height: elementsOffset * 4,
                width: rozmiar.width * 0.9,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: zielonySlabaSGGW,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Powrót na stronę główną",
                  style: TextStyle(
                      fontSize: elementsOffset,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      )

    );
  }
}

