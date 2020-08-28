import 'package:flutter/material.dart';
import 'price_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF414D6F),
        scaffoldBackgroundColor: Color(0xFF343F61),
      ),
      home: PriceScreen(),
    );
  }
}
