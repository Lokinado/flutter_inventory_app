import 'package:flutter/material.dart';
class TopBodySection extends StatelessWidget {
  const TopBodySection({
    required Key key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context){
    // It will provide us total height and width of our screen
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        SizedBox(
          height: size.height * 0.16,
          child: Stack(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(
                  left: 35,
                  bottom: 20,
                ),
                height: size.height * 0.16,
                decoration: 
                const BoxDecoration(
                  color: Color.fromRGBO(0, 50, 39, 1),
                  borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(75),
                  ),
                ),
                child: Row(
                  children: const <Widget>[
                    Text(
                      'Skanowanie',
                      style: TextStyle(fontSize: 45, color: Colors.white, fontFamily: 'Montserrat',),
                      ),
                  ],
                ),
              ),
            ],
          )
        ), 
        // Add a new Container with a red background color here
        
      ],
    );
  }
}