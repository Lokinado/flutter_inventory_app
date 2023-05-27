import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

double cameraHeight = 300;
double cameraWidth = 380;

late List<CameraDescription> _cameras;

void cameraCheck() async {
  _cameras = await availableCameras();
}

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraPage> {
  late CameraController controller;

  @override
  void initState() {
    super.initState();
    cameraCheck();
    controller = CameraController(
      _cameras[0],
      ResolutionPreset.low,
    );
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size rozmiar = MediaQuery.of(context).size;

    return SizedBox(
      height: rozmiar.height * 0.3,
      width: rozmiar.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: AspectRatio(
          aspectRatio: 0.1,
          child: CameraPreview(controller),
        ),
      ),
    );
  }
}

class CameraPagePrev extends StatefulWidget {
  const CameraPagePrev({Key? key}) : super(key: key);

  @override
  State<CameraPagePrev> createState() => _CameraPagePrevState();
}

class _CameraPagePrevState extends State<CameraPagePrev>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size rozmiar = MediaQuery.of(context).size;

    double textHeighOffset = rozmiar.height * 0.04;
    double elementsOffset = rozmiar.height * 0.023;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 50, 39, 1),
        toolbarHeight: 100,
        title: Container(
            alignment: Alignment.center,
            child: SizedBox(
              width: 200,
              child: Text(
                "Skanuj kody",
                style: TextStyle(
                  fontSize: elementsOffset*1.2,
                  fontWeight: FontWeight.w500
                ),
                textAlign: TextAlign.left,
              ),
            )),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            /// Separator
            SizedBox(
              height: elementsOffset,
            ),

            /// Kamera razem z polem komentarz
            Stack(
              children: [
                Container(
                  alignment: Alignment.bottomCenter,
                  height: rozmiar.height * 0.3 + textHeighOffset,
                  width: rozmiar.width * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.black38,
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    height: textHeighOffset,
                    child: Text("Kliknij, by wpisać kod ręcznie",
                        style: TextStyle(fontSize: elementsOffset*0.9)),
                  ),
                ),
                const CameraPage(),
              ],
            ),

            /// Separator
            SizedBox(
              height: elementsOffset,
            ),

            /// Podgląd ostatniego kodu + komentarz
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: elementsOffset * 3,
                  width: rozmiar.width * 0.5,
                  alignment: Alignment.centerLeft,
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(88, 178, 122, 1),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10))),
                  child: Container(
                    width: rozmiar.width * 0.5,
                    alignment: Alignment.center,
                    child: Text("WX-4212",
                        style: TextStyle(fontSize: elementsOffset*1.6, color: Colors.white)),
                  ),
                ),
                Container(
                  width: rozmiar.width * 0.3,
                  height: elementsOffset * 3,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(217, 217, 217, 1),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  child: Text(
                    "Dodaj komentarz",
                    style: TextStyle(
                      fontSize: elementsOffset*0.9,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),

            /// Separatro
            SizedBox(
              height: elementsOffset * 1.5,
            ),

            /// Wyświetlanie zeskanowanych przedmiotów
            Column(
              children: [
                Container(
                  width: rozmiar.width * 0.8,
                  height: 2.5 * elementsOffset,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(145, 198, 163, 1),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Container(
                    margin: EdgeInsets.only(left: elementsOffset),
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          width: rozmiar.width*0.55,
                          child: Text(
                            "Krzesło",
                            style: TextStyle(
                                fontSize: elementsOffset,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text(
                          "20/20",
                          style: TextStyle(
                              fontSize: elementsOffset,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Container(
                  width: rozmiar.width * 0.8,
                  height: 2.5 * elementsOffset,
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(145, 198, 163, 1),
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Container(
                    margin: EdgeInsets.only(left: elementsOffset),
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          width: rozmiar.width*0.55,
                          child: Text(
                            "Monitory",
                            style: TextStyle(
                                fontSize: elementsOffset,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text(
                          "20/20",
                          style: TextStyle(
                              fontSize: elementsOffset,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Container(
                  width: rozmiar.width * 0.8,
                  height: 2.5 * elementsOffset,
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(145, 198, 163, 1),
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Container(
                    margin: EdgeInsets.only(left: elementsOffset),
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          width: rozmiar.width*0.55,
                          child: Text(
                            "Biurka",
                            style: TextStyle(
                                fontSize: elementsOffset,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text(
                          "20/20",
                          style: TextStyle(
                              fontSize: elementsOffset,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),

            /// Separator
            SizedBox(
              height: elementsOffset * 1.5,
            ),

            /// Przyciski dolne na stronie
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: elementsOffset * 4,
                  width: rozmiar.width * 0.33,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(245, 123, 107, 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "Zakończ raport",
                    style: TextStyle(
                        fontSize: elementsOffset * 1.2,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  height: elementsOffset * 4,
                  width: rozmiar.width * 0.53,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(250, 185, 90, 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "Zmień pomieszczenie",
                    style: TextStyle(
                        fontSize: elementsOffset * 1.2,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
