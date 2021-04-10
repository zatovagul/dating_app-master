import 'package:dating_app/widgets/bordered_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthBlock extends StatelessWidget {
  final List<Widget> children;

  AuthBlock({this.children});

  bool isTablet;
  bool isBigTablet;
  @override
  Widget build(BuildContext context) {
    isTablet = context.mediaQuerySize.width > 500;
    isBigTablet = context.mediaQuerySize.width > 1000;
    return BorderedContainer(
      crossAxisAlignment:
      isTablet ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisAlignment:
      isTablet ? MainAxisAlignment.center : MainAxisAlignment.start,
      isTablet: context.isTablet,
      height: !context.isTablet ? context.mediaQuerySize.height * 0.7 : null,
      padding: isTablet
          ? EdgeInsets.only(
          left: isBigTablet
              ? context.mediaQuerySize.width * 0.2
              : context.mediaQuerySize.width * 0.1,
          right: isBigTablet
              ? context.mediaQuerySize.width * 0.2
              : context.mediaQuerySize.width * 0.1,
          top: 30,
          bottom: 25)
          : EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 25),
      children: children,
    );
  }
}