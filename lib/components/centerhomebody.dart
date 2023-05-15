import 'package:flutter/material.dart';

class CenterBodySection extends StatelessWidget {
  const CenterBodySection({Key? key}) : super(key: key);

  Widget buildCircle({required String text, required double top, required double right}) {
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
              width: 382,
              height: 70,
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

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.70,
      color: const Color.fromRGBO(0, 50, 39, 1),
      child: Positioned(
        top: size.height * 0.20 - 27,
        left: 0,
        child: Container(
          width: size.width,
          height: size.height - size.height * 0.20 + 27,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(75),
            ),
          ),
          child: Stack(
            children: <Widget>[
              buildCircle(text: ' ${34}     |     Budynek', top: 110, right: 5),
              buildCircle(text: ' ${3}     |     Piętro', top: 190, right: 5),
              buildCircle(text: ' ${32}      |     Pomieszczenie', top: 270, right: 5),
              Positioned(
                bottom: 60,
                left: (size.width - 382) / 2,
                child: SizedBox(
                  width: 382,
                  height: 70,
                  child: ElevatedButton(
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(228, 6, 139, 57),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Rozpocznij skanowanie',
                      style: TextStyle(
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
        ),
      ),
    );
  }
}
