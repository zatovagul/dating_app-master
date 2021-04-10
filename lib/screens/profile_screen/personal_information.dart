import 'package:dating_app/widgets/bordered_container.dart';
import 'package:dating_app/widgets/personal_country_dropdown.dart';
import 'package:dating_app/widgets/personal_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:dating_app/resourses/colors.dart';
import '../../states.dart';

class PersonalInformation extends StatefulWidget {
  @override
  _PersonalInformationState createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  AppStates appStates = Get.put(AppStates());
  TextEditingController _firstNameController;
  TextEditingController _lastNameController;
  TextEditingController _loginController;
  TextEditingController _emailController;
  TextEditingController _countryController;
  TextEditingController _cityController;
  TextEditingController _statusController;
  ScrollController _scrollController;

  String _firstName, _lastName, _login, _email, _country, _city, _status;
  bool _isMistake = false;
  FocusNode _focusNode;

  var box = Hive.box('appMetrics');

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: box.get('firstName') ?? 'Peter');
    _lastNameController = TextEditingController(text: box.get('lastName') ?? 'Houel');
    _loginController = TextEditingController(text: box.get('login') ?? 'superGuy');
    _emailController = TextEditingController(text: box.get('myEmail') ?? 'peterhouel@gmail.com');
    _countryController = TextEditingController(text: box.get('myCountry') ?? 'United States of America');
    _cityController = TextEditingController(text: box.get('myCity') ?? 'New York');
    _statusController = TextEditingController(text: box.get('myStatus') ?? 'Hi, I`m Peter. And I introvert');
    _scrollController = ScrollController();
    _focusNode = FocusNode();
    _focusNode.addListener(() => print('focusNode updated: hasFocus: ${_focusNode.hasFocus}'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.light,
      appBar: AppBar(
        leading: IconButton(
          highlightColor: Colors.transparent,
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
          'Personal information',
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                BorderedContainer(
                  children: [
                    SizedBox(
                      width: context.mediaQuerySize.width,
                      child: Column(
                        children: [
                          Container(
                            height: 155,
                            width: 155,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(
                                  appStates.profilePhoto.value,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            'Edit avatar',
                            style: TextStyle(
                              color: AppColors.orange,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    context.width > 500
                        ? Row(
                            children: [
                              PersonalTextField(
                                text: 'First name',
                                hintText: 'First name',
                                controller: _firstNameController,
                                isFull: false,
                                onChanged: (firstName) {
                                  setState(() {
                                    _firstName = firstName;
                                  });
                                },
                              ),
                              SizedBox(width: 10),
                              PersonalTextField(
                                text: 'Last name',
                                hintText: 'Last name',
                                isFull: false,
                                controller: _lastNameController,
                                onChanged: (lastName) {
                                  setState(() {
                                    _lastName = lastName;
                                  });
                                },
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              PersonalTextField(
                                text: 'First name',
                                hintText: 'First name',
                                isFull: true,
                                controller: _firstNameController,
                                onChanged: (firstName) {
                                  setState(() {
                                    _firstName = firstName;
                                  });
                                },
                              ),
                              PersonalTextField(
                                text: 'Last name',
                                hintText: 'Last name',
                                isFull: true,
                                controller: _lastNameController,
                                onChanged: (lastName) {
                                  setState(() {
                                    _lastName = lastName;
                                  });
                                },
                              ),
                            ],
                          ),
                    context.width > 500
                        ? Row(
                            children: [
                              PersonalTextField(
                                text: 'Login',
                                hintText: 'Login',
                                focusNode: _focusNode,
                                controller: _loginController,
                                isFull: false,
                                isMistake: _isMistake,
                                onChanged: (login) {
                                  setState(() {
                                    _login = login;
                                    _isMistake = _loginController.text.contains(RegExp(r'[#/"!@%?\)\()]|[а-яА-Я]')) ? true : false;
                                  });
                                  print(_isMistake);
                                },
                              ),
                              SizedBox(width: 10),
                              PersonalTextField(
                                text: 'Email',
                                hintText: 'Email',
                                isFull: false,
                                controller: _emailController,
                                onChanged: (email) {
                                  setState(() {
                                    _email = email;
                                  });
                                },
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              PersonalTextField(
                                text: 'Login',
                                hintText: 'Login',
                                focusNode: _focusNode,
                                controller: _loginController,
                                isFull: true,
                                isMistake: _isMistake,
                                onChanged: (login) {
                                  setState(() {
                                    _login = login;
                                    _isMistake = _loginController.text.contains(RegExp(r'[#/"!@%?\)\()]|[а-яА-Я]')) ? true : false;
                                  });
                                  print(_isMistake);
                                },
                              ),
                              PersonalTextField(
                                text: 'Email',
                                hintText: 'Email',
                                isFull: true,
                                controller: _emailController,
                                onChanged: (email) {
                                  setState(() {
                                    _email = email;
                                  });
                                },
                              ),
                            ],
                          ),
                    context.width > 500
                        ? Row(
                            children: [
                              Container(
                                width: context.width < 500 ? context.width : context.width / 2 - 30,
                                child: PersonalCountryDropdown(
                                  text: 'Country',
                                  selectedItem: _country,
                                  onChanged: (country) {
                                    setState(() {
                                      _country = country;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(width: 10),
                              PersonalTextField(
                                text: 'City',
                                hintText: 'City',
                                isFull: false,
                                controller: _cityController,
                                onChanged: (city) {
                                  setState(() {
                                    _city = city;
                                  });
                                },
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              PersonalCountryDropdown(
                                text: 'Country',
                                selectedItem: _country,
                                onChanged: (country) {
                                  setState(() {
                                    _country = country;
                                  });
                                },
                              ),
                              SizedBox(width: 10),
                              PersonalTextField(
                                text: 'City',
                                hintText: 'City',
                                isFull: true,
                                controller: _cityController,
                                onChanged: (city) {
                                  setState(() {
                                    _city = city;
                                  });
                                },
                              ),
                            ],
                          ),
                    PersonalTextField(
                      text: 'Status',
                      hintText: 'Status',
                      isFull: true,
                      controller: _statusController,
                      onChanged: (status) {
                        setState(() {
                          _status = status;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    FlatButton(
                      /*decoration: BoxDecoration(
                          color: AppColors.orange,
                          borderRadius: BorderRadius.circular(7),
                        ),*/
                      color: AppColors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                      onPressed: () {
                        if (!_isMistake) {
                          setState(() {
                            box.get('firstName') != _firstNameController.text
                                ? box.put('firstName', _firstName)
                                : box.put(
                                    'firstName',
                                    box.get('firstName'),
                                  );
                            box.get('lastName') != _lastNameController.text ? box.put('lastName', _lastName) : box.put('lastName', box.get('lastName'));
                            box.get('login') != _loginController.text ? box.put('login', _login) : box.put('login', box.get('login'));
                            box.get('myEmail') != _emailController.text ? box.put('myEmail', _email) : box.put('myEmail', box.get('myEmail'));
                            box.get('myCountry') != _country ? box.put('myCountry', _country) : box.put('myCountry', box.get('myCountry'));
                            box.get('myCity') != _cityController.text ? box.put('myCity', _city) : box.put('myCity', box.get('myCity'));
                            box.get('myStatus') != _statusController.text ? box.put('myStatus', _status) : box.put('myStatus', box.get('myStatus'));
                          });
                          Get.back();
                        } else {
                          FocusScope.of(context).requestFocus(_focusNode);
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: context.mediaQuerySize.width,
                        height: 58,
                        child: Text(
                          'Save',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
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
      ),
    );
  }
}
