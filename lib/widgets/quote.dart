import 'package:dating_app/resourses/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Quote extends StatelessWidget {
  final String text;

  Quote({this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: SvgPicture.asset('assets/images/quote_outlined.svg'),
          ),
          Container(
            width: context.mediaQuerySize.width * 0.73,
            child: Text(
              text,
              style: TextStyle(
                color: AppColors.lightBlack.withOpacity(0.5),
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: 'Gothic',
                height: 1.48,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}