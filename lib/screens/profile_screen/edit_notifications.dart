import 'package:dating_app/widgets/bordered_container.dart';
import 'package:dating_app/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dating_app/resourses/colors.dart';
import 'package:get/get.dart';


class EditNotifications extends StatelessWidget {
  var emailOn = false.obs;
  var phoneOn = false.obs;

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
          'Notifications',
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
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Send email notifications',
                            style: TextStyle(
                              color: AppColors.lightBlack,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Obx(
                            () => SwitchBox(
                              value: emailOn.value,
                              onToggle: (value) {
                                emailOn.value = value;
                              },
                              checkIcon: false,
                              backgroundColor: Color(0xFFF3F2F0),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Send phone notifications',
                            style: TextStyle(
                              color: AppColors.lightBlack,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Obx(
                            () => SwitchBox(
                              value: phoneOn.value,
                              onToggle: (value) {
                                phoneOn.value = value;
                              },
                              checkIcon: false,
                              backgroundColor: Color(0xFFF3F2F0),
                            ),
                          ),
                        ],
                      ),
                    ],
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
