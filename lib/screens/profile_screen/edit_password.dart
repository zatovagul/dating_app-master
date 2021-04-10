import 'package:dating_app/widgets/bordered_container.dart';
import 'package:dating_app/widgets/custom_textfield.dart';
import 'package:dating_app/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:dating_app/resourses/colors.dart';

class EditPassword extends StatelessWidget {
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
        title: Text(
          'Change password',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: AppColors.lightBronze,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onPanDown: (_) {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: ListView(
            shrinkWrap: true,
            children: [
              BorderedContainer(
                children: [
                  CustomTextField(hintText: 'Old', isFull: true),
                  SizedBox(height: 15),
                  context.width > 500
                      ? Row(
                          children: [
                            CustomTextField(hintText: 'New', isFull: false),
                            SizedBox(width: 10),
                            CustomTextField(hintText: 'Repeat', isFull: false),
                          ],
                        )
                      : Column(
                          children: [
                            CustomTextField(hintText: 'New', isFull: true),
                            SizedBox(height: 15),
                            CustomTextField(hintText: 'Repeat', isFull: true),
                          ],
                        ),
                  SizedBox(height: 15),
                  OrangeButton(
                    text: 'Change',
                    onTap: () {
                      Get.back();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
