import 'package:dating_app/screens/home_screen/all_feedbacks.dart';
import 'package:dating_app/screens/home_screen/feedback.dart';
import 'package:dating_app/resourses/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:dating_app/models/all_feedback.dart';

class FeedbackMini extends StatefulWidget {
//

  final AllFeedback allFeedback;
  final EdgeInsets padding;

  FeedbackMini(
    this.allFeedback, {
    this.padding,
  });

  @override
  _FeedbackMiniState createState() => _FeedbackMiniState();

//
}

class _FeedbackMiniState extends State<FeedbackMini> {
  var selectedIndex = 5.obs;

  var box = Hive.box('appMetrics');

  get likeCount => 112;

  get smileNeutralCount => 34 ?? 0;

  get unlikeCount => 75 ?? 0;

  get commentsCount => 45 ?? 0;

  @override
  Widget build(BuildContext context) {
    return widget.allFeedback == null
        ? SizedBox()
        : Container(
            width: context.mediaQuerySize.width,
            padding: const EdgeInsets.only(
              bottom: 25,
            ),
            margin: widget.padding ?? EdgeInsets.only(left: 0, right: 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: context.mediaQuerySize.width,
                  height: widget.allFeedback.images != null ? 205 : 155,
                  child: Stack(
                    children: [
                      Container(
                        height: context.mediaQuerySize.width > 500 ? 275 : 170,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: (widget.allFeedback.images?.length ?? 0) > 0
                              ? Image(
                                  image: NetworkImage(widget.allFeedback.images[0]),
                                  width: context.mediaQuerySize.width,
                                  fit: BoxFit.fitWidth,
                                  alignment: Alignment.topCenter,
                                )
                              : Image.asset(
                                  'assets/images/placeholer-feedbacks.png',
                                  width: context.mediaQuerySize.width,
                                  fit: BoxFit.fitWidth,
                                  alignment: Alignment.topCenter,
                                ),
                        ),
                      ),
                      if (widget.allFeedback.user.avatar_url != null)
                        GestureDetector(
                          onTap: () {
                            Get.toNamed('/profile');
                          },
                          child: Align(
                            alignment: Alignment.lerp(Alignment.bottomLeft, Alignment.bottomRight, 0.05),
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white, width: 3),
                                borderRadius: BorderRadius.circular(50),
                                image: DecorationImage(
                                  alignment: Alignment.lerp(Alignment.centerLeft, Alignment.center, 0.4),
                                  fit: BoxFit.cover,
                                  image: NetworkImage(widget.allFeedback.user.avatar_url),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      text: (widget.allFeedback.user?.first_name ?? 'No Name') + ' ' + (widget.allFeedback.user?.last_name ?? ''),
                      style: TextStyle(
                        fontSize: 24,
                        color: AppColors.orange,
                        fontWeight: FontWeight.w500,
                        height: 1.3,
                      ),
                      children: [
                        TextSpan(
                          text: context.mediaQuerySize.width > 500 ? ' feedback ' : ' feedback\n',
                          style: TextStyle(color: Color(0xFF9E9E9E), fontWeight: FontWeight.w400),
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.to(
                                FullFeedback(widget.allFeedback),
                              );
                            },
                          text: widget.allFeedback.title,
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    widget.allFeedback.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.lightBlack,
                      fontWeight: FontWeight.w400,
                      height: 1.6,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Divider(
                    color: AppColors.lightGrey,
                    thickness: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconWithCount(
                            svgIcon: 'assets/images/like.svg',
                            count: likeCount,
                            //TODO
                            /*         colorText: box.get('feedback_like_${widget.index}') != null
                          ? box.get('feedback_like_${widget.index}')
                              ? AppColors.orange
                              : AppColors.iconsGrey
                          : AppColors.iconsGrey,*/
                            onTap: onLikeTap,
                          ),
                          /*     SizedBox(width: 15),
                    IconWithCount(
                      svgIcon: 'assets/images/smile_neutral.svg',
                      count: smileNeutralCount,
                      colorText: box.get('feedback_neutral_${widget.index}') != null
                          ? box.get('feedback_neutral_${widget.index}')
                              ? AppColors.orange
                              : AppColors.iconsGrey
                          : AppColors.iconsGrey,
                      onTap: omSmileNeutralTap,
                    ),
                    SizedBox(width: 15),
                    IconWithCount(
                      svgIcon: 'assets/images/unlike.svg',
                      count: unlikeCount,
                      colorText: box.get('feedback_unlike_${widget.index}') != null
                          ? box.get('feedback_unlike_${widget.index}')
                              ? AppColors.orange
                              : AppColors.iconsGrey
                          : AppColors.iconsGrey,
                      onTap: onUnlikeTap,
                    ),*/
                          SizedBox(width: 15),
                          IconWithCount(
                            svgIcon: 'assets/images/comments.svg',
                            count: commentsCount,
                            onTap: () {
                              Get.to(
                                FullFeedback(widget.allFeedback),
                              );
                            },
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          Get.to(
                            FullFeedback(widget.allFeedback),
                          );
                        },
                        icon: SvgPicture.asset('assets/images/arrow_right.svg'),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  void onLikeTap() {
    //TODO
    /* setState(() {
      box.put('feedback_like_${widget.index}', box.get('feedback_like_${widget.index}') != null ? !box.get('feedback_like_${widget.index}') : true);
      box.put('feedback_neutral_${widget.index}', false);
      box.put('feedback_unlike_${widget.index}', false);
    });*/
  }

/*  void onUnlikeTap() {
    setState(() {
      box.put('feedback_unlike_${widget.index}', box.get('feedback_unlike_${widget.index}') != null ? !box.get('feedback_unlike_${widget.index}') : true);
      box.put('feedback_neutral_${widget.index}', false);
      box.put('feedback_like_${widget.index}', false);
    });
  }

  void omSmileNeutralTap() {
    setState(() {
      box.put('feedback_neutral_${widget.index}', box.get('feedback_neutral_${widget.index}') != null ? !box.get('feedback_neutral_${widget.index}') : true);
      box.put('feedback_like_${widget.index}', false);
      box.put('feedback_unlike_${widget.index}', false);
    });
  }*/

//
}
