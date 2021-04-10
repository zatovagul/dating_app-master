import 'package:carousel_slider/carousel_slider.dart';
import 'package:dating_app/data/data.dart';
import 'package:dating_app/screens/home_screen/all_feedbacks.dart';
import 'package:dating_app/screens/messages/message.dart';
import 'package:dating_app/screens/profile_screen/support.dart';
import 'package:dating_app/resourses/colors.dart';
import 'package:dating_app/widgets/more_text.dart';
import 'package:dating_app/widgets/quote.dart';
import 'package:dating_app/widgets/social_network_widgets.dart';
import 'package:dating_app/widgets/standart_text_of_feedback.dart';
import 'package:dating_app/widgets/tag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:get/get.dart';
import 'package:dating_app/resourses/fonts.dart';
import 'package:dating_app/models/all_feedback.dart';

class FeedbackContainer extends StatefulWidget {
//

  final AllFeedback allFeedback;

  FeedbackContainer(this.allFeedback);

  @override
  _FeedbackContainerState createState() => _FeedbackContainerState();

//
}

class _FeedbackContainerState extends State<FeedbackContainer> {
  var box = Hive.box('appMetrics');
  var isMaximizedContainer = false.obs;
  bool _more = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: context.mediaQuerySize.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/profile');
                  },
                  child: Row(
                    children: [
                      Container(
                        height: 36,
                        width: 36,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: widget.allFeedback.user.avatar_url != null ? DecorationImage(image: NetworkImage(widget.allFeedback.user.avatar_url)) : null,
                        ),
                      ),
                      SizedBox(width: 15),
                      Text(
                        widget.allFeedback.user.first_name + ' ' + widget.allFeedback.user.last_name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) {
                        return CupertinoActionSheet(
                          actions: [
                            CupertinoActionSheetAction(
                              child: Text('Написать'),
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
                              child: Text('Подписаться'),
                              isDestructiveAction: false,
                              onPressed: () {
                                print('Action 1 printed');
                              },
                            ),
                            CupertinoActionSheetAction(
                              child: Text('Пожаловаться'),
                              isDestructiveAction: false,
                              onPressed: () {
                                Get.back();
                                Get.to(Support());
                              },
                            ),
                            CupertinoActionSheetAction(
                              child: Text('Заблокировать'),
                              isDestructiveAction: true,
                              onPressed: () {
                                print('Action 1 printed');
                              },
                            ),
                          ],
                          cancelButton: CupertinoActionSheetAction(
                            child: Text('Отменить'),
                            isDestructiveAction: false,
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        );
                      },
                    );
                  },
                  icon: SvgPicture.asset(
                    'assets/images/more_horizontal.svg',
                    width: 5,
                    height: 5,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              widget.allFeedback.title,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.w600,
                color: AppColors.lightBlack,
                fontFamily: AppFonts.Graphic,
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              children: [
                Tag(tag: 'anna'),
                SizedBox(width: 10),
                Tag(tag: 'loure'),
                SizedBox(width: 10),
                Tag(tag: 'dating'),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            child: CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 0.81,
                aspectRatio: 20 / 8.4,
              ),
              items: List.generate(
                3,
                (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/images/photos.png',
                            fit: BoxFit.fill,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: GestureDetector(
              onTap: () {
                isMaximizedContainer.value = !isMaximizedContainer.value;
              },
              child: Container(
                width: context.mediaQuerySize.width,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                  color: AppColors.light,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Information person',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.orange,
                          ),
                        ),
                        Obx(() => Text(
                              isMaximizedContainer.value ? '-' : '+',
                              style: TextStyle(
                                fontSize: isMaximizedContainer.value ? 35 : 30,
                                color: AppColors.orange,
                              ),
                            )),
                      ],
                    ),
                    Obx(
                      () => isMaximizedContainer.value
                          ? Column(
                              children: [
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text(
                                      'Peter Rollins',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: AppColors.lightBlack,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    SvgPicture.asset('assets/images/pin.svg'),
                                    SizedBox(width: 6),
                                    Text(
                                      'United States, New York',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: AppColors.grey,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(AllFeedbacks());
                                  },
                                  child: Row(
                                    children: [
                                      Row(
                                        children: [
                                          YoutubeWidget(),
                                          SizedBox(width: 13),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          FacebookWidget(),
                                          SizedBox(width: 13),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          TwitterWidget(),
                                          SizedBox(width: 13),
                                        ],
                                      ),
                                      InstagramWidget(),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                              ],
                            )
                          : Container(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                StandartTextOfFeedback(text: 'Whether you’re crossing the George Washington Bridge into the Heights, riding the Metro North-south along the Hudson, or stuck in traffic along the Long Island Expressway, there’s nothing like that feeling of magic and inspiration that washes over you the moment you first spot the Manhattan skyline. Whether you’re a first-timer or a lifelong New Yorker, there’s always more to discover.'),
                Quote(text: 'The interaction of the corporation and the client, according to F. Kotler, weakly distorts the social industry standard. Expertise of the completed project, according to F. Kotler, is ambiguous. Community stimulation allows for the tactical principle of perception.'),
                StandartTextOfFeedback(text: 'The pool of loyal publications concentrates the role-playing exhibition stand. Until recently.'),
                if (_more) StandartTextOfFeedback(text: 'f the corporation and the client, according toons concentrates the role-playing exhibition stand. Until recently.'),
                if (_more) StandartTextOfFeedback(text: 'Tooo many text oyal publications concentrates the rolng the George Washingto. Until recently.'),
                if (_more) StandartTextOfFeedback(text: 'ng the George Washingto concentrates the role-playing exhibition stand. Until recently.'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: MoreText(
              onPressed: onMorePressed,
              text: _more ? 'Hide' : 'More',
              isMore: _more,
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
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconWithCount(
                      svgIcon: 'assets/images/like.svg',
                      count: 112,
             //TODO
             /*         colorText: box.get('feedback_like_${widget.index}') != null
                          ? box.get('feedback_like_${widget.index}')
                              ? AppColors.orange
                              : AppColors.iconsGrey
                          : AppColors.iconsGrey,*/
                      onTap:onLikeTap,
                    ),
              /*      SizedBox(width: 15),
                    IconWithCount(
                      svgIcon: 'assets/images/smile_neutral.svg',
                      count: 34,
                      colorText: box.get('feedback_neutral_${widget.index}') != null
                          ? box.get('feedback_neutral_${widget.index}')
                              ? AppColors.orange
                              : AppColors.iconsGrey
                          : AppColors.iconsGrey,
                      onTap: () {
                        setState(() {
                          box.put('feedback_neutral_${widget.index}', box.get('feedback_neutral_${widget.index}') != null ? !box.get('feedback_neutral_${widget.index}') : true);
                          box.put('feedback_like_${widget.index}', false);
                          box.put('feedback_unlike_${widget.index}', false);
                        });
                      },
                    ),
                    SizedBox(width: 15),
                    IconWithCount(
                      svgIcon: 'assets/images/unlike.svg',
                      count: 75,
                      colorText: box.get('feedback_unlike_${widget.index}') != null
                          ? box.get('feedback_unlike_${widget.index}')
                              ? AppColors.orange
                              : AppColors.iconsGrey
                          : AppColors.iconsGrey,
                      onTap: () {
                        setState(() {
                          box.put('feedback_unlike_${widget.index}', box.get('feedback_unlike_${widget.index}') != null ? !box.get('feedback_unlike_${widget.index}') : true);
                          box.put('feedback_neutral_${widget.index}', false);
                          box.put('feedback_like_${widget.index}', false);
                        });
                      },
                    ),*/
                  ],
                ),
                IconWithCount(
                  icon: SvgPicture.asset(
                    'assets/images/feedback_show_count.svg',
                    color: AppColors.grey,
                  ),
                  count: 1193,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onMorePressed() {
    setState(() {
      _more = !_more;
    });
  }

  void onLikeTap () {
    //TODO
/*    setState(() {
      box.put('feedback_like_${widget.index}', box.get('feedback_like_${widget.index}') != null ? !box.get('feedback_like_${widget.index}') : true);
      box.put('feedback_neutral_${widget.index}', false);
      box.put('feedback_unlike_${widget.index}', false);
    });*/
  }
}
