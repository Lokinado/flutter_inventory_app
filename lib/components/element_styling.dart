import 'package:flutter/material.dart';

//  Parametr odpowiedzialny za krzywiznę boków guzików
//  Przy zaimporotowaniu, ta zmienna zostaje zaimportowana domyślnie
//  i można późńiej jej wartość nadpisać
double roundness  = 10;

// Zaokrąglony, Szary, guzik
var leftTextActive = ElevatedButton.styleFrom(
    backgroundColor: Colors.white60,
    foregroundColor: Colors.black,
    shadowColor: Colors.black,
    alignment: const Alignment(-0.9, 0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(roundness),
    ));

var leftTextNotActive = ElevatedButton.styleFrom(
    backgroundColor: Colors.white60,
    foregroundColor: Colors.black45,
    shadowColor: Colors.black,
    alignment: const Alignment(-0.9, 0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(roundness),
    ));

var centerTextActive = ElevatedButton.styleFrom(
    backgroundColor: Colors.white60,
    foregroundColor: Colors.black,
    shadowColor: Colors.black,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(roundness),
    ));

var centerTextNotActive = ElevatedButton.styleFrom(
    backgroundColor: Colors.white60,
    foregroundColor: Colors.black45,
    shadowColor: Colors.black,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(roundness),
    ));