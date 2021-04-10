import 'package:dating_app/data/data.dart';
import 'package:dating_app/screens/home_screen/profile_page.dart';
import 'package:dating_app/widgets/page_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:dating_app/resourses/colors.dart';
import '../../states.dart';

import 'add_track_account.dart';
import 'all_track_accounts.dart';

class TrackAccountMain extends StatefulWidget {
  final PageController pageController;

  TrackAccountMain({this.pageController});
  @override
  _TrackAccountMainState createState() => _TrackAccountMainState();
}

class _TrackAccountMainState extends State<TrackAccountMain> {
  AppStates appStates = Get.put(AppStates());

  List<String> listOfNames = ['Dmitriy Yakovlev', 'Milena Berg', 'John Snow', 'Stuart Little', 'Selena Gomez'];

  List<String> listOfCities = ['USA, Miami', 'Russia, Moscow', 'Ireland, Dublin', 'USA, New York', 'USA, Los Angeles'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.light,
      appBar: AppBar(
        leading: Container(),
        centerTitle: true,
        title: Image.asset('assets/images/logo.png', height: 48),
        elevation: 0,
        backgroundColor: AppColors.lightBronze,
        actions: [
          InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: () {
              Get.to(AddTrackAccount());
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SvgPicture.asset(
                'assets/images/add_person.svg',
                height: 20,
                width: 20,
              ),
            ),
          ),
        ],
      ),
      // bottomNavigationBar: Container(
      //   color: Colors.white,
      //   padding: const EdgeInsets.symmetric(horizontal: 30),
      //   height: 64,
      //   width: context.mediaQuerySize.width,
      //   child: Row(
      //     mainAxisAlignment: context.mediaQuerySize.width > 500
      //         ? MainAxisAlignment.spaceEvenly
      //         : MainAxisAlignment.spaceBetween,
      //     children: [
      //       GestureDetector(
      //         onTap: () {
      //           Get.toNamed('/allFeedbacks');
      //         },
      //         child: SvgPicture.asset(
      //           'assets/images/home.svg',
      //           color: AppColors.lightBlack,
      //         ),
      //       ),
      //       GestureDetector(
      //         onTap: () {
      //           Get.toNamed('/globalSearch');
      //         },
      //         child: SvgPicture.asset(
      //           'assets/images/search.svg',
      //         ),
      //       ),
      //       GestureDetector(
      //         onTap: () {
      //           Get.toNamed('/addFeedback');
      //         },
      //         child: SvgPicture.asset(
      //           'assets/images/plus.svg',
      //         ),
      //       ),
      //       GestureDetector(
      //         onTap: () {
      //           Get.to(TrackAccountMain());
      //         },
      //         child: SvgPicture.asset(
      //           'assets/images/ring.svg',
      //           color: AppColors.orange,
      //         ),
      //       ),
      //       GestureDetector(
      //         onTap: () {
      //           Get.toNamed('/myProfile');
      //         },
      //         child: Container(
      //           height: 24,
      //           width: 24,
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(30),
      //             // border: Border.all(color: AppColors.orange, width: 2),
      //             image: DecorationImage(
      //               image: AssetImage(appStates.profilePhoto.value),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 25),
            child: PageTitle('Track accounts'),
          ),
          SizedBox(height: 25),
          Container(
            height: 201,
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(left: 15, right: 5),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, i) => TrackPersonMini(
                      index: i + 1,
                      names: listOfNames,
                      locations: listOfCities,
                      onClose: () {
                        setState(() {
                          listOfNames.removeAt(i);
                        });
                      },
                      onChange: () {
                        Get.to(AddTrackAccount(name: listOfNames[i]));
                      },
                    ),
                    itemCount: listOfNames.length,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlatButton(
                  onPressed: () {
                    Get.to(AllTrackAccounts());
                  },
                  padding: EdgeInsets.all(24),
                  highlightColor: Colors.transparent,
                  child: SvgPicture.asset('assets/images/arrow_right.svg'),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: PageTitle('Notifications'),
          ),
          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: List.generate(
                5,
                (index) => TrackBlock(
                  who: Lists.listTopUsersName[index],
                  avatar: Lists.listTopUsers[index],
                  when: ['11 minutes ago', '22 minutes ago', '33 minutes ago', '44 minutes ago', '55 minutes ago'][index],
                  action: 'start followed you',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TrackPersonMini extends StatelessWidget {
  final int index;
  final List<String> names;
  final List<String> locations;
  final GestureTapCallback onClose;
  final GestureTapCallback onChange;

  TrackPersonMini({this.index, this.names, this.locations, this.onClose, this.onChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 201,
      width: 201,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: onClose,
              child: SvgPicture.asset(
                'assets/images/cross.svg',
                width: 13,
                height: 13,
                color: Color(0xFFCBC6BF),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextGradientTrack(text: index < 10 ? '0$index' : '$index'),
              Text(
                names[index - 1].split(' ')[0],
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  height: 1.1,
                ),
              ),
              Row(
                children: [
                  Text(
                    names[index - 1].split(' ')[1],
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      height: 1.1,
                      color: AppColors.lightBlack,
                    ),
                  ),
                  SizedBox(width: 10),
                  InkWell(
                    onTap: onChange,
                    child: SvgPicture.asset('assets/images/settings.svg'),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  SvgPicture.asset('assets/images/pin.svg'),
                  SizedBox(width: 4),
                  Text(
                    locations[index - 1],
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      height: 1.1,
                      color: Color(0xFFCBC6BF),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TextGradientTrack extends StatelessWidget {
  final String text;

  TextGradientTrack({this.text});

  @override
  Widget build(BuildContext context) {
    return GradientText(
      text,
      style: TextStyle(
        fontSize: 72,
        fontWeight: FontWeight.w200,
        height: 1,
      ),
      gradient: LinearGradient(
        colors: [
          Color(0xFFFFFFFF),
          Color(0xFFE1E1DF),
        ],
        stops: [0.2, 1],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      ),
    );
  }
}

class TrackBlock extends StatelessWidget {
  final String avatar;
  final String who;
  final String action;
  final String when;

  TrackBlock({this.avatar, this.who, this.action, this.when});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 104,
      width: context.mediaQuerySize.width,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Get.to(Profile());
            },
            child: Container(
              height: 61,
              width: 61,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(avatar),
                ),
              ),
            ),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: context.mediaQuerySize.width * 0.5,
                    child: RichText(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: who,
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.orange,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.3,
                        ),
                        children: [
                          TextSpan(
                            text: ' $action',
                            style: TextStyle(color: AppColors.lightBlack, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Text(
                when,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: AppColors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
