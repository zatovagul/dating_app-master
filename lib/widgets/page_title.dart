import 'package:dating_app/resourses/colors.dart';
import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  final String title;

  PageTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Text(
        title,
        textAlign: TextAlign.start,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColors.lightBlack,
          fontSize: 24,
        ),
      ),
    );
  }
}
