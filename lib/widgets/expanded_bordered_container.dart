import 'package:dating_app/states.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ExpandedBorderedContainer extends StatelessWidget {
  final List<Widget> childrenMinimized;
  final List<Widget> childrenMaximized;

  ExpandedBorderedContainer({this.childrenMinimized, this.childrenMaximized});

  AppStates appStates = Get.put(AppStates());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        appStates.isMaximizedContainer.value = true;
        print(appStates.isMaximizedContainer.value);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Obx(
              () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: appStates.isMaximizedContainer.value ? childrenMaximized : childrenMinimized,
          ),
        ),
      ),
    );
  }
}