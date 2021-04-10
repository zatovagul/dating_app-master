import 'package:dating_app/resourses/colors.dart';
import 'package:dating_app/widgets/text_gradient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubscribeButtonSmall extends StatelessWidget {
  final String text;

  SubscribeButtonSmall({
    this.text,
  });

  final isSubscribed = false.obs;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Obx(
        () => SizedBox(
          height: 34,
          child: FlatButton(
            padding: EdgeInsets.zero,
            onPressed: () => isSubscribed.value = !isSubscribed.value,
            color: Colors.transparent,
            highlightColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
            child: Container(
              width: context.mediaQuerySize.width < 500 ? context.mediaQuerySize.width * 0.52 : context.mediaQuerySize.width / 3.65,
              height: 34,
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
                    ? Center(
                        child: TextGradient(
                          text: 'Unsubscribe',
                        ),
                      )
                    : Center(
                        child: Text(
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
          ),
        ),
      ),
    );
  }
}
