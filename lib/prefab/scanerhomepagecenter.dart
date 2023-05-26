import 'package:flutter/material.dart';
import 'package:inventory_app/components/topbodysection.dart';
import 'package:inventory_app/prefab/place_choose_button.dart';

class _CenterScanHomePageState extends State<CenterScanHomePage>
    with AutomaticKeepAliveClientMixin<CenterScanHomePage>{
  double roundness = 75;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var elemWidth = widget.size.width * 0.9;
    return Container(
        height: widget.size.height * 0.7,
        color: const Color.fromRGBO(0, 50, 39, 1),
        child: Container(
          width: widget.size.width,
          height: widget.size.height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight:
              Radius.circular(widget.location == Location.right ? roundness : 0),
              topLeft:
              Radius.circular(widget.location == Location.left ? roundness : 0),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              /*
              PlaceButton(
                onTap: () {},
                locationHorizontally: 0.0,
                locationVertically: 0.0,
              ),
              PlaceButton(
                onTap: () {},
                locationHorizontally: 0.0,
                locationVertically: 0.0,
              ),
              PlaceButton(
                onTap: () {},
                locationHorizontally: 0.0,
                locationVertically: 0.0,
              )*/
            ],
          ),
        ));
  }
}

class CenterScanHomePage extends StatefulWidget {
  CenterScanHomePage({Key? key, required this.size, required this.location})
      : super(key: key);

  final Size size;
  final Location location;
  @override
  State<CenterScanHomePage> createState() => _CenterScanHomePageState();
}
