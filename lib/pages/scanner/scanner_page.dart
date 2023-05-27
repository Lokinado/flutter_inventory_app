import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

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
    controller = CameraController(_cameras[0], ResolutionPreset.low, );
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

    return Container(
      height: 220,
      width: rozmiar.width*0.7,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: AspectRatio(
          aspectRatio: 1,
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

class _CameraPagePrevState extends State<CameraPagePrev> with SingleTickerProviderStateMixin {
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 50, 39, 1),
        toolbarHeight: 100,
        title: Container(
            alignment: Alignment.center,
            child: const SizedBox(
              width: 180,
              child: Text(
                "Skanuj kody",
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
            SizedBox(height: 20,),
            Container(
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    height: 260,
                    width: rozmiar.width*0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black38,
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      child: Text("Jakiś tekst"),
                    ),
                  ),
                  Container(
                    child: CameraPage(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

