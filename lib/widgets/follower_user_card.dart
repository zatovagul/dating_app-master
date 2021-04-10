import 'package:dating_app/screens/home_screen/profile_page.dart';
import 'package:dating_app/resourses/colors.dart';
import 'package:dating_app/widgets/subscribe_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
class FollowerUserCard extends StatelessWidget {
  final String avatar;
  final String name;
  final String city;

  FollowerUserCard({this.avatar, this.name, this.city});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 10),
      width: context.mediaQuerySize.width > 500 ? context.mediaQuerySize.width / 2 - 15 : context.mediaQuerySize.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Get.to(Profile());
            },
            child: Container(
              height: 84,
              width: 84,
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
              SizedBox(height: 17),
              SubscribeButton(),
            ],
          ),
        ],
      ),
    );
  }
}