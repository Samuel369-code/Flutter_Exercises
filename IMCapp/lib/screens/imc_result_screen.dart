import 'package:flutter/material.dart';
import 'package:imcapp/core/app_color.dart';
import 'package:imcapp/core/text_styles.dart';

class ImcResultScreen extends StatelessWidget {
  final double height;
  final int weight;

  const ImcResultScreen({super.key, required this.height, required this.weight});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.backgrounnd,
      appBar: toolbarResult(),
      body: bodyResult(),
    );
  }

  Padding bodyResult() {
    double fixedHeight = height/100;
    double imcResult = weight/(fixedHeight * fixedHeight);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tu resultado",
            style: TextStyle(
              fontSize: 38,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 32,
                bottom: 32,
              ),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.backgroundCommponent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Normal", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),),
                    Text(imcResult.toStringAsFixed(2),
                        style: TextStyle(fontSize: 56, color: Colors.white,
                        fontWeight: FontWeight.bold)),
                    Text("Descripción", style: TextStyles.bodyText)
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 60,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                backgroundColor: WidgetStateProperty.all(AppColors.primary),
              ),
              child: Text("Finalizar", style: TextStyles.bodyText),
            ),
          ),
        ],
      ),
    );
  }

  AppBar toolbarResult() {
    return AppBar(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      title: Text("Resultado"),
    );
  }
}
