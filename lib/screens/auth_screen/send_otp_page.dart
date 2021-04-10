import 'package:countdown_flutter/countdown_flutter.dart';
import 'package:dating_app/screens/home_screen/all_feedbacks.dart';
import 'package:dating_app/resourses/colors.dart';
import 'package:dating_app/widgets/auth_block_widget.dart';
import 'package:dating_app/widgets/custom_widgets.dart';
import 'package:dating_app/services/snackbar_service.dart';
import 'package:flutter/material.dart';
import 'package:dating_app/widgets/loading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:dating_app/services/networking_service.dart';

class SendOTPPage extends StatefulWidget {
  //
  final String enterField;

  SendOTPPage(this.enterField);

  @override
  _SendOTPPageState createState() => _SendOTPPageState();
  //
}

class _SendOTPPageState extends State<SendOTPPage> {
  //
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  RxBool rememberMe = false.obs;
  RxBool codeSend = true.obs;
  RxInt secondsToSend = 40.obs;
  RxBool newCodeSend = false.obs;

  bool isTablet;
  bool isBigTablet;
  bool _loading = false;

  TextEditingController otpOne;
  TextEditingController otpTwo;
  TextEditingController otpThree;
  TextEditingController otpFour;

  FocusNode focusOtpOne;
  FocusNode focusOtpTwo;
  FocusNode focusOtpThree;
  FocusNode focusOtpFour;

  @override
  void dispose() {
    super.dispose();
    otpOne.dispose();
    otpTwo.dispose();
    otpThree.dispose();
    otpFour.dispose();
    focusOtpOne.dispose();
    focusOtpTwo.dispose();
    focusOtpThree.dispose();
    focusOtpFour.dispose();
  }

  @override
  void initState() {
    super.initState();
    otpOne = TextEditingController();
    otpTwo = TextEditingController();
    otpThree = TextEditingController();
    otpFour = TextEditingController();
    focusOtpOne = FocusNode();
    focusOtpTwo = FocusNode();
    focusOtpThree = FocusNode();
    focusOtpFour = FocusNode();
    Future.delayed(Duration(milliseconds: 200), () => FocusScope.of(context).requestFocus(focusOtpOne));
  }

  @override
  Widget build(BuildContext context) {
    isTablet = context.mediaQuerySize.width > 500;
    isBigTablet = context.mediaQuerySize.width > 1000;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.light,
      appBar: AppBar(
        backgroundColor: AppColors.light,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          'assets/images/logo.png',
          width: context.width * 0.5,
        ),
        leading: IconButton(
          highlightColor: Colors.transparent,
          onPressed: () => Get.back(),
          icon: SvgPicture.asset('assets/images/appbar_arrow_left.svg', height: 20, width: 20),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: isTablet ? EdgeInsets.only(top: 15, left: 80, right: 80) : EdgeInsets.only(top: 15, left: 10, right: 10),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 30),
              child: Column(
                children: [
                  AuthBlock(
                    children: [
                      Text(
                        'phone_confirm'.tr,
                        textAlign: isTablet ? TextAlign.center : TextAlign.start,
                        style: TextStyle(
                          color: AppColors.lightBlack,
                          fontSize: 35,
                          fontWeight: FontWeight.w500,
                          height: 1.1,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'phone_confirm_desc'.tr,
                        style: TextStyle(
                          color: AppColors.lightBlack,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 35),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: isTablet ? 94 : 70,
                            height: isTablet ? 91 : 67,
                            child: OTPTextField(
                              controller: otpOne,
                              focusNode: focusOtpOne,
                              isTablet: isTablet,
                              onChanged: (text) {
                                if (text.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                            ),
                          ),
                          Container(
                            width: isTablet ? 94 : 70,
                            height: isTablet ? 91 : 67,
                            child: OTPTextField(
                              controller: otpTwo,
                              focusNode: focusOtpTwo,
                              isTablet: isTablet,
                              onChanged: (text) {
                                if (text.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                } else {
                                  FocusScope.of(context).previousFocus();
                                }
                              },
                            ),
                          ),
                          Container(
                            width: isTablet ? 94 : 70,
                            height: isTablet ? 91 : 67,
                            child: OTPTextField(
                              controller: otpThree,
                              focusNode: focusOtpThree,
                              isTablet: isTablet,
                              onChanged: (text) {
                                if (text.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                } else {
                                  FocusScope.of(context).previousFocus();
                                }
                              },
                            ),
                          ),
                          Container(
                            width: isTablet ? 94 : 70,
                            height: isTablet ? 91 : 67,
                            child: OTPTextField(
                              controller: otpFour,
                              focusNode: focusOtpFour,
                              isTablet: isTablet,
                              onChanged: (text) {
                                if (text.length == 1) {
                                  confirmButton();
                                } else {
                                  FocusScope.of(context).previousFocus();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25),
                      GradientButton(
                        text: 'confirm'.tr,
                        isMargin: false,
                        onTap: confirmButton,
                      ),
                      Obx(
                        () => SizedBox(
                          height: newCodeSend.value
                              ? isTablet
                                  ? 113
                                  : 103
                              : isTablet
                                  ? 143
                                  : 133,
                        ),
                      ),
                      Center(
                        child: Obx(
                          () => codeSend.value
                              ? CountdownFormatted(
                                  duration: Duration(seconds: 40),
                                  onFinish: () {
                                    codeSend.value = false;
                                    newCodeSend.value = false;
                                  },
                                  builder: (context, countdown) {
                                    return Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Obx(
                                          () => newCodeSend.value
                                              ? Column(
                                                  children: [
                                                    Text(
                                                      'sended_new_code'.tr,
                                                      style: TextStyle(
                                                        color: AppColors.green,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                    SizedBox(height: 11),
                                                  ],
                                                )
                                              : Container(),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            text: 'timer_code'.tr,
                                            style: TextStyle(
                                              color: AppColors.lightBlack,
                                              fontSize: 16,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: countdown,
                                                style: TextStyle(
                                                  color: AppColors.orange,
                                                ),
                                              ),
                                              TextSpan(text: 'seconds'.tr),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                )
                              : GestureDetector(
                                  onTap: () {
                                    newCodeSend.value = true;
                                    codeSend.value = true;
                                  },
                                  child: Text(
                                    'send_new_code'.tr,
                                    style: TextStyle(
                                      color: AppColors.orange,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (_loading) Loading(),
        ],
      ),
    );
  }

  void confirmButton() async {
    setState(() => _loading = true);
    final Map<String, String> map = {
      "enterField": widget.enterField,
      "has": "${otpOne.text}${otpTwo.text}${otpThree.text}${otpFour.text}",
    };
    try {
      final x = await NetworkingService.verification(map);
      setState(() => _loading = false);
      if (json.decode(x.body)['status'] == true)
        Get.offAll(AllFeedbacks());
      else
        SnackBarService.showMessage(context, 'snackbar_verification_error'.tr, _scaffoldKey, Colors.red);
    } catch (_) {
      setState(() => _loading = false);
      SnackBarService.showMessage(context, 'snackbar_error'.tr, _scaffoldKey, Colors.red);
      throw Exception('Error confirmButton $_');
    }
  }
  //
}

class OTPTextField extends StatelessWidget {
  //
  final TextEditingController controller;
  final void Function(String) onChanged;
  final bool isMistake;
  final FocusNode focusNode;
  final bool isTablet;

  OTPTextField({
    this.controller,
    this.onChanged,
    this.isMistake,
    this.focusNode,
    this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.center,
      textAlignVertical: TextAlignVertical.center,
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.done,
      maxLength: 1,
      controller: controller,
      focusNode: focusNode,
      onChanged: onChanged,
      cursorColor: Colors.black,
      cursorWidth: 1,
      style: TextStyle(
        color: isMistake != null && isMistake == true ? AppColors.mistake : AppColors.lightBlack,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        height: 1.48,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: isTablet ? 28 : 20),
        counterText: '',
        filled: true,
        fillColor: isMistake != null && isMistake == true ? AppColors.lightPink : AppColors.light,
        hintStyle: TextStyle(
          fontSize: isTablet ? 30 : 20,
          fontWeight: FontWeight.w400,
          color: isMistake != null && isMistake == true ? AppColors.lightPink : AppColors.grey,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.light,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.light,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.light,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.light,
          ),
        ),
      ),
    );
  }
  //
}
