import 'package:dating_app/resourses/colors.dart';
import 'package:dating_app/widgets/text_gradient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class SubscribeButton extends StatelessWidget {
  final String text;

  SubscribeButton({
    this.text,
  });

  var isSubscribed = false.obs;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        isSubscribed.value = !isSubscribed.value;
      },
      child: Wrap(
        children: [
          Obx(
                () => Container(
              alignment: Alignment.center,
              width: context.mediaQuerySize.width < 500 ? context.mediaQuerySize.width * 0.52 : context.mediaQuerySize.width / 3.65,
              height: 41,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                gradient: LinearGradient(
                  colors: !isSubscribed.value
                      ? [
                    AppColors.orange,
                    AppColors.mistake,
                  ]
                      : [
                    AppColors.lightBronze,
                    AppColors.lightBronze,
                  ],
                  stops: [0, 1],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Obx(
                    () => isSubscribed.value
                    ? TextGradient(
                  text: 'Unsubscribe',
                )
                    : Text(
                  '+ Subscribe',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    height: 1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}