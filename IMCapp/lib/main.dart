import 'package:flutter/material.dart';
import 'package:imcapp/screens/imc_home_screen.dart';

import 'core/app_color.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(backgroundColor:
          AppColors.primary,
          foregroundColor: Colors.white,
          title: Text("IMC Calculator App")), // AppBar
        backgroundColor: AppColors.backgrounnd,
        body: ImcHomeScreen(),
      ),
    );
  }
}
