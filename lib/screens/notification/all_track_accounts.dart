import 'package:dating_app/widgets/custom_widgets.dart';
import 'package:dating_app/widgets/page_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:dating_app/resourses/colors.dart';

import '../../states.dart';
import 'add_track_account.dart';

class AllTrackAccounts extends StatefulWidget {
  @override
  _AllTrackAccountsState createState() => _AllTrackAccountsState();
}

class _AllTrackAccountsState extends State<AllTrackAccounts> {
  AppStates appStates = Get.put(AppStates());

  List<String> listOfNames = ['Dmitriy Yakovlev', 'Milena Berg', 'John Snow', 'Stuart Little', 'Selena Gomez'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.light,
      appBar: AppBar(
        leading: IconButton(
          highlightColor: Colors.white,
          onPressed: () {
            Get.back();
          },
          icon: SvgPicture.asset(
            'assets/images/appbar_arrow_left.svg',
            height: 20,
            width: 20,
          ),
        ),
        centerTitle: true,
        title: Image.asset('assets/images/logo.png', height: 48),
        elevation: 0,
        backgroundColor: AppColors.lightBronze,
        actions: [
          IconButton(
            highlightColor: Colors.white,
            onPressed: () {
              Get.to(AddTrackAccount());
            },
            icon: Padding(
              padding: const EdgeInsets.only(right: 16.0),
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
      //           Get.toNamed('/trackAccount');
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
          Container(
            width: context.width / 2,
            child: Column(
              crossAxisAlignment: context.width < 500 ? CrossAxisAlignment.start : CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 25),
                  child: PageTitle('Track accounts'),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.width < 500 ? 15 : context.width * 0.2),
                  child: Text(
                    'Add information about person and we will inform you if a story about him appears on our website',
                    textAlign: context.width < 500 ? TextAlign.start : TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      height: 1.24,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.width < 500 ? 15 : context.width * 0.3),
                  child: GradientButton(
                    text: 'Add person',
                    isMargin: false,
                    height: 53,
                    onTap: () {
                      Get.to(AddTrackAccount());
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: context.width < 500
                ? Column(
                    children: List.generate(
                      listOfNames.length,
                      (i) => Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: TrackPersonMini(
                          index: i + 1,
                          names: listOfNames,
                          locations: ['USA, Miami', 'Russia, Moscow', 'Ireland, Dublin', 'USA, New York', 'USA, Los Angeles'],
                          onClose: () {
                            setState(() {
                              listOfNames.removeAt(i);
                            });
                          },
                          onChange: () {
                            Get.to(AddTrackAccount(name: listOfNames[i]));
                          },
                        ),
                      ),
                    ),
                  )
                : Wrap(
                    spacing: 10,
                    children: List.generate(
                      listOfNames.length,
                      (i) => Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: TrackPersonMini(
                          index: i + 1,
                          names: listOfNames,
                          locations: ['USA, Miami', 'Russia, Moscow', 'Ireland, Dublin', 'USA, New York', 'USA, Los Angeles'],
                          onClose: () {
                            setState(() {
                              listOfNames.removeAt(i);
                            });
                          },
                          onChange: () {
                            Get.to(AddTrackAccount(name: listOfNames[i]));
                          },
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
      height: 233,
      width: context.width < 500 ? context.width : context.width / 2 - 30,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextGradientTrack(text: index < 10 ? '0$index' : '$index'),
              Row(
                children: [
                  Text(
                    '${names[index - 1]}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      height: 1,
                    ),
                  ),
                  SizedBox(width: 10),
                  InkWell(onTap: onChange, child: SvgPicture.asset('assets/images/settings.svg')),
                ],
              ),
              SizedBox(height: 5),
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
              SizedBox(height: 15),
              Row(
                children: List.generate(
                  5,
                  (index) => Container(
                    margin: EdgeInsets.only(right: 14),
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFF1ECE2),
                    ),
                    child: Center(
                      child: Image.asset(
                        ['assets/images/ring_icn.png', 'assets/images/youtube_icn.png', 'assets/images/twitter_icn.png', 'assets/images/facebook_icn.png', 'assets/images/instagram_icn.png'][index],
                        height: 17,
                        width: 17,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: onClose,
              icon: SvgPicture.asset(
                'assets/images/cross.svg',
                width: 13,
                height: 13,
                color: Color(0xFFCBC6BF),
              ),
            ),
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
        fontSize: 100,
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
