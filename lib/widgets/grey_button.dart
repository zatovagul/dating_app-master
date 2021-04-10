import 'package:dating_app/resourses/colors.dart';
import 'package:dating_app/widgets/text_gradient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class GrayButton extends StatelessWidget {
  final String text;
  final GestureTapCallback onTap;

  GrayButton({this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Wrap(
        children: [
          Container(
              alignment: Alignment.center,
              width: context.mediaQuerySize.width < 500 ? context.mediaQuerySize.width * 0.52 : 205,
              height: 41,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: AppColors.lightBronze,
              ),
              child: TextGradient(text: text)),
        ],
      ),
    );
  }
}
