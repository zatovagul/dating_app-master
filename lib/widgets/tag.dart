import 'package:dating_app/resourses/colors.dart';
import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  final String tag;

  Tag({this.tag});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      alignment: Alignment.center,
      height: 27,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: AppColors.orange,
        ),
      ),
      child: Text(
        '#${tag.toUpperCase()}',
        style: TextStyle(
          color: AppColors.orange,
          fontSize: 11,
          fontWeight: FontWeight.w500,
          fontFamily: 'Gothic',
        ),
      ),
    );
  }
}