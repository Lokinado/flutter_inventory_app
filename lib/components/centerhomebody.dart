import 'package:flutter/material.dart';
import 'package:inventory_app/pages/scanner/scanner_page.dart';

class CenterBodySection extends StatelessWidget {
  const CenterBodySection({Key? key, required this.size}) : super(key: key);

  final Size size;

  Widget buildCircle({required String text, required double top,
    required double right, required double width}) {
    return Positioned(
      top: top,
      right: right,
      child: Stack(
        children: <Widget>[
          DecoratedBox(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(0, 50, 39, 1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: SizedBox(
              width: width,
              height: width/6,
              child: Center(
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget RoundedButton({ required context}){
    return  Positioned(
        bottom: size.height*0.1, 
        left: (size.width - 382) / 2,
        child: SizedBox(
          width: 382,
          height: 70,
          child: ElevatedButton(
            onPressed: (){
              Navigator.push( context,
                MaterialPageRoute(builder: (context) => const CameraPage()), );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(228, 6, 139, 57),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),  child: const Text(
            'Rozpocznij skanowanie', style: TextStyle(color: Colors.white,
            fontWeight: FontWeight.bold, fontSize: 25,
          ),
          ),
          ),
        ),
        );
}

  @override
  Widget build(BuildContext context) {
    var elemWidth = size.width*0.9;
    return Container(
      height: size.height*0.7,
      color: const Color.fromRGBO(0, 50, 39, 1),
      child: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(75),
          ),
        ),
        child: Stack(
          children: <Widget>[
            //buildCircle(text: '${34}     |     Budynek', top: 110, right: 5, width: elemWidth),
            //buildCircle(text: '${3}     |     Piętro', top: 190, right: 5,  width: elemWidth),
            //buildCircle(text: '${32}      |     Pomieszczenie', top: 270, right: 5,  width: elemWidth),
            RoundedButton(context: context),
            
          ],
        ),
      )
    );

  }
}
