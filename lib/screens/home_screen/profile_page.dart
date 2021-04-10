import 'package:dating_app/data/data.dart';
import 'package:dating_app/screens/home_screen/all_feedbacks.dart';
import 'package:dating_app/screens/home_screen/followers.dart';
import 'package:dating_app/screens/messages/message.dart';
import 'package:dating_app/screens/profile_screen/support.dart';
import 'package:dating_app/states.dart';
import 'package:dating_app/widgets/bordered_container.dart';
import 'package:dating_app/widgets/feedback_mini.dart';
import 'package:dating_app/widgets/grey_button.dart';
import 'package:dating_app/widgets/social_network_widgets.dart';
import 'package:dating_app/widgets/subscribe_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dating_app/resourses/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
//

  AppStates appStates = Get.put(AppStates());
  var box = Hive.box('appMetrics');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBronze,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: SvgPicture.asset('assets/images/appbar_arrow_left.svg', height: 20, width: 20),
        ),
        centerTitle: false,
        titleSpacing: -5,
        title: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'previous_page_title'.tr,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
              ),
              GestureDetector(
                onTap: () {
                  showProfileBottomSheet();
                },
                child: Container(
                  width: 30,
                  height: 30,
                  color: Colors.transparent,
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/images/more_horizontal.svg',
                      width: 5,
                      height: 5,
                      color: AppColors.orange,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        elevation: 0,
        backgroundColor: AppColors.lightBronze,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(top: 7),
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
                                image: AssetImage('assets/images/top_user1.png'),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                box.get('login') != null ? '@${box.get('login')}' : '@petttter',
                                style: TextStyle(
                                  color: AppColors.orange,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 7),
                              Text(
                                box.get('firstName') != null ? '${box.get('firstName')} ${box.get('lastName')}' : 'Peter Rollins',
                                style: TextStyle(
                                  color: AppColors.lightBlack,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 7),
                              Text(
                                box.get('whenJoined') != null ? 'Joined in ${box.get('whenJoined')}' : 'Joined in March 2020',
                                style: TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 20),
                              SubscribeButton(),
                              SizedBox(height: 10),
                              GrayButton(
                                text: 'message'.tr,
                                onTap: () {
                                  Get.to(Messages(
                                    name: Lists.listTopUsersName[0],
                                    avatar: Lists.listTopUsers[0],
                                    isOnline: true,
                                  ));
                                },
                              ),
                              context.isTablet ? ProfileInformation() : Container()
                            ],
                          ),
                        ],
                      ),
                      context.isTablet ? Container() : ProfileInformation(),
                    ],
                  ),
                  BorderedContainer(
                    children: [
                      Row(
                        mainAxisAlignment: context.mediaQuerySize.width > 500 ? MainAxisAlignment.spaceEvenly : MainAxisAlignment.spaceBetween,
                        children: [
                          ProfileMetrics(count: 453, metric: 'feedbacks'.tr),
                          ProfileMetrics(count: 32, metric: 'comments'.tr),
                          InkWell(
                              onTap: () {
                                Get.to(Followers());
                              },
                              child: ProfileMetrics(count: 9321, metric: 'followers'.tr)),
                          ProfileMetrics(count: 78, metric: 'following'.tr),
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
null/*TODO*/
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
          ],
        ),
      ),
    );
  }

  void showProfileBottomSheet() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              child: Text('write'.tr),
              isDestructiveAction: false,
              onPressed: () {
                Get.back();
                Get.to(Messages(
                  name: Lists.listTopUsersName[0],
                  avatar: Lists.listTopUsers[0],
                  isOnline: true,
                ));
              },
            ),
            CupertinoActionSheetAction(
              child: Text('subscribe'.tr),
              isDestructiveAction: false,
              onPressed: () {
                print('Action 1 printed');
              },
            ),
            CupertinoActionSheetAction(
              child: Text('complain'.tr),
              isDestructiveAction: false,
              onPressed: () {
                Get.back();
                Get.to(Support());
              },
            ),
            CupertinoActionSheetAction(
              child: Text('block'.tr),
              isDestructiveAction: true,
              onPressed: () {
                print('Action 1 printed');
              },
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            child: Text('cancel'.tr),
            isDestructiveAction: false,
            onPressed: () {
              Get.back();
            },
          ),
        );
      },
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
              box.get('myCountry') != null ? '${box.get('myCountry')}, ${box.get('myCity')}' : 'United States, New York',
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
          box.get('myStatus') != null ? '${box.get('myStatus')}' : 'Hi, I`m Peter. And I Introvert...',
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
          box.get('myEmail') != null ? '${box.get('myEmail')}' : 'peterrollllins@gmail.com',
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
              box.get('isInstagram') != null && box.get('isInstagram') == true ? InstagramWidget() : Container(),
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

  ProfileMetrics({this.count, this.metric});

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
