import 'package:dating_app/data/data.dart';
import 'package:dating_app/screens/home_screen/all_feedbacks.dart';
import 'package:dating_app/states.dart';
import 'package:dating_app/widgets/bordered_container.dart';
import 'package:dating_app/widgets/feedback_mini.dart';
import 'package:dating_app/widgets/grey_button.dart';
import 'package:dating_app/widgets/social_network_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:dating_app/resourses/colors.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  void initState() {
    super.initState();
    box.put('isYoutube', true);
    box.put('isFacebook', true);
    box.put('isTwitter', true);
    box.put('isInstagram', true);
  }

  AppStates appStates = Get.put(AppStates());
  var box = Hive.box('appMetrics');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.light,
      body: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 7, bottom: 0),
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onPanDown: (_) {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: ListView(
                  children: [
                    BorderedContainer(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/top_user1.png'),
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  box.get('login') != null
                                      ? '@${box.get('login')}'
                                      : '@petttter',
                                  style: TextStyle(
                                    color: AppColors.orange,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 7),
                                Text(
                                  box.get('firstName') != null
                                      ? '${box.get('firstName')} ${box.get('lastName')}'
                                      : 'Peter Rollins',
                                  style: TextStyle(
                                    color: AppColors.lightBlack,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 7),
                                Text(
                                  box.get('whenJoined') != null
                                      ? 'Joined in ${box.get('whenJoined')}'
                                      : 'Joined in March 2020',
                                  style: TextStyle(
                                    color: AppColors.grey,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 20),
                                GrayButton(
                                  text: 'Edit profile',
                                  onTap: () {
                                    Get.toNamed('/editProfile');
                                  },
                                ),
                                context.mediaQuerySize.width > 500
                                    ? ProfileInformation()
                                    : Container()
                              ],
                            ),
                          ],
                        ),
                        context.mediaQuerySize.width > 500
                            ? Container()
                            : ProfileInformation(),
                      ],
                    ),
                    BorderedContainer(
                      children: [
                        Row(
                          mainAxisAlignment: context.mediaQuerySize.width > 500
                              ? MainAxisAlignment.spaceEvenly
                              : MainAxisAlignment.spaceBetween,
                          children: [
                            ProfileMetrics(count: 453, metric: 'Feedbacks'),
                            ProfileMetrics(count: 32, metric: 'Comments'),
                            ProfileMetrics(
                              count: 9321,
                              metric: 'Followers',
                              onTap: () {
                                Get.toNamed('/followers');
                              },
                            ),
                            ProfileMetrics(count: 78, metric: 'Following'),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Column(
                      children: List.generate(
                        2,
                        (i) {
                          return Column(
                            children: [
                              FeedbackMini(
                               null//TODO: feedback in profile
                              ),
                              SizedBox(height: 10),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileInformation extends StatefulWidget {
  @override
  _ProfileInformationState createState() => _ProfileInformationState();
}

class _ProfileInformationState extends State<ProfileInformation> {
  var box = Hive.box('appMetrics');
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 25),
        Row(
          children: [
            SvgPicture.asset('assets/images/pin.svg'),
            SizedBox(width: 6),
            Text(
              box.get('myCountry') != null
                  ? '${box.get('myCountry')}, ${box.get('myCity')}'
                  : 'United States, New York',
              style: TextStyle(
                color: AppColors.grey,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        Text(
          box.get('myStatus') != null
              ? '${box.get('myStatus')}'
              : 'Hi, I`m Peter. And I Introvert...',
          style: TextStyle(
            color: AppColors.lightBlack,
            fontSize: 24,
            fontWeight: FontWeight.w400,
            height: 1.25,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 15),
          width: 282,
          child: Divider(
            color: AppColors.lightGrey,
            thickness: 1,
          ),
        ),
        Text(
          box.get('myEmail') != null
              ? '${box.get('myEmail')}'
              : 'peterrollllins@gmail.com',
          style: TextStyle(
            color: AppColors.lightBlack,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Get.to(AllFeedbacks());
          },
          child: Row(
            children: [
              box.get('isYoutube') != null && box.get('isYoutube') == true
                  ? Row(
                      children: [
                        YoutubeWidget(),
                        SizedBox(width: 13),
                      ],
                    )
                  : Container(),
              box.get('isFacebook') != null && box.get('isFacebook') == true
                  ? Row(
                      children: [
                        FacebookWidget(),
                        SizedBox(width: 13),
                      ],
                    )
                  : Container(),
              box.get('isTwitter') != null && box.get('isTwitter') == true
                  ? Row(
                      children: [
                        TwitterWidget(),
                        SizedBox(width: 13),
                      ],
                    )
                  : Container(),
              box.get('isInstagram') != null && box.get('isInstagram') == true
                  ? InstagramWidget()
                  : Container(),
            ],
          ),
        ),
      ],
    );
  }
}

class ProfileMetrics extends StatelessWidget {
  final int count;
  final String metric;
  final GestureTapCallback onTap;

  ProfileMetrics({this.count, this.metric, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            '$count',
            style: TextStyle(
              color: AppColors.lightBlack,
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 5),
          Text(
            metric,
            style: TextStyle(
              color: AppColors.lightBlack,
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
