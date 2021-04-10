import 'package:dating_app/data/data.dart';
import 'package:dating_app/widgets/follower_user_card.dart';
import 'package:dating_app/widgets/followers_search_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:dating_app/resourses/colors.dart';

class Followers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.light,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Center(
            child: SvgPicture.asset('assets/images/appbar_arrow_left.svg',
                height: 20, width: 20),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Followers',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: AppColors.lightBronze,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FollowersSearchBox(),
            Expanded(
              child: context.mediaQuerySize.width < 500
                  ? ListView.builder(
                      itemBuilder: (context, i) {
                        return FollowerUserCard(
                          avatar: Lists.listTopUsers[i],
                          name: Lists.listTopUsersName[i],
                        );
                      },
                      itemCount: 5,
                    )
                  : SingleChildScrollView(
                      child: Wrap(
                          spacing: 10,
                          children: List.generate(5, (i) {
                            return FollowerUserCard(
                              avatar: Lists.listTopUsers[i],
                              name: Lists.listTopUsersName[i],
                            );
                          })),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
