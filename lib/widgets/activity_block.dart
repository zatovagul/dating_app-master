import 'package:dating_app/screens/home_screen/all_feedbacks.dart';
import 'package:dating_app/resourses/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ActivityBlock extends StatefulWidget {
  @override
  _ActivityBlockState createState() => _ActivityBlockState();
}

class _ActivityBlockState extends State<ActivityBlock> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconWithCount(
          icon: SvgPicture.asset(
            'assets/images/like.svg',
          ),
          count: 112,
          colorText: AppColors.orange,
        ),
        SizedBox(width: 15),
        IconWithCount(
          icon: SvgPicture.asset(
            'assets/images/smile_neutral.svg',
          ),
          count: 34,
        ),
        SizedBox(width: 15),
        IconWithCount(
          icon: SvgPicture.asset(
            'assets/images/unlike.svg',
          ),
          count: 75,
        ),
        SizedBox(width: 15),
        IconWithCount(
          icon: SvgPicture.asset(
            'assets/images/comments.svg',
          ),
          count: 45,
        ),
      ],
    );
  }
}