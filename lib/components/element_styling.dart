import 'package:flutter/material.dart';

//  Parametr odpowiedzialny za krzywiznę boków guzików
//  Przy zaimporotowaniu, ta zmienna zostaje zaimportowana domyślnie
//  i można późńiej jej wartość nadpisać
double roundness  = 20;

// Zaokrąglony, Szary, guzik
var leftTextActive = ElevatedButton.styleFrom(
    backgroundColor: Colors.white60,
    foregroundColor: Colors.black,
    //shadowColor: Colors.black,
    alignment: const Alignment(-0.9, 0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(roundness),
    ));

var leftTextNotActive = ElevatedButton.styleFrom(
    backgroundColor: Colors.white60,
    foregroundColor: Colors.black45,
    //shadowColor: Colors.black,
    alignment: const Alignment(-0.9, 0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(roundness),
    ));



var centerTextActive = ElevatedButton.styleFrom(
    backgroundColor: Colors.green,
    foregroundColor: Colors.black,
    //shadowColor: Colors.black,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(roundness),
    ));

var centerTextNotActive = ElevatedButton.styleFrom(
    backgroundColor: Colors.white60,
    foregroundColor: Colors.black45,
    //shadowColor: Colors.black,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(roundness),
    ));



var spacedGreenButtonActive = ElevatedButton.styleFrom(
    backgroundColor: Color.fromRGBO(145, 198, 163, 1),
    foregroundColor: Colors.black,
    alignment: const Alignment(-0.9, 0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(roundness),
    ));

var spacedGreenButtonNActive = ElevatedButton.styleFrom(
    backgroundColor: Color.fromRGBO(248, 204, 146, 1),
    foregroundColor: Colors.black,
    alignment: const Alignment(-0.9, 0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(roundness),
    ));


var bottomButtonRedActive = ElevatedButton.styleFrom(
    backgroundColor: Color.fromRGBO(245, 123, 107, 1),
    foregroundColor: Colors.black,
    alignment: const Alignment(0, 0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ));
/*
var spacedGreenButtonNActive = ElevatedButton.styleFrom(
    backgroundColor: Color.fromRGBO(248, 204, 146, 1),
    foregroundColor: Colors.black,
    alignment: const Alignment(-0.9, 0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(roundness),
    ));
 */