import 'package:dating_app/data/data.dart';
import 'package:dating_app/widgets/feedback_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:dating_app/widgets/custom_widgets.dart';
import 'package:dating_app/resourses/colors.dart';
import 'package:dating_app/screens/home_screen/all_feedbacks.dart';
import '../../states.dart';
import 'package:dating_app/models/all_feedback.dart';

class FullFeedback extends StatefulWidget {
//

  final AllFeedback allFeedback;

  FullFeedback(this.allFeedback);

  @override
  _FullFeedbackState createState() => _FullFeedbackState();

//
}

class _FullFeedbackState extends State<FullFeedback> {
  AppStates appStates = Get.put(AppStates());
  FocusNode focusNode = FocusNode();
  bool isWriteComment = false;
  String replyFrom;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: widget.allFeedback == null
          ? SizedBox()
          : Scaffold(
              bottomNavigationBar: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isWriteComment)
                    MyCommentContainer(
                      replyFrom: replyFrom,
                      focusNode: focusNode,
                    ),
                  BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    currentIndex: 0,
                    onTap: (index) {
                      setState(() {
                        if (index == 0)
                          appStates.firstPages.value = 0;
                        else
                          AllFeedbacks.pageController.jumpToPage(index);
                      });
                      Get.back();
                    },
                    items: [
                      BottomNavigationBarItem(
                        label: 'All feedback',
                        icon: SvgPicture.asset(
                          'assets/images/home.svg',
                          color: AppColors.orange,
                        ),
                      ),
                      BottomNavigationBarItem(
                        label: 'Search',
                        icon: SvgPicture.asset(
                          'assets/images/search.svg',
                          color: AppColors.lightBlack,
                        ),
                      ),
                      BottomNavigationBarItem(
                        label: 'Add feedback',
                        icon: SvgPicture.asset(
                          'assets/images/plus.svg',
                          color: AppColors.lightBlack,
                        ),
                      ),
                      BottomNavigationBarItem(
                        label: 'Notifications',
                        icon: SvgPicture.asset(
                          'assets/images/ring.svg',
                          color: AppColors.lightBlack,
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
                              width: 0,
                            ),
                            image: DecorationImage(
                              image: AssetImage(appStates.profilePhoto.value),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              backgroundColor: AppColors.light,
              appBar: AppBar(
                leading: IconButton(
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    Get.back();
                  },
                  icon: SvgPicture.asset('assets/images/appbar_arrow_left.svg', height: 20, width: 20),
                ),
                centerTitle: false,
                titleSpacing: -5,
                title: Text(
                  'feedback',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
                elevation: 0,
                backgroundColor: AppColors.lightBronze,
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Image.asset('assets/images/original_language.png'),
                        SizedBox(width: 10),
                        Text(
                          'Show original',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: AppColors.lightBlack,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onPanDown: (_) {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: ListView(
                    padding: EdgeInsets.only(bottom: 10),
                    children: [
                      FeedbackContainer(widget.allFeedback),
                      CountOfCommentsText(count: 52),
                      FlatButton(
                        onPressed: () => setState(() {
                          focusNode.requestFocus();
                          replyFrom = null;
                          isWriteComment = true;
                        }),
                        color: Color(0xFFFF6647),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Write comment',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      CommentContainer(
                        onReply: onReply,
                        isAutor: true,
                        isReplayed: true,
                        withReply: false,
                        focusNode: focusNode,
                      ),
                      CommentContainer(
                        onReply: onReply,
                        isAutor: false,
                        isReplayed: true,
                        withReply: true,
                        focusNode: focusNode,
                      ),
                      CommentContainer(
                        onReply: onReply,
                        isAutor: false,
                        isReplayed: false,
                        withReply: false,
                        focusNode: focusNode,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  onReply() {
    focusNode.requestFocus();
    setState(() {
      replyFrom = Lists.listTopUsersName[0];
      isWriteComment = true;
    });
  }
}

class CommentContainer extends StatefulWidget {
  final String text;
  final bool isAutor;
  final bool isReplayed;
  final bool like;
  final bool withReply;
  final VoidCallback onReply;
  final FocusNode focusNode;

  CommentContainer({
    this.like = false,
    this.text,
    this.isAutor,
    this.isReplayed,
    this.withReply,
    this.focusNode,
    this.onReply,
  });

  @override
  _CommentContainerState createState() => _CommentContainerState();
}

class _CommentContainerState extends State<CommentContainer> {
  AppStates appStates = Get.put(AppStates());
  bool _like;
  bool _replyLike = false;
  @override
  void initState() {
    _like = widget.like;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      width: context.mediaQuerySize.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 41,
                width: 41,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: AssetImage(appStates.profilePhoto.value),
                  ),
                ),
              ),
              SizedBox(width: 13),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Lists.listTopUsersName[0],
                    style: TextStyle(
                      color: AppColors.lightBlack,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    height: 1,
                    width: 100,
                    color: Colors.grey[300],
                  ),
                ],
              ),
              if (widget.isAutor)
                Row(
                  children: [
                    SizedBox(width: 13),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.orange,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        'Autor',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 55),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.text ?? 'Awesome video! Really enjoyed it :) SIA has one of the best longhaul economy class! Sufficient and good looking food, comfortable seat and great IFE (+ a big screen). Little touches as a menu are also very nice, welk done SIA! Can’t wait to try them out :)',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.grey,
                    height: 1.36,
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    IconButton(
                      onPressed: () => setState(() => _like = !_like),
                      icon: _like
                          ? SvgPicture.asset(
                              'assets/images/reply.svg',
                            )
                          : SvgPicture.asset(
                              'assets/images/reply_outline.svg',
                              height: 16,
                              color: AppColors.orange,
                            ),
                    ),
                    SizedBox(width: 10),
                    if (widget.isReplayed)
                      Row(
                        children: [
                          Text(
                            '1 reply',
                            style: TextStyle(
                              color: AppColors.lightBlack,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                    FlatButton(
                      highlightColor: Colors.transparent,
                      onPressed: widget.onReply,
                      child: Text(
                        'Reply',
                        style: TextStyle(
                          color: AppColors.orange,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                if (widget.withReply)
                  Container(
                    margin: EdgeInsets.only(top: 12),
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    width: context.mediaQuerySize.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xFFF8F5EF),
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 41,
                              width: 41,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                image: DecorationImage(
                                  image: AssetImage(appStates.profilePhoto.value),
                                ),
                              ),
                            ),
                            SizedBox(width: 13),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  Lists.listTopUsersName[0],
                                  style: TextStyle(
                                    color: AppColors.lightBlack,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Container(
                                  height: 1,
                                  width: 100,
                                  color: Colors.grey[300],
                                ),
                              ],
                            ),
                            widget.isAutor
                                ? Row(
                                    children: [
                                      SizedBox(width: 13),
                                      Container(
                                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: AppColors.orange,
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        child: Text(
                                          'Autor',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 55),
                              child: Text(
                                widget.text ?? 'Thank you!',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.grey,
                                  height: 1.36,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 45),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 40,
                                    child: IconButton(
                                      onPressed: () => setState(() => _replyLike = !_replyLike),
                                      icon: _replyLike
                                          ? SvgPicture.asset(
                                              'assets/images/reply.svg',
                                            )
                                          : SvgPicture.asset(
                                              'assets/images/reply_outline.svg',
                                              height: 16,
                                              color: AppColors.orange,
                                            ),
                                    ),
                                  ),
                                  Text(
                                    '1 reply',
                                    style: TextStyle(
                                      color: AppColors.lightBlack,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 80,
                                    child: FlatButton(
                                      highlightColor: Colors.transparent,
                                      onPressed: () {
                                        if (widget.focusNode.hasFocus) {
                                          setState(() {
                                            FocusScope.of(context).unfocus();
                                            Future.delayed(Duration(milliseconds: 300), () {
                                              FocusScope.of(context).requestFocus(widget.focusNode);
                                            });
                                          });
                                        } else {
                                          setState(() {
                                            FocusScope.of(context).requestFocus(widget.focusNode);
                                          });
                                        }
                                      },
                                      child: Text(
                                        'Reply',
                                        style: TextStyle(
                                          color: AppColors.orange,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
