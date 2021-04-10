import 'package:dating_app/resourses/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconWithText extends StatelessWidget {
  final String icon;
  final String text;
  final GestureTapCallback onTap;
  final double paddingBottom;
  final bool orangeText;

  IconWithText(
      {this.icon, this.text, this.onTap, this.paddingBottom, this.orangeText});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: SvgPicture.asset(icon),
      title: Text(
        text,
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: orangeText != null && orangeText == true
                ? AppColors.orange
                : AppColors.black,
            fontFamily: 'Graphic'),
      ),
    );
  }
}