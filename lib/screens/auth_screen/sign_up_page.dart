import 'package:dating_app/screens/auth_screen/send_otp_page.dart';
import 'package:dating_app/resourses/colors.dart';
import 'package:dating_app/widgets/auth_block_widget.dart';
import 'package:dating_app/widgets/loading.dart';
import 'package:dating_app/widgets/custom_textfield.dart';
import 'package:dating_app/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:dating_app/models/user_registration.dart';
import 'package:dating_app/services/networking_service.dart';
import 'login_page.dart';
import 'dart:convert';
import 'package:dating_app/services/snackbar_service.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //
  RxBool termsConditions = true.obs;

  bool _loading = false;
  bool isTablet;
  bool isBigTablet;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController enterFieldController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    super.dispose();
    enterFieldController.dispose();
    passwordController.dispose();
    repeatPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isTablet = context.mediaQuerySize.width > 500;
    isBigTablet = context.mediaQuerySize.width > 1000;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.light,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 30),
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: context.mediaQuery.padding.top,
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: context.width * 0.5,
                    ),
                  ),
                ),
                Padding(
                  padding: isTablet
                      ? EdgeInsets.only(top: 15, left: 80, right: 80)
                      : EdgeInsets.only(
                          top: 15,
                          left: 10,
                          right: 10,
                        ),
                  child: AuthBlock(
                    children: [
                      Text(
                        'signup'.tr,
                        style: TextStyle(
                          color: AppColors.lightBlack,
                          fontSize: 50,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'signup_desc'.tr,
                        style: TextStyle(
                          color: AppColors.lightBlack,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 35),
                      SignUpForm(
                        scaffoldKey: _scaffoldKey,
                        onFieldSubmitted: signUpOnTap,
                        formKey: _formKey,
                        passwordController: passwordController,
                        enterFieldController: enterFieldController,
                        repeatPasswordController: repeatPasswordController,
                      ),
                      SizedBox(height: 15),
                      GradientButton(
                        text: 'signup'.tr,
                        isMargin: false,
                        onTap: () => signUpOnTap(context),
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(
                            () => CustomCheckbox(
                              value: termsConditions.value,
                              onToggle: (value) {
                                termsConditions.value = value;
                              },
                            ),
                          ),
                          FlatButton(
                            padding: EdgeInsets.zero,
                            highlightColor: Colors.transparent,
                            onPressed: () => termsConditions.value = !termsConditions.value,
                            child: Text(
                              'terms'.tr,
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'another_signup'.tr,
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 15),
                socialSignIn,
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'already_have_account'.tr,
                      style: TextStyle(
                        color: AppColors.lightBlack,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(width: 5),
                    login,
                  ],
                ),
              ],
            ),
            if (_loading) Loading(),
          ],
        ),
      ),
    );
  }

  get login => SizedBox(
        width: 70,
        child: FlatButton(
          highlightColor: Colors.white,
          padding: EdgeInsets.zero,
          onPressed: () => Get.offAll(LoginPage()),
          child: Text(
            'login'.tr,
            style: TextStyle(
              color: AppColors.orange,
              fontSize: 16,
            ),
          ),
        ),
      );

  get socialSignIn => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/images/sign_apple.svg'),
          SizedBox(width: 11),
          SvgPicture.asset('assets/images/sign_facebook.svg'),
          SizedBox(width: 11),
          SvgPicture.asset('assets/images/sign_google.svg'),
        ],
      );

  void signUpOnTap(BuildContext context) async {
    if (validateSignUp()) {
      setState(() => _loading = true);
      try {
        final x = await NetworkingService.registration(
          UserRegistration(
            enterField: enterFieldController.text,
            password: passwordController.text,
            password_confirmation: repeatPasswordController.text,
          ),
        );

        setState(() => _loading = false);
        if (json.decode(x.body)['status'] == true) {
          Get.to(SendOTPPage(
            enterFieldController.text,
          ));
        } else
          SnackBarService.showMessage(context, 'failed_register'.tr, _scaffoldKey, Colors.red);
      } catch (_) {
        setState(() => _loading = false);
        print('Error signUpOnTap: $_');
      }
    }
  }

  bool validatePhoneEmail() {
    return true;
  }

  bool validateStructure(String value) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  bool validateSignUp() {
    final bool c = termsConditions.value;
    final bool d = validatePhoneEmail();

    if (c && d && _formKey.currentState.validate()) {
      return true;
    } else {
      SnackBarService.showMessage(context, 'validate_sign_up_error'.tr, _scaffoldKey, Colors.red);
      return false;
    }
  }

  //
}

class SignUpForm extends StatefulWidget {
//
  final TextEditingController enterFieldController;
  final TextEditingController passwordController;
  final TextEditingController repeatPasswordController;
  final GlobalKey<FormState> formKey;
  final Function onFieldSubmitted;
  final GlobalKey<ScaffoldState> scaffoldKey;
  SignUpForm({
    this.scaffoldKey,
    this.repeatPasswordController,
    this.passwordController,
    this.enterFieldController,
    this.formKey,
    this.onFieldSubmitted,
  });

  @override
  _SignUpFormState createState() {
    return _SignUpFormState();
  }
}

class _SignUpFormState extends State<SignUpForm> {
  //

  bool validateStructure(String value) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  String loginValidator(String str) {
    if ((str.length ?? 0) == 0)
      return 'Введите логин';
    else
      return null;
  }

  String passwordValidator(String str) {
    if (validateStructure(widget.passwordController.text))
      return null;
    else {
      SnackBarService.showMessage(context, 'snackbar_sign_up_password_error'.tr, widget.scaffoldKey, Colors.red);
      return 'Нельзя использовать такой пароль';
    }
  }

  String repeatPasswordValidator(String str) {
    if (widget.passwordController.text == widget.repeatPasswordController.text)
      return null;
    else
      return 'Пароли не совпадают';
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          CustomTextField(
            textInputAction: TextInputAction.next,
            controller: widget.enterFieldController,
            isFull: true,
            hintText: 'login_field'.tr,
            validator: loginValidator,
          ),
          SizedBox(height: 15),
          CustomTextField(
            textInputAction: TextInputAction.next,
            controller: widget.passwordController,
            isFull: true,
            hintText: 'password'.tr,
            obscure: true,
            validator: passwordValidator,
          ),
          SizedBox(height: 15),
          CustomTextField(
            onFieldSubmitted: (_) {
              widget.onFieldSubmitted();
            },
            textInputAction: TextInputAction.done,
            controller: widget.repeatPasswordController,
            isFull: true,
            hintText: 'repeat_password'.tr,
            obscure: true,
            validator: repeatPasswordValidator,
          ),
        ],
      ),
    );
  }
}
