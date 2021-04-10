import 'package:dating_app/data/data.dart';
import 'package:dating_app/screens/add_feedback_screen/add_feedback.dart';
import 'package:dating_app/screens/home_screen/feedback.dart';
import 'package:dating_app/resourses/colors.dart';
import 'package:emojis/emoji.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:super_tooltip/super_tooltip.dart';
import 'package:dating_app/widgets/smiles.dart';
import '../states.dart';
import 'AutoCompeleteTxtField.dart';
import 'AutoCompeleteTxtFieldSearchTags.dart';
import 'AutoCompleteTxtFieldSearchCountry.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class Draft extends StatefulWidget {
  final String draftTitle;
  final String draftText;
  final String downText;

  Draft({this.draftText, this.downText, this.draftTitle});

  @override
  _DraftState createState() => _DraftState();
}

class _DraftState extends State<Draft> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 33, bottom: 20),
      width: context.mediaQuerySize.width > 500 ? context.mediaQuerySize.width / 2 - 15 : context.mediaQuerySize.width,
      height: 199,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.draftTitle,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: 'Gothic',
              color: AppColors.black,
              fontSize: 24,
              height: 1.36,
            ),
          ),
          Text(
            widget.draftText,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontFamily: 'Gothic',
              color: AppColors.black,
              fontSize: 18,
              height: 1.36,
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(AddFeedback(title: widget.draftTitle, story: widget.draftText));
            },
            child: Row(
              children: [
                Text(
                  widget.downText,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Gothic',
                    color: AppColors.orange,
                    fontSize: 16,
                    height: 1.36,
                  ),
                ),
                SizedBox(width: 15),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: SvgPicture.asset(
                    'assets/images/arrow_right.svg',
                    width: 27,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class LastComment extends StatelessWidget {
  final String comment;
  final String downText;

  LastComment({this.comment, this.downText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 33, bottom: 20),
      width: context.mediaQuerySize.width > 500 ? context.mediaQuerySize.width / 2 - 15 : context.mediaQuerySize.width,
      height: 199,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset('assets/images/comments_union.svg'),
          Text(
            comment,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontFamily: 'Gothic',
              color: AppColors.black,
              fontSize: 18,
              height: 1.36,
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(FullFeedback(
                null/*TODO*/
              ));
            },
            child: Row(
              children: [
                Text(
                  downText,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Gothic',
                    color: AppColors.orange,
                    fontSize: 16,
                    height: 1.36,
                  ),
                ),
                SizedBox(width: 15),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: SvgPicture.asset(
                    'assets/images/arrow_right.svg',
                    width: 27,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CountOfCommentsText extends StatelessWidget {
  final int count;

  CountOfCommentsText({Key key, this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
      child: Text(
        '$count comments',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 24,
          color: AppColors.black,
        ),
      ),
    );
  }
}

class MyCommentContainer extends StatefulWidget {
  final FocusNode focusNode;
  final String replyFrom;
  MyCommentContainer({this.focusNode, this.replyFrom});
  @override
  _MyCommentContainerState createState() => _MyCommentContainerState();
}

class _MyCommentContainerState extends State<MyCommentContainer> {
  List<Asset> images = List<Asset>();
  Future<void> loadAssets() async {
    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        selectedAssets: images ?? [],
      );
    } on Exception catch (e) {
      print('Exception: $e');
      error = e.toString();
    }

    if (!mounted) return;
    setState(() {
      if (resultList != null) images = resultList;
      if (error == null) error = 'No Error Dectected';
    });
  }

  Widget buildGridView() {
    return SizedBox(
      height: 100,
      child: GridView.count(
          scrollDirection: Axis.horizontal,
          crossAxisCount: 1,
          children: List<Widget>.generate(images.length, (index) {
            Asset asset = images[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: AssetThumb(
                      asset: asset,
                      width: 300,
                      height: 300,
                    ),
                  ),
                  Positioned(
                    top: -5,
                    right: -5,
                    child: IconButton(
                      onPressed: () => setState(() => images.removeAt(index)),
                      icon: Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                          child: SvgPicture.asset(
                            'assets/images/icn-delete.svg',
                            color: AppColors.grey,
                          )),
                    ),
                  ),
                ],
              ),
            );
          })),
    );
  }

  AppStates appStates = Get.put(AppStates());

  final smiles = Emoji.byGroup(EmojiGroup.smileysEmotion).toList();

  final loveEmojis = Emoji.byKeyword('face');
  bool isOpenSmiles = false;
  TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
  }

  void onSmileTap(int index, Iterable<Emoji> loveEmojis) {
    final emoji = loveEmojis.elementAt(index);
    setState(() {
      textController.text = textController.text + emoji.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.black,
      elevation: 8,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        width: context.mediaQuerySize.width,
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          color: Colors.white,
        ),
        child: Column(
          children: [
            if (widget.replyFrom != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Reply to: ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey,
                      height: 1.36,
                    ),
                  ),
                  Text(
                    widget.replyFrom,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black,
                      height: 1.36,
                    ),
                  ),
                ],
              ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                Container(
                  width: context.mediaQuerySize.width - 80,
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.lightBronze,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          onTap: () {
                            setState(() => isOpenSmiles = false);
                          },
                          focusNode: widget.focusNode,
                          controller: textController,
                          onChanged: (value) {
                            setState(() {});
                          },
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.lightBlack,
                            height: 1.48,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Comment...',
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: AppColors.grey,
                            ),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                          // cursorWidth: 0,
                          // cursorHeight: 0,
                          cursorColor: AppColors.black,
                          minLines: 1,
                          maxLines: 10,
                        ),
                      ),
                      IconButton(
                        highlightColor: Colors.white,
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          setState(() {
                            isOpenSmiles = !isOpenSmiles;
                          });
                        },
                        icon: SvgPicture.asset(
                          'assets/images/smile.svg',
                          color: isOpenSmiles ? AppColors.orange : AppColors.grey,
                        ),
                      ),
                      IconButton(
                        onPressed: loadAssets,
                        icon: SvgPicture.asset('assets/images/upload_picture.svg'),
                      ),
                      (textController.text.isNotEmpty || (images != null && images?.length > 0))
                          ? IconButton(
                              onPressed: () {},
                              icon: SvgPicture.asset('assets/images/send_message.svg'),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),
            if (images != null && images?.length > 0) buildGridView(),
            if (isOpenSmiles)
              SmilesWidget(
                close: closeTap,
                context: context,
                onSmileTap: onSmileTap,
              ),
          ],
        ),
      ),
    );
  }

  void closeTap() {
    setState(() {
      isOpenSmiles = false;
    });
  }
}

class GradientButton extends StatelessWidget {
  final String text;
  final GestureTapCallback onTap;
  final bool isMargin;
  final double height;

  GradientButton({this.text, this.onTap, this.isMargin, this.height});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: isMargin == null || isMargin == true ? EdgeInsets.symmetric(horizontal: 5, vertical: 30) : EdgeInsets.zero,
        alignment: Alignment.center,
        width: context.mediaQuerySize.width,
        height: height ?? 58,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
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
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            height: 1,
          ),
        ),
      ),
    );
  }
}

class ProfileGradientButton extends StatelessWidget {
  final String text;
  final GestureTapCallback onTap;

  ProfileGradientButton({this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Wrap(
        children: [
          Container(
            alignment: Alignment.center,
            width: context.mediaQuerySize.width < 500 ? context.mediaQuerySize.width * 0.52 : 205,
            height: 41,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              gradient: LinearGradient(
                colors: [
                  AppColors.orange,
                  AppColors.mistake,
                ],
                stops: [0, 1],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.48,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FollowerGradientButton extends StatelessWidget {
  final String text;
  final GestureTapCallback onTap;

  FollowerGradientButton({this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Wrap(
        children: [
          Container(
            alignment: Alignment.center,
            width: context.mediaQuerySize.width < 500 ? context.mediaQuerySize.width * 0.52 : context.mediaQuerySize.width / 3.65,
            height: 41,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              gradient: LinearGradient(
                colors: [
                  AppColors.orange,
                  AppColors.mistake,
                ],
                stops: [0, 1],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.48,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OrangeButton extends StatelessWidget {
  final String text;
  final GestureTapCallback onTap;

  OrangeButton({this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: context.mediaQuerySize.width,
        height: 58,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: AppColors.orange,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            height: 1,
          ),
        ),
      ),
    );
  }
}

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onToggle;

  CustomCheckbox({this.value, this.onToggle});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      highlightColor: Colors.transparent,
      onPressed: () {
        onToggle(!value);
      },
      icon: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        height: 20,
        width: 20,
        decoration: BoxDecoration(
          color: value ? AppColors.orange : Colors.transparent,
          border: Border.all(
            color: AppColors.orange,
          ),
          borderRadius: BorderRadius.circular(2),
        ),
        child: value
            ? Center(
                child: SvgPicture.asset(
                  'assets/images/checkbox_check.svg',
                  width: 10,
                ),
              )
            : SizedBox(),
      ),
    );
  }
}

class SwitchBox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onToggle;
  final bool checkIcon;
  final Color backgroundColor;

  SwitchBox({this.value, this.onToggle, this.checkIcon, this.backgroundColor});

  var darkSwitchOn = false.obs;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        darkSwitchOn.value = !darkSwitchOn.value;
        onToggle(!value);
      },
      child: Container(
        height: 34,
        width: 55,
        padding: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              duration: Duration(milliseconds: 200),
              alignment: value ? Alignment.centerRight : Alignment.centerLeft,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                margin: EdgeInsets.all(1.5),
                height: 22,
                width: 22,
                decoration: BoxDecoration(
                  color: value ? AppColors.orange : Color(0xFFD6D2CC),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: checkIcon != null && checkIcon != false
                    ? Center(
                        child: SvgPicture.asset('assets/images/check_conditions.svg'),
                      )
                    : SizedBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextWithSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onToggle;
  final String text;
  final bool checkIcon;
  final bool withQuestion;

  TextWithSwitch({this.value, this.onToggle, this.text, this.checkIcon, this.withQuestion});

  SuperTooltip tooltip = SuperTooltip(
      popupDirection: TooltipDirection.down,
      showCloseButton: ShowCloseButton.inside,
      closeButtonColor: AppColors.orange,
      shadowColor: AppColors.lightBlack.withOpacity(0.5),
      shadowBlurRadius: 30,
      shadowSpreadRadius: 10,
      left: 50,
      maxWidth: 200,
      borderWidth: 1,
      arrowLength: 0,
      arrowBaseWidth: 0,
      arrowTipDistance: 20,
      borderColor: AppColors.orange,
      content: Material(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 18),
          child: Text(
            'If you do not want your name to be displayed, then enable this function.',
            style: TextStyle(
              color: AppColors.black,
              height: 1.3,
            ),
          ),
        ),
      ));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                text,
                style: TextStyle(
                  color: AppColors.lightBlack,
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
              ),
              withQuestion != null && withQuestion == true ? SizedBox(width: 8) : Container(),
              withQuestion != null && withQuestion == true
                  ? InkWell(
                      onTap: () {
                        tooltip.show(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 22,
                        width: 22,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.orange, width: 1),
                        ),
                        child: Text(
                          '?',
                          style: TextStyle(
                            color: AppColors.orange,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
          SwitchBox(
            value: value,
            onToggle: onToggle,
            checkIcon: checkIcon,
          ),
        ],
      ),
    );
  }
}

class CustomAutoCompleteTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final int maxLines;
  final int minLines;
  final double rightPadding;
  final void Function(String) onSubmited;

  CustomAutoCompleteTextField({this.hintText, this.controller, this.maxLines, this.minLines, this.rightPadding, this.onSubmited});

  @override
  Widget build(BuildContext context) {
    return AutoCompeleteTextField(
      suggestions: Lists.tagsSuggestions,
      controller: controller,
      collapsed: false,
      onTextSubmited: onSubmited,
      style: TextStyle(
        color: AppColors.lightBlack,
        fontSize: 16,
        height: 1.48,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.light,
        contentPadding: EdgeInsets.only(left: 20, right: rightPadding ?? 20, top: 20, bottom: 20),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.grey,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.light,
          ),
          borderRadius: BorderRadius.circular(7.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.light,
          ),
          borderRadius: BorderRadius.circular(7.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.light,
          ),
          borderRadius: BorderRadius.circular(7.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.light,
          ),
          borderRadius: BorderRadius.circular(7.0),
        ),
      ),
    );
  }
}

class CustomAutoCompleteTextFieldSearchTags extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final int maxLines;
  final int minLines;
  final double rightPadding;
  final void Function(String) onSubmited;
  final AppStatesInterface appStates;
  CustomAutoCompleteTextFieldSearchTags({
    this.hintText,
    this.controller,
    this.maxLines,
    this.minLines,
    this.rightPadding,
    this.onSubmited,
    @required this.appStates,
  });

  @override
  Widget build(BuildContext context) {
    return AutoCompeleteTextFieldSearchTags(
      appStates: appStates,
      suggestions: Lists.tagsSuggestions,
      controller: controller,
      collapsed: true,
      onTextSubmited: onSubmited,
      style: TextStyle(
        color: AppColors.lightBlack,
        fontSize: 16,
        height: 1.48,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.light,
        contentPadding: EdgeInsets.only(left: 20, right: rightPadding ?? 20, top: 20, bottom: 20),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.grey,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.light,
          ),
          borderRadius: BorderRadius.circular(7.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.light,
          ),
          borderRadius: BorderRadius.circular(7.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.light,
          ),
          borderRadius: BorderRadius.circular(7.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.light,
          ),
          borderRadius: BorderRadius.circular(7.0),
        ),
      ),
    );
  }
}

class CustomAutoCompleteTextFieldSearchCountry extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final int maxLines;
  final int minLines;
  final double rightPadding;
  final void Function(String) onSubmited;
  final void Function(String) onChanged;

  CustomAutoCompleteTextFieldSearchCountry({this.hintText, this.controller, this.maxLines, this.minLines, this.rightPadding, this.onSubmited, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return AutoCompeleteTextFieldSearchCountry(
      onChanged: onChanged,
      suggestions: Lists.tagsSuggestions,
      controller: controller,
      onTextSubmited: onSubmited,
      style: TextStyle(
        color: AppColors.lightBlack,
        fontSize: 16,
        height: 1.48,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.light,
        contentPadding: EdgeInsets.only(left: 20, right: rightPadding ?? 20, top: 20, bottom: 20),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.grey,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.light,
          ),
          borderRadius: BorderRadius.circular(7.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.light,
          ),
          borderRadius: BorderRadius.circular(7.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.light,
          ),
          borderRadius: BorderRadius.circular(7.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.light,
          ),
          borderRadius: BorderRadius.circular(7.0),
        ),
      ),
    );
  }
}
