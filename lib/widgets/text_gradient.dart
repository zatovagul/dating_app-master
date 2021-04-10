import 'package:dating_app/resourses/colors.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';

class TextGradient extends StatelessWidget {
  final String text;

  TextGradient({this.text});

  @override
  Widget build(BuildContext context) {
    return GradientText(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1,
      ),
      gradient: LinearGradient(
        colors: [
          AppColors.orange,
          AppColors.mistake,
        ],
        stops: [0.3, 1],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
    );
  }
}