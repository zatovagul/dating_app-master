import 'package:dating_app/states.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dating_app/resourses/colors.dart';


class HomeMenu extends StatefulWidget {
  final PageController pageController;
  HomeMenu(this.pageController);
  @override
  _HomeMenuState createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  AppStates appStates = Get.put(AppStates());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBronze,
      appBar: AppBar(
        leading: IconButton(
          highlightColor: Colors.white,
          onPressed: () {
            Get.back();
          },
          icon: SvgPicture.asset(
            'assets/images/cross.svg',
            height: 20,
            width: 20,
          ),
        ),
        elevation: 0,
        backgroundColor: AppColors.lightBronze,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            onTap: () {
              setState(() {
                Get.back();
                widget.pageController.jumpToPage(0);
                appStates.firstPages.value = 0;
              });
            },
            title: Text(
              'All feedbacks',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColors.black,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              setState(() {
                Get.back();
                widget.pageController.jumpToPage(0);
                appStates.firstPages.value = 1;
              });
            },
            title: Text(
              'Top users',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColors.black,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              setState(() {
                Get.back();
                widget.pageController.jumpToPage(0);
                appStates.firstPages.value = 2;
              });
            },
            title: Text(
              'Last comments',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColors.black,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              setState(() {
                Get.back();
                widget.pageController.jumpToPage(1);
              });
            },
            title: Text(
              'Global search',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColors.black,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              setState(() {
                Get.back();
                widget.pageController.jumpToPage(3);
              });
            },
            title: Text(
              'Track accounts',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColors.black,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              setState(() {
                Get.back();
                widget.pageController.jumpToPage(0);
                appStates.firstPages.value = 3;
              });
            },
            title: Text(
              'Saved drafts',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColors.black,
                fontSize: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
