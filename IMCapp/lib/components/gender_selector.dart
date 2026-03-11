import 'package:flutter/material.dart';
import 'package:imcapp/core/app_color.dart';
import 'package:imcapp/core/text_styles.dart';

class GenderSelector extends StatefulWidget {
  const GenderSelector({super.key});

  @override
  State<GenderSelector> createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderSelector> {
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //Hombre
        Expanded(
          child: GestureDetector(
            onTap: (){
              setState(() {
                selectedGender = "Hombre";
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: selectedGender == "Hombre" ? AppColors.backgroundComponentSelected
                  : AppColors.backgroundCommponent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Image.asset("assets/images/genero-masculino.png", height: 100),
                      SizedBox(height: 8),
                      Text("Hombre".toUpperCase(), style: TextStyles.bodyText,)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        //Mujer
        Expanded(
          child: GestureDetector(
            onTap: (){
              setState(() {
                selectedGender = "Mujer";
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 16, right: 16, left: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: selectedGender == "Mujer" ? AppColors.backgroundComponentSelected
                  : AppColors.backgroundCommponent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Image.asset("assets/images/signo-de-genero-femenino.png", height: 100),
                      Text("Mujer".toUpperCase(), style: TextStyles.bodyText, ),
                      SizedBox(height: 8,)
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
