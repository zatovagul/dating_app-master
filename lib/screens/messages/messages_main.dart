import 'dart:io';
import 'package:dating_app/data/data.dart';
import 'package:dating_app/widgets/multiSelectItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dating_app/resourses/colors.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../states.dart';
import 'message.dart';

class MessagesMain extends StatefulWidget {
  @override
  _MessagesMainState createState() => _MessagesMainState();
}

class _MessagesMainState extends State<MessagesMain> {
  MultiSelectController controller = MultiSelectController();

  void cupertinoAlert() {
    showCupertinoDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('Are you sure?'),
            content: Text('You cannot cancel this action.'),
            actions: [
              CupertinoDialogAction(
                isDestructiveAction: true,
                onPressed: () {
                  Get.back();
                  setState(() {
                    controller.deselectAll();
                  });
                },
                child: Text('Yes'),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  Get.back();
                  setState(() {
                    controller.deselectAll();
                  });
                },
                child: Text('No'),
              ),
            ],
          );
        });
  }

  void materialAlert() {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Are you sure?'),
            content: Text('You cannot cancel this action.'),
            actions: [
              FlatButton(
                onPressed: () {
                  Get.back();
                  setState(() {
                    controller.deselectAll();
                  });
                },
                child: Text(
                  'Yes',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {
                  Get.back();
                  setState(() {
                    controller.deselectAll();
                  });
                },
                child: Text('No'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.light,
      appBar: AppBar(
        leading: controller.selectedIndexes.length == 0
            ? IconButton(
                highlightColor: Colors.white,
                onPressed: () {
                  Get.back();
                },
                icon: SvgPicture.asset('assets/images/appbar_arrow_left.svg', height: 20, width: 20),
              )
            : SizedBox(height: 0, width: 0),
        centerTitle: controller.selectedIndexes.length == 0 ? true : false,
        leadingWidth: controller.selectedIndexes.length < 1 ? 50 : 15,
        title: controller.selectedIndexes.length == 0
            ? Text(
                'Messages',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
              )
            : Row(
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      Platform.isIOS ? cupertinoAlert() : materialAlert();
                    },
                    child: Container(
                      height: 35,
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/images/basket.svg'),
                          SizedBox(width: 11),
                          Text(
                            'Basket',
                            style: TextStyle(
                              color: Color(0xFF161616),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 25),
                  SvgPicture.asset('assets/images/block_message.svg'),
                  SizedBox(width: 11),
                  Text(
                    'Blocked users',
                    style: TextStyle(
                      color: Color(0xFF161616),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
        elevation: 0,
        backgroundColor: AppColors.light,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            width: 50,
            height: 5,
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                setState(() {
                  controller.selectedIndexes.length == 0 ? null : controller.deselectAll();
                });
              },
              child: Center(
                child: controller.selectedIndexes.length != 0
                    ? SvgPicture.asset(
                        'assets/images/cross.svg',
                        color: AppColors.orange,
                        width: 14,
                        height: 14,
                      )
                    : Container(),
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(bottom: 5),
        itemBuilder: (context, i) {
          return MultiSelectItem(
            isSelecting: controller.isSelecting,
            onTap: () {
              Get.to(Messages(
                name: Lists.listTopUsersName[i],
                avatar: Lists.listTopUsers[i],
                isOnline: i == 0 ? true : false,
              ));
            },
            onSelected: () {
              setState(() {
                controller.toggle(i);
              });
            },
            child: MessagesMini(
              avatar: Lists.listTopUsers[i],
              name: Lists.listTopUsersName[i],
              isOnline: i == 0 ? true : false,
              isNewMessage: i == 0 ? true : false,
              controller: controller,
              index: i,
            ),
          );
        },
        itemCount: 5,
      ),
    );
  }
}

class MessagesMini extends StatelessWidget {
  final String avatar;
  final String name;
  final bool isOnline;
  final bool isNewMessage;
  final MultiSelectController controller;
  final int index;

  MessagesMini({this.avatar, this.name, this.isOnline, this.isNewMessage, this.controller, this.index});

  AppStates appStates = Get.put(AppStates());

  String timeFormat(DateTime dateTime) {
    return DateFormat.jm().format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          padding: EdgeInsets.symmetric(vertical: 19.5, horizontal: 15),
          height: 100,
          width: context.mediaQuerySize.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Center(
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
                      controller.isSelected(index)
                          ? Container(
                              height: 33,
                              width: 33,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Center(child: SvgPicture.asset('assets/images/selected_message.svg')))
                          : Container(),
                    ],
                  ),
                  isOnline
                      ? Align(
                          alignment: Alignment.bottomRight,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                  height: 15.42,
                                  width: 15.42,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  )),
                              Container(
                                height: 12.42,
                                width: 12.42,
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
              SizedBox(width: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                        ),
                      ),
                      SizedBox(width: 5),
                      Obx(
                        () => Text(
                          timeFormat(appStates.messages.value.last.dateTime),
                          style: TextStyle(
                            color: AppColors.grey,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    width: context.mediaQuerySize.width - 131,
                    child: Obx(
                      () => Text(
                        '${appStates.messages.value.last.text}',
                        style: TextStyle(
                          fontSize: 16,
                          color: isNewMessage ? AppColors.orange : AppColors.lightBlack,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        controller.selectedIndexes.length > 0
            ? controller.isSelected(index)
                ? Container()
                : Opacity(
                    opacity: 0.6,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      padding: EdgeInsets.symmetric(vertical: 19.5, horizontal: 15),
                      height: 100,
                      width: context.mediaQuerySize.width,
                      decoration: BoxDecoration(
                        color: AppColors.light,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  )
            : Container()
      ],
    );
  }
}
