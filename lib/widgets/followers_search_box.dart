import 'package:dating_app/resourses/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
class FollowersSearchBox extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const FollowersSearchBox({this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.only(
        bottom: 10,
      ),
      width: context.mediaQuerySize.width,
      height: 46,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              cursorWidth: 0,
              style: TextStyle(
                color: AppColors.lightBlack,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                filled: false,
                isDense: true,
                fillColor: Colors.white,
                hintText: 'Search',
                hintStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.grey,
                  height: 1,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(7.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(7.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(7.0),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(7.0),
                ),
              ),
            ),
          ),
          SvgPicture.asset('assets/images/search_followers.svg'),
        ],
      ),
    );
  }
}
