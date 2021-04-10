import 'package:dating_app/resourses/colors.dart';
import 'package:flutter/material.dart';

class StandartTextOfFeedback extends StatelessWidget {
  final String text;

  const StandartTextOfFeedback({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.lightBlack,
          height: 1.48,
        ),
      ),
    );
  }
}