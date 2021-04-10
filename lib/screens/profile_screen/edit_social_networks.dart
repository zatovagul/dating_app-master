import 'package:dating_app/widgets/bordered_container.dart';
import 'package:dating_app/widgets/custom_textfield.dart';
import 'package:dating_app/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:menu_button/menu_button.dart';
import 'package:dating_app/resourses/colors.dart';
import '../../states.dart';

class EditSocialNetworks extends StatelessWidget {
  AppStates appStates = Get.put(AppStates());
  var isFullNetworks = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBronze,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: SvgPicture.asset(
            'assets/images/appbar_arrow_left.svg',
            height: 20,
            width: 20,
          ),
          highlightColor: Colors.white,
        ),
        centerTitle: true,
        title: Text(
          'Social networks',
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
                  Text(
                    'Social networks',
                    style: TextStyle(
                      color: AppColors.lightBlack,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 15),
                  Obx(
                    () => Column(
                      children: List.generate(
                        appStates.socialNetworksList.value.length,
                        (index) => Padding(
                          padding: EdgeInsets.only(bottom: index == appStates.socialNetworksList.value.last.index ? 0 : 25),
                          child: Obx(
                            () => appStates.socialNetworksList.value[index],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  Obx(
                    () => appStates.socialNetworksList.value.length < 5
                        ? GestureDetector(
                            onTap: () {
                              appStates.socialNetworksList.value.add(
                                SocialNetworksBlock(
                                  index: appStates.socialNetworksList.value.last.index + 1,
                                ),
                              );
                              appStates.socialNetworksList.refresh();
                            },
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '+ Add',
                                style: TextStyle(
                                  color: AppColors.orange,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Add public email',
                    style: TextStyle(
                      color: AppColors.lightBlack,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 15),
                  CustomTextField(
                    hintText: 'Email',
                    isFull: true,
                  ),
                  SizedBox(height: 15),
                  OrangeButton(
                    text: 'Save',
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

class SocialNetworksBlock extends StatelessWidget {
  final int index;

  SocialNetworksBlock({this.index});

  final List<SocialNetwork> list = [
    SocialNetwork(networkName: 'Facebook'),
    SocialNetwork(networkName: 'Youtube'),
    SocialNetwork(networkName: 'Twitter'),
    SocialNetwork(networkName: 'Instagram'),
  ];
  final TextEditingController urlController = TextEditingController();

  final Rx<SocialNetwork> _value = SocialNetwork(networkName: 'Facebook').obs;
  final RxBool isMistake = false.obs;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.mediaQuerySize.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /*context.width > 500
              ? Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                      width: context.width / 2 - 30,
                      height: 65,
                      decoration: BoxDecoration(
                        color: AppColors.light,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Obx(
                        () => MenuButton(
                          child: SizedBox(
                            width: context.mediaQuerySize.width,
                            height: 45,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(child: _value.value),
                                  SvgPicture.asset('assets/images/icn_arrow_down.svg'),
                                ],
                              ),
                            ),
                          ), // Widget displayed as the button
                          items: list, // List of your items
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
                                    _value.value,
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
                    ),
                    SizedBox(width: 10),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        CustomTextField(
                          hintText: 'Enter a nickname',
                          rightPadding: 50,
                          isFull: false,
                        ),
                        Positioned(
                          right: 20,
                          child: Text(
                            'or',
                            style: TextStyle(
                              color: AppColors.lightBlack,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              :*/
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                width: context.width,
                height: 65,
                decoration: BoxDecoration(
                  color: AppColors.light,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Obx(
                  () => MenuButton(
                    child: SizedBox(
                      width: context.mediaQuerySize.width,
                      height: 45,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(child: _value.value),
                            SvgPicture.asset('assets/images/icn_arrow_down.svg'),
                          ],
                        ),
                      ),
                    ), // Widget displayed as the button
                    items: list, // List of your items
                    topDivider: true,
                    scrollPhysics: AlwaysScrollableScrollPhysics(), // Change the physics of opened menu (example: you can remove or add scroll to menu)
                    itemBuilder: (value) => Container(
                        width: context.mediaQuerySize.width,
                        height: 45,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
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
                              _value.value,
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
              ),
              SizedBox(height: 15),
              Stack(
                alignment: Alignment.center,
                children: [
                  CustomTextField(
                    hintText: 'Enter a nickname',
                    rightPadding: 50,
                    isFull: true,
                  ),
                  Positioned(
                    right: 20,
                    child: Text(
                      'or',
                      style: TextStyle(
                        color: AppColors.lightBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 15),
          Obx(() => CustomTextField(
              isFull: true,
              hintText: 'URL Address',
              isMistake: isMistake.value,
              controller: urlController,
              onChanged: (value) {
                isMistake.value = !urlController.text.contains(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")) && urlController.text.isNotEmpty ? true : false;
              })),
        ],
      ),
    );
  }
}

class SocialNetwork extends StatelessWidget {
  final String networkName;

  SocialNetwork({this.networkName});

  @override
  Widget build(BuildContext context) {
    Widget image;
    try {
      image = Image.asset('assets/images/${networkName}_icon.png', width: 23);
    } catch (_) {
      image = Icon(Icons.panorama_outlined);
    }
    return Row(
      children: [
        image,
        SizedBox(width: 15),
        Text(networkName),
      ],
    );
  }

  @override
  bool operator ==(Object other) => identical(this, other) || super == other && other is SocialNetwork && runtimeType == other.runtimeType && networkName == other.networkName;

  @override
  int get hashCode => super.hashCode ^ networkName.hashCode;
}
