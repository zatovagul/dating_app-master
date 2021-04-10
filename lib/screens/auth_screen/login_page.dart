import 'package:dating_app/resourses/colors.dart';
import 'package:dating_app/services/hive_helper.dart';
import 'package:dating_app/widgets/auth_block_widget.dart';
import 'package:dating_app/widgets/custom_textfield.dart';
import 'package:dating_app/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:dating_app/models/user_login.dart';
import 'sign_up_page.dart';
import 'package:dating_app/widgets/loading.dart';
import 'package:dating_app/services/networking_service.dart';
import 'package:dating_app/screens/home_screen/all_feedbacks.dart';
import 'dart:convert';
import 'package:dating_app/services/snackbar_service.dart';
import 'dart:io';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var rememberMe = true.obs;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController enterFieldController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool _loading = false;
  bool isTablet;
  bool isBigTablet;

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid && MediaQuery.of(context).size.width > 500) exit(0);
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
                  padding: EdgeInsets.only(top: context.mediaQuery.padding.top),
                  child: Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: context.width * 0.5,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15, left: 10, right: 10),
                  child: AuthBlock(
                    children: [
                      Text(
                        'login'.tr,
                        style: TextStyle(
                          color: AppColors.lightBlack,
                          fontSize: 50,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'login_desc'.tr,
                        style: TextStyle(
                          color: AppColors.lightBlack,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 35),
                      LoginForm(
                        onFieldSubmitted: signInTap,
                        formKey: _formKey,
                        enterFieldController: enterFieldController,
                        passwordController: passwordController,
                      ),
                      SizedBox(height: 15),
                      signIn,
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(
                            () => CustomCheckbox(
                              value: rememberMe.value,
                              onToggle: (value) {
                                rememberMe.value = value;
                              },
                            ),
                          ),
                          FlatButton(
                            padding: EdgeInsets.zero,
                            highlightColor: Colors.transparent,
                            onPressed: () => rememberMe.value = !rememberMe.value,
                            child: Text(
                              'remember_me'.tr,
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
                  'another_signin'.tr,
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 15),
                socialSignIn,
                SizedBox(height: 30),
                forgotPassword,
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'no_account'.tr,
                      style: TextStyle(
                        color: AppColors.lightBlack,
                        fontSize: 16,
                      ),
                    ),
                    signUp,
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

  Widget get socialSignIn => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/images/sign_apple.svg'),
          SizedBox(width: 11),
          SvgPicture.asset('assets/images/sign_facebook.svg'),
          SizedBox(width: 11),
          SvgPicture.asset('assets/images/sign_google.svg'),
        ],
      );

  Widget get forgotPassword => GestureDetector(
        onTap: () {},
        child: Text(
          'forgot_password'.tr,
          style: TextStyle(
            color: AppColors.orange,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      );

  Widget get signUp => SizedBox(
        width: 70,
        child: FlatButton(
          padding: EdgeInsets.zero,
          highlightColor: Colors.white,
          onPressed: () => Get.offAll(SignUpPage()),
          child: Text(
            'signup'.tr,
            style: TextStyle(
              color: AppColors.orange,
              fontSize: 16,
            ),
          ),
        ),
      );

  Widget get signIn => GradientButton(
        text: 'signin'.tr,
        isMargin: false,
        onTap: signInTap,
      );

  void signInTap() async {
    setState(() => _loading = true);

    try {
      if (_formKey.currentState.validate()) {
        final x = await NetworkingService.auth(
          UserLogin(
            enterField: enterFieldController.text,
            password: passwordController.text,
          ),
        );
        final Map<String, dynamic> response = json.decode(x.body);
        print('response: $response');
        if (response['status'] == true) {
          await HiveHelper.addToken(response['access_token']);
          await HiveHelper.addRefreshToken(response['refresh_token']);
          setState(() => _loading = false);
          Get.offAll(AllFeedbacks());
        } else {
          throw Exception('Error to sign in');
        }
      }
    } catch (_) {
      SnackBarService.showMessage(context, 'snackbar_error_sign_in'.tr, _scaffoldKey, Colors.red);
      print('Error signUpOnTap: $_');
    }
    setState(() => _loading = false);
  }
}

class LoginForm extends StatefulWidget {
  final TextEditingController enterFieldController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  final Function onFieldSubmitted;

  LoginForm({
    this.passwordController,
    this.enterFieldController,
    this.formKey,
    this.onFieldSubmitted,
  });

  @override
  _LoginFormState createState() {
    return _LoginFormState();
  }
}

class _LoginFormState extends State<LoginForm> {
  String loginValidator(String str) {
    if ((str.length ?? 0) == 0)
      return 'Введите логин';
    else
      return null;
  }

  String passwordValidator(String str) {
    if ((str.length ?? 0) == 0)
      return 'Введите пароль';
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          CustomTextField(
            textInputAction: TextInputAction.next,
            validator: loginValidator,
            controller: widget.enterFieldController,
            isFull: true,
            hintText: 'login_field'.tr,
          ),
          SizedBox(height: 15),
          CustomTextField(
            onFieldSubmitted: (_) {
              widget.onFieldSubmitted();
            },
            textInputAction: TextInputAction.done,
            validator: passwordValidator,
            controller: widget.passwordController,
            isFull: true,
            hintText: 'password'.tr,
            obscure: true,
          ),
        ],
      ),
    );
  }
}
