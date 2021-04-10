import 'package:flutter/material.dart';

class BorderedContainer extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsetsGeometry padding;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final double height;
  final bool isTablet;
  final bool bottomWithoutCircular;
  final BoxConstraints constraints;

  BorderedContainer({this.children, this.padding, this.mainAxisAlignment, this.crossAxisAlignment, this.height, this.isTablet, this.constraints, this.bottomWithoutCircular = false});

  @override
  Widget build(BuildContext context) {
    return height != null && isTablet
        ? Container(
            padding: padding ?? EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 25),
            margin: const EdgeInsets.symmetric(vertical: 5),
            height: height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
              mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
              children: children,
            ),
          )
        : Container(
            constraints: constraints ?? BoxConstraints(),
            padding: padding ?? EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 25),
            margin: bottomWithoutCircular?null:const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: bottomWithoutCircular ? BorderRadius.vertical(top: Radius.circular(20)) : BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
              mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
              children: children,
            ),
          );
  }
}
