import 'package:dating_app/screens/home_screen/profile_page.dart';
import 'package:dating_app/resourses/colors.dart';
import 'package:dating_app/widgets/subscribe_button_small.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class UserCard extends StatelessWidget {
  final String avatar;
  final int number;
  final String name;
  final String city;
  final int feedbacksCount;

  UserCard({this.avatar, this.number, this.name, this.city, this.feedbacksCount});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(Profile());
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        width: context.mediaQuerySize.width > 500 ? context.mediaQuerySize.width / 2 - 15 : context.mediaQuerySize.width,
        height: 178,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 84,
              width: 84,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: InkWell(
                      onTap: () {
                        Get.to(Profile());
                      },
                      child: Container(
                        height: 84,
                        width: 84,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(avatar),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 31,
                          width: 31,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          alignment: Alignment.lerp(Alignment.center, Alignment.bottomCenter, number != 1 ? 0.2 : 0),
                          height: 26,
                          width: 26,
                          decoration: number != 1
                              ? BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.black,
                                )
                              : BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      AppColors.orange,
                                      AppColors.mistake,
                                    ],
                                    stops: [0.2165, 0.6295],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                ),
                          child: number != 1
                              ? Text(
                                  '$number',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                )
                              : Icon(Icons.star, color: Colors.white, size: 15),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 25),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    SvgPicture.asset('assets/images/pin.svg'),
                    SizedBox(width: 4),
                    Text(
                      'United States, New York',
                      style: TextStyle(
                        color: Color(0xFF7B7B7B),
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 18),
                Text(
                  '$feedbacksCount feedbacks',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Gothic',
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: 17),
                SubscribeButtonSmall(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
