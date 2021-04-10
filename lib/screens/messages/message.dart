import 'package:dating_app/screens/home_screen/profile_page.dart';
import 'package:dating_app/widgets/bordered_container.dart';
import 'package:dating_app/widgets/multiSelectItem.dart';
import 'package:dating_app/widgets/smiles.dart';
import 'package:emojis/emoji.dart';
import 'package:flutter/cupertino.dart';
import 'package:dating_app/resourses/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import '../../states.dart';

class Messages extends StatefulWidget {
  final String avatar;
  final String name;
  final bool isOnline;

  Messages({this.avatar, this.name, this.isOnline});

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
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
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      onPressed: () => setState(() => images.removeAt(index)),
                      icon: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                        child: SvgPicture.asset(
                          'assets/images/icn-delete.svg',
                          color: AppColors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          })),
    );
  }

  MultiSelectController controller = MultiSelectController();
  GroupedItemScrollController _scrollController = GroupedItemScrollController();
  TextEditingController textController = TextEditingController();
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  // final smiles = Emoji.byGroup(EmojiGroup.smileysEmotion).toList();

  bool _showSmiles = false;

  String timeFormat(DateTime dateTime) {
    return DateFormat.jm().format(dateTime);
  }

  String getMonth(int month) {
    switch (month) {
      case 1:
        return 'Января';
      case 2:
        return 'Февраля';
      case 3:
        return 'Марта';
      case 4:
        return 'Апреля';
      case 5:
        return 'Мая';
      case 6:
        return 'Июня';
      case 7:
        return 'Июля';
      case 8:
        return 'Августа';
      case 9:
        return 'Сентября';
      case 10:
        return 'Октября';
      case 11:
        return 'Ноября';
      case 12:
        return 'Декабря';
    }
  }

  @override
  void initState() {
    super.initState();
  }

  onSmileTap(int index, Iterable<Emoji> loveEmojis) {
    final emoji = loveEmojis.elementAt(index);
    setState(() {
      textController.text = textController.text + emoji.toString();
    });
  }

  ///
  AppStates appStates = Get.put(AppStates());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
      backgroundColor: AppColors.light,
      appBar: AppBar(
        leading: controller.selectedIndexes.length < 1
            ? IconButton(
                onPressed: () {
                  Get.back();
                },
                highlightColor: Colors.white,
                icon: SvgPicture.asset(
                  'assets/images/appbar_arrow_left.svg',
                  height: 20,
                  width: 20,
                ),
              )
            : SizedBox(height: 0, width: 0),
        centerTitle: controller.selectedIndexes.length < 1 ? true : false,
        titleSpacing: 0,
        leadingWidth: controller.selectedIndexes.length < 1 ? null : 15,
        title: controller.selectedIndexes.length < 1
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(Profile());
                        },
                        child: Center(
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(widget.avatar),
                              ),
                            ),
                          ),
                        ),
                      ),
                      widget.isOnline
                          ? Align(
                              alignment: Alignment.bottomRight,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: 12.42,
                                    width: 12.42,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Container(
                                    height: 9.42,
                                    width: 9.42,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.orange,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                    ],
                  ),
                  SizedBox(width: 15),
                  Text(
                    '${widget.name}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  Text(
                    '${controller.selectedIndexes.length} messages',
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 15),
                  InkWell(
                    highlightColor: Colors.transparent,
                    onTap: () {
                      setState(() {
                        controller.deselectAll();
                      });
                    },
                    child: SvgPicture.asset(
                      'assets/images/cross.svg',
                      height: 14,
                      width: 14,
                    ),
                  ),
                ],
              ),
        elevation: 0,
        backgroundColor: AppColors.light,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              highlightColor: Colors.white,
              onPressed: () {
                controller.selectedIndexes.length < 1
                    ? showCupertinoModalPopup(
                        context: context,
                        builder: (context) {
                          return CupertinoActionSheet(
                            actions: [
                              CupertinoActionSheetAction(
                                child: Text('Block user'),
                                isDestructiveAction: false,
                                onPressed: () {
                                  print('Action 1 printed');
                                },
                              ),
                              CupertinoActionSheetAction(
                                child: Text('Clear history'),
                                isDestructiveAction: false,
                                onPressed: () {
                                  print('Action 1 printed');
                                },
                              ),
                              CupertinoActionSheetAction(
                                child: Text('Mark as spam'),
                                isDestructiveAction: false,
                                onPressed: () {
                                  print('Action 1 printed');
                                },
                              ),
                              CupertinoActionSheetAction(
                                child: Text('Delete chat'),
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
                      )
                    : showCupertinoModalPopup(
                        context: context,
                        builder: (context) {
                          return CupertinoActionSheet(
                            actions: [
                              CupertinoActionSheetAction(
                                child: Text('Forward'),
                                isDestructiveAction: false,
                                onPressed: () {
                                  print('Action 1 printed');
                                },
                              ),
                              CupertinoActionSheetAction(
                                child: Text('Delete'),
                                isDestructiveAction: true,
                                onPressed: () {
                                  for (int i = 0; i < appStates.messages.value.length; i++) {
                                    for (int a = 0; a < controller.selectedIndexes.length; i++) {
                                      if (appStates.messages.value[i] == appStates.messages.value[a]) {
                                        appStates.messages.value.remove(appStates.messages.value[a]);
                                      }
                                    }
                                  }
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
                ;
              },
              icon: SvgPicture.asset(
                'assets/images/more_horizontal.svg',
                color: AppColors.orange,
                width: 14,
                height: 14,
              ),
            ),
          ),
        ],
      ),
      body: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: 0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  //  borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                  color: Colors.white,
                ),

                width: context.mediaQuerySize.width,
                //padding: EdgeInsets.all(7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      highlightColor: Colors.transparent,
                      onPressed: loadAssets,
                      icon: SvgPicture.asset(
                        'assets/images/upload_picture_message.svg',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        bottom: 5,
                      ),
                      child: Container(
                        width: context.mediaQuerySize.width - 180,
                        child: textInputField(context),
                      ),
                    ),
                    IconButton(
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        setState(() => _showSmiles = !_showSmiles);
                      },
                      icon: SvgPicture.asset(
                        'assets/images/smile_message.svg',
                        width: 25,
                        color: _showSmiles ? Color(0xFFFF6647) : null,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: IconButton(
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        onPressed: () {
                          if (textController.text.isNotEmpty)
                            appStates.messages.value.add(
                              Message(
                                text: textController.text,
                                toMe: false,
                                dateTime: DateTime.now(),
                              ),
                            );
                          if ((images?.length ?? 0) > 0) {
                            images.forEach((e) {
                              appStates.messages.value.add(
                                Message(
                                  asset: e,
                                  toMe: false,
                                  dateTime: DateTime.now(),
                                ),
                              );
                            });
                            images.clear();
                          }
                          setState(() {
                            if (textController.text.isNotEmpty) _scrollController.jumpTo(index: appStates.messages.value.length - 1);
                            textController.clear();
                          });
                        },
                        icon: Padding(
                          padding: const EdgeInsets.only(bottom: 2),
                          child: SvgPicture.asset(
                            'assets/images/send_message.svg',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (images != null && images?.length > 0) buildGridView(),
              if (_showSmiles)
                SmilesWidget(
                  close: closeTap,
                  context: context,
                  onSmileTap: onSmileTap,
                ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: BorderedContainer(
            bottomWithoutCircular: true,
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 0),
            children: [
              Expanded(
                child: Obx(() => StickyGroupedListView<Message, DateTime>(
                      floatingHeader: true,
                      initialScrollIndex: appStates.messages.value.length - 1,
                      groupBy: (message) => DateTime(message.dateTime.year, message.dateTime.month, message.dateTime.day),
                      stickyHeaderBackgroundColor: Colors.transparent,
                      groupSeparatorBuilder: (message) => Container(
                        height: 33,
                        margin: EdgeInsets.only(top: 10),
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 33,
                            padding: EdgeInsets.symmetric(horizontal: 14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: AppColors.lightGrey,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${message.dateTime.day} ${getMonth(message.dateTime.month)}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      itemScrollController: _scrollController,
                      padding: EdgeInsets.only(top: 0),
                      elements: appStates.messages.value,
                      indexedItemBuilder: (context, message, i) => MultiSelectItem(
                        isSelecting: controller.isSelecting,
                        onTap: () {},
                        onSelected: () {
                          setState(() {
                            controller.toggle(i);
                          });
                          print(controller.selectedIndexes);
                        },
                        child: Row(
                          mainAxisAlignment: controller.selectedIndexes.length < 1
                              ? message.toMe
                                  ? MainAxisAlignment.start
                                  : MainAxisAlignment.end
                              : message.toMe
                                  ? MainAxisAlignment.start
                                  : MainAxisAlignment.spaceBetween,
                          children: [
                            controller.selectedIndexes.length < 1
                                ? Container()
                                : Container(
                                    height: 23,
                                    width: 23,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: AppColors.orange,
                                        width: 2,
                                      ),
                                    ),
                                    child: Center(
                                      child: controller.isSelected(i) ? SvgPicture.asset('assets/images/check_message_chat.svg') : Container(),
                                    ),
                                  ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: message.toMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: appStates.messages.value.length >= 2 ? 10 : 40),
                                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                                  constraints: BoxConstraints(minWidth: 50, maxWidth: context.mediaQuerySize.width * 0.75, minHeight: 52, maxHeight: context.mediaQuerySize.height * 10),
                                  decoration: BoxDecoration(
                                    color: controller.isSelected(i)
                                        ? Color(0xFFFFC2B5)
                                        : message.toMe
                                            ? AppColors.lightBronze
                                            : Color(0xFFFAF9F8),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                      bottomLeft: Radius.circular(message.toMe ? 0 : 15),
                                      bottomRight: Radius.circular(message.toMe ? 15 : 0),
                                    ),
                                  ),
                                  child: message.text == null
                                      ? AssetThumb(
                                          asset: message.asset,
                                          width: 300,
                                          height: 400,
                                        )
                                      : Text(
                                          message.text,
                                          style: TextStyle(
                                            color: AppColors.lightBlack,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            height: 1.24,
                                          ),
                                        ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  timeFormat(message.dateTime),
                                  style: TextStyle(
                                    color: AppColors.grey,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    height: 1,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void closeTap() {
    setState(() {
      _showSmiles = false;
    });
  }

  Widget textInputField(BuildContext context) {
    return TextField(
      textCapitalization: TextCapitalization.sentences,
      onTap: () => setState(() => _showSmiles = false),
      onSubmitted: (text) {
        appStates.messages.value.add(
          Message(
            text: textController.text,
            toMe: false,
            dateTime: DateTime.now(),
          ),
        );
        setState(() {
          _scrollController.jumpTo(index: appStates.messages.value.length - 1);
          textController.clear();
        });
      },
      controller: textController,
      textInputAction: TextInputAction.send,
      keyboardType: TextInputType.text,
      cursorColor: AppColors.grey,
      maxLines: 5,
      minLines: 1,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.lightBlack,
        height: 1.48,
      ),
      decoration: InputDecoration(
        isDense: true,
        hintText: 'Write a message...',
        hintStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.grey,
          height: 1.48,
        ),
        contentPadding: EdgeInsets.all(0),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
    );
  }
}

class Message {
  final String text;
  final bool toMe;
  final DateTime dateTime;
  final Asset asset;
  Message({
    this.text,
    this.toMe,
    this.dateTime,
    this.asset,
  });
}
