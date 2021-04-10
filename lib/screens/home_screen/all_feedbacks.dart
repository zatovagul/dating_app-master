import 'package:dating_app/data/data.dart';
import 'dart:io';
import 'package:dating_app/screens/add_feedback_screen/add_feedback.dart';
import 'package:dating_app/screens/global_search_screen/global_search.dart';
import 'package:dating_app/screens/home_screen/last_comments.dart';
import 'package:dating_app/screens/home_screen/menu.dart';
import 'package:dating_app/screens/home_screen/saved_drafts.dart';
import 'package:dating_app/screens/home_screen/top_users.dart';
import 'package:dating_app/screens/messages/messages_main.dart';
import 'package:dating_app/screens/notification/track_account_main.dart';
import 'package:dating_app/screens/profile_screen/my_profile_page.dart';
import 'package:dating_app/resourses/colors.dart';
import 'package:dating_app/widgets/text_gradient.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../states.dart';
import 'feedback.dart';
import 'all_feedback_screen.dart';
import 'package:dating_app/models/all_feedback.dart';

class AllFeedbacks extends StatefulWidget {
  static int page = 0;
  static PageController pageController = PageController(initialPage: page);
  @override
  _AllFeedbacksState createState() => _AllFeedbacksState();
}

class _AllFeedbacksState extends State<AllFeedbacks> {
  AppStates appStates = Get.put(AppStates());
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  double currentPage = 0;

/*  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      pageController = PageController(initialPage: widget.page);
    });
  }*/
  Widget getPage(int page, PageController pageController) {
    switch (page) {
      case 1:
        {
          return TopUsers();
        }
      case 2:
        {
          return LastComments();
        }
      case 3:
        {
          return SavedDrafts();
        }

      default:
        return AllFeedbackScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid && MediaQuery.of(context).size.width > 500) exit(0);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
      backgroundColor: AppColors.light,
      drawer: HomeMenu(AllFeedbacks.pageController),
      appBar: currentPage == 0
          ? AppBar(
              leading: IconButton(
                highlightColor: Colors.transparent,
                onPressed: () => _scaffoldKey.currentState.openDrawer(),
                icon: SvgPicture.asset('assets/images/list.svg', height: 20, width: 20),
              ),
              centerTitle: true,
              title: Image.asset('assets/images/logo.png', height: 48),
              elevation: 0,
              backgroundColor: AppColors.lightBronze,
              actions: [
                IconButton(
                  onPressed: () {
                    Get.to(MessagesMain());
                  },
                  icon: SvgPicture.asset(
                    'assets/images/message.svg',
                    height: 20,
                    width: 20,
                  ),
                ),
              ],
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: currentPage.round(),
        onTap: (index) {
          setState(() {
            if (index == 0) appStates.firstPages.value = 0;
            if (index == 2)
              currentPage.round() == 2 ? showCustomBottomSheet() : AllFeedbacks.pageController.jumpToPage(index);
            else
              AllFeedbacks.pageController.jumpToPage(index);
          });
        },
        items: [
          BottomNavigationBarItem(
            label: 'All feedback',
            icon: SvgPicture.asset(
              'assets/images/home.svg',
              color: currentPage.round() == 0 ? AppColors.orange : AppColors.lightBlack,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Search',
            icon: SvgPicture.asset(
              'assets/images/search.svg',
              color: currentPage.round() == 1 ? AppColors.orange : AppColors.lightBlack,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Add feedback',
            icon: SvgPicture.asset(
              'assets/images/plus.svg',
              color: currentPage.round() == 2 ? AppColors.orange : AppColors.lightBlack,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Notifications',
            icon: SvgPicture.asset(
              'assets/images/ring.svg',
              color: currentPage.round() == 3 ? AppColors.orange : AppColors.lightBlack,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: AppColors.orange,
                  width: currentPage.round() == 4 ? 2 : 0,
                ),
                image: DecorationImage(
                  image: AssetImage(appStates.profilePhoto.value),
                ),
              ),
            ),
          )
        ],
      ),
      body: PageView(
        controller: AllFeedbacks.pageController,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (page) {
          setState(() {
            currentPage = page.toDouble();
          });
          appStates.firstPages.value = 0;
        },
        children: [
          Obx(
            () => getPage(appStates.firstPages.value, AllFeedbacks.pageController),
          ),
          GlobalSearch(),
          AddFeedback(pageController: AllFeedbacks.pageController),
          TrackAccountMain(pageController: AllFeedbacks.pageController),
          MyProfile(),
        ],
      ),
    );
  }

  void showCustomBottomSheet() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              child: Text('new_feedback'.tr),
              isDestructiveAction: false,
              onPressed: () {
                Get.back();
              },
            ),
            CupertinoActionSheetAction(
              child: Text('saved_drafts'.tr),
              isDestructiveAction: false,
              onPressed: () {
                setState(() {
                  AllFeedbacks.pageController.jumpToPage(0);
                });
                appStates.firstPages.value = 3;
                Get.back();
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

class IconWithCount extends StatelessWidget {
  final int count;
  final Widget icon;
  final String svgIcon;
  final Color colorText;
  final GestureTapCallback onTap;

  IconWithCount({this.count, this.icon, this.colorText, this.svgIcon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        color: Colors.transparent,
        child: Row(
          children: [
            svgIcon != null
                ? SvgPicture.asset(
                    svgIcon,
                    color: colorText ?? AppColors.iconsGrey,
                  )
                : icon,
            SizedBox(width: 5),
            Text(
              count.toString(),
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: colorText ?? AppColors.iconsGrey,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FeedbackSection extends StatelessWidget {
  final String name;

  FeedbackSection({this.name});

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        color: AppColors.black,
        fontSize: 16,
      ),
    );
  }
}

class TopUsersHorizontal extends StatelessWidget {
  final int index;

  TopUsersHorizontal({this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(right: 10),
      height: 250,
      width: 174,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Container(
              height: 218,
              width: 174,
              padding: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      Lists.listTopUsers[index],
                      width: 60,
                      height: 60,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    Lists.listTopUsersName[index],
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${Lists.listTopUsersFeedbacksCount[index]} feedbacks',
                    style: TextStyle(
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: 15),
                  TopUsersSubscribeButton(),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.lerp(Alignment.center, Alignment.topCenter, 0.85),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 33,
                  width: 33,
                  decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                ),
                Container(
                  alignment: Alignment.lerp(Alignment.center, Alignment.bottomCenter, index + 1 != 1 ? 0.2 : 0),
                  height: 28,
                  width: 28,
                  decoration: index + 1 != 1
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
                  child: index + 1 != 1
                      ? Text(
                          '${index + 1}',
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
    );
  }
}

class TopUsersSubscribeButton extends StatelessWidget {
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
              width: 144,
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
                        text: 'unsubscribe'.tr,
                      )
                    : Text(
                        'subscribe'.tr,
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

class LastCommentsHorizontal extends StatelessWidget {
  final AllFeedback allFeedback;

  LastCommentsHorizontal(this.allFeedback);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 192,
      width: 282,
      margin: EdgeInsets.only(
        right: 10,
        top: 25,
      ),
      padding: EdgeInsets.only(
        left: 15,
        right: 15,
        top: 30,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Lists.listLastCommentsOrange[1],
            style: TextStyle(
              color: AppColors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 80,
            child: Text(
              /*Lists.listLastComments[index]*/ 'Last comment',
              style: TextStyle(
                color: AppColors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
          ),
          SizedBox(height: 20),
          InkWell(
            onTap: () {
              Get.to(FullFeedback(allFeedback));
            },
            child: SvgPicture.asset('assets/images/arrow_right.svg'),
          ),
        ],
      ),
    );
  }
}
