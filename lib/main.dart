import 'package:flutter/material.dart';

import 'package:learnable/utils/generate_material_color.dart';
import 'package:learnable/screens/landing.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learnable',
      theme: ThemeData(
          primarySwatch: generateMaterialColor(const Color(0xFF1F3C88)),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Spartan',
          textTheme: const TextTheme(
              headline1: TextStyle(
                  fontFamily: 'Spectral',
                  fontSize: 113,
                  fontWeight: FontWeight.w300),
              headline2: TextStyle(
                  fontFamily: 'Spectral',
                  fontSize: 71,
                  fontWeight: FontWeight.w300),
              headline3: TextStyle(
                  fontFamily: 'Spectral',
                  fontSize: 57,
                  fontWeight: FontWeight.w400),
              headline4: TextStyle(
                  fontFamily: 'Spectral',
                  fontSize: 40,
                  fontWeight: FontWeight.w400),
              headline5: TextStyle(
                  fontFamily: 'Spectral',
                  fontSize: 28,
                  fontWeight: FontWeight.w500),
              headline6: TextStyle(
                  fontFamily: 'Spectral',
                  fontSize: 24,
                  fontWeight: FontWeight.w500),
              subtitle1: TextStyle(
                  fontFamily: 'Spectral',
                  fontSize: 19,
                  fontWeight: FontWeight.w400),
              subtitle2: TextStyle(
                  fontFamily: 'Spectral',
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
              bodyText1: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              bodyText2: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              button: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              caption: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              overline: TextStyle(fontSize: 10, fontWeight: FontWeight.w400))),
      home: const Landing(),
      debugShowCheckedModeBanner: false,
    );
  }
}
