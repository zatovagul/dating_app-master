import 'package:dating_app/resourses/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MoreText extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isMore;
  MoreText({
    Key key,
    @required this.onPressed,
    this.isMore,
    this.text,
  }) : super(key: key);

  final Shader linearGradient = LinearGradient(
    colors: <Color>[AppColors.orange, AppColors.mistake],
    stops: [0.2165, 0.6295],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  ).createShader(Rect.fromLTWH(0, 0, 100, 50));

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              foreground: Paint()..shader = linearGradient,
              height: 1.48,
            ),
          ),
          SizedBox(width: 5),
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: isMore
                ? Transform.rotate(
                    angle: 3.14,
                    child: SvgPicture.asset('assets/images/more_arrow_down.svg'),
                  )
                : SvgPicture.asset('assets/images/more_arrow_down.svg'),
          )
        ],
      ),
    );
  }
}
