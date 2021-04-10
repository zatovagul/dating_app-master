import 'package:dating_app/widgets/bordered_container.dart';
import 'package:dating_app/widgets/custom_textfield.dart';
import 'package:dating_app/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:menu_button/menu_button.dart';
import 'package:dating_app/resourses/colors.dart';

class Support extends StatelessWidget {
  var _value = 'Type'.obs;
  var check = false.obs;
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
          icon: Center(
            child: SvgPicture.asset(
              'assets/images/appbar_arrow_left.svg',
              height: 20,
              width: 20,
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Support',
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
                  context.width > 500
                      ? Row(
                          children: [
                            CustomTextField(
                              hintText: 'Name',
                              isFull: false,
                            ),
                            SizedBox(width: 10),
                            CustomTextField(
                              hintText: 'Email',
                              isFull: false,
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            CustomTextField(
                              hintText: 'Name',
                              isFull: true,
                            ),
                            SizedBox(height: 15),
                            CustomTextField(
                              hintText: 'Email',
                              isFull: true,
                            ),
                          ],
                        ),
                  SizedBox(height: 15),
                  context.width > 500
                      ? Row(
                          children: [
                            Container(
                              height: 65,
                              child: MenuButton(
                                child: SizedBox(
                                  width: context.mediaQuerySize.width / 2 - 30,
                                  height: 45,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20, right: 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Flexible(child: Obx(() => Text(_value.value))),
                                        SvgPicture.asset('assets/images/icn_arrow_down.svg'),
                                      ],
                                    ),
                                  ),
                                ), // Widget displayed as the button
                                items: List.generate(
                                  5,
                                  (index) => Text('Type$index'),
                                ), // List of your items
                                topDivider: true,
                                scrollPhysics: AlwaysScrollableScrollPhysics(), // Change the physics of opened menu (example: you can remove or add scroll to menu)
                                itemBuilder: (value) => Container(
                                    width: context.mediaQuerySize.width,
                                    height: 45,
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 10,
                                    ),
                                    child: value), // Widget displayed for each item
                                toggledChild: Container(
                                  color: AppColors.light,
                                  child: SizedBox(
                                    width: context.mediaQuerySize.width,
                                    height: 45,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Obx(() => Text(_value.value)),
                                          SvgPicture.asset('assets/images/icn_arrow_down.svg'),
                                        ],
                                      ),
                                    ),
                                  ), // Widget displayed as the button,
                                ),
                                divider: Container(
                                  height: 0,
                                  color: Colors.grey,
                                ),
                                onItemSelected: (value) {
                                  _value.value = value;
                                  // Action when new item is selected
                                },
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(7.0),
                                  ),
                                  color: AppColors.light,
                                ),
                                onMenuButtonToggle: (isToggle) {},
                              ),
                            ),
                            SizedBox(width: 10),
                            CustomTextField(hintText: 'Title', isFull: false),
                          ],
                        )
                      : Column(
                          children: [
                            Container(
                              height: 65,
                              child: MenuButton(
                                child: SizedBox(
                                  width: context.mediaQuerySize.width,
                                  height: 45,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20, right: 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Flexible(child: Obx(() => Text(_value.value))),
                                        SvgPicture.asset('assets/images/icn_arrow_down.svg'),
                                      ],
                                    ),
                                  ),
                                ), // Widget displayed as the button
                                items: List.generate(
                                  5,
                                  (index) => Text('Type$index'),
                                ), // List of your items
                                topDivider: true,
                                scrollPhysics: AlwaysScrollableScrollPhysics(), // Change the physics of opened menu (example: you can remove or add scroll to menu)
                                itemBuilder: (value) => Container(
                                    width: context.mediaQuerySize.width,
                                    height: 45,
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 10,
                                    ),
                                    child: value), // Widget displayed for each item
                                toggledChild: Container(
                                  color: AppColors.light,
                                  child: SizedBox(
                                    width: context.mediaQuerySize.width,
                                    height: 45,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Obx(() => Text(_value.value)),
                                          SvgPicture.asset('assets/images/icn_arrow_down.svg'),
                                        ],
                                      ),
                                    ),
                                  ), // Widget displayed as the button,
                                ),
                                divider: Container(
                                  height: 0,
                                  color: Colors.grey,
                                ),
                                onItemSelected: (value) {
                                  _value.value = value;
                                  // Action when new item is selected
                                },
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(7.0),
                                  ),
                                  color: AppColors.light,
                                ),
                                onMenuButtonToggle: (isToggle) {},
                              ),
                            ),
                            SizedBox(height: 15),
                            CustomTextField(hintText: 'Title', isFull: true),
                          ],
                        ),
                  SizedBox(height: 15),
                  CustomTextField(
                    hintText: 'Question',
                    maxLines: 13,
                    minLines: 4,
                    isFull: true,
                  ),
                  SizedBox(height: 18),
                  OrangeButton(
                    text: 'Change',
                    onTap: () {
                      Get.back();
                    },
                  ),
                  SizedBox(height: 30),
                  Container(
                    height: 25,
                    alignment: Alignment.center,
                    width: context.mediaQuerySize.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(
                          () => CustomCheckbox(
                            value: check.value,
                            onToggle: (value) {
                              check.value = value;
                            },
                          ),
                        ),
                        SizedBox(width: 15),
                        Text(
                          'Terms & Conditions',
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
