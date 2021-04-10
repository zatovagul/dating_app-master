import 'package:country_provider/country_provider.dart';
import 'package:dating_app/screens/profile_screen/edit_social_networks.dart';
import 'package:dating_app/widgets/bordered_container.dart';
import 'package:dating_app/widgets/custom_textfield.dart';
import 'package:dating_app/widgets/custom_widgets.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:dating_app/resourses/colors.dart';

import '../../states.dart';

class AddTrackAccount extends StatefulWidget {
  final String name;

  AddTrackAccount({this.name});

  @override
  _AddTrackAccountState createState() => _AddTrackAccountState();
}

class _AddTrackAccountState extends State<AddTrackAccount> {
  List<String> countries = ['United States of America'];
  var selectedCountry = Rx<String>();
  AppStates appStates = Get.put(AppStates());
  Rx<List<SocialNetworksBlock>> socialNetworksTrackList =
      Rx<List<SocialNetworksBlock>>([SocialNetworksBlock(index: 0)]);
  TextEditingController firstNameController;
  TextEditingController lastNameController;

  getCountries() async {
    List<Country> countriesCountry = await CountryProvider.getAllCountries();

    for (Country country in countriesCountry) {
      countries.add(country.name);
    }
  }

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController(
        text: widget.name != null ? widget.name.split(' ')[0] : '');
    lastNameController = TextEditingController(
        text: widget.name != null ? widget.name.split(' ')[1] : '');
    getCountries();
  }

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
          'Add track account',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: AppColors.lightBronze,
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanDown: (_) {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: BorderedContainer(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _TitleOfField('About person'),
                    SizedBox(height: 15),
                    context.width > 500
                        ? Row(
                            children: [
                              CustomTextField(
                                hintText: 'First name',
                                controller: firstNameController,
                                isFull: false,
                              ),
                              SizedBox(width: 10),
                              CustomTextField(
                                hintText: 'Last name',
                                controller: lastNameController,
                                isFull: false,
                              ),
                            ],
                          )
                        : Column(children: [
                            CustomTextField(
                              hintText: 'First name',
                              controller: firstNameController,
                              isFull: true,
                            ),
                            SizedBox(height: 15),
                            CustomTextField(
                              hintText: 'Last name',
                              controller: lastNameController,
                              isFull: true,
                            ),
                          ]),
                    SizedBox(height: 15),
                    context.width > 500
                        ? Row(
                            children: [
                              Container(
                                width: context.width / 2 - 30,
                                child: Obx(() => DropdownSearch(
                                      hint: 'Country',
                                      popupBackgroundColor: AppColors.light,
                                      onChanged: (value) {
                                        selectedCountry.value = value;
                                      },
                                      dropDownButton: SvgPicture.asset(
                                          'assets/images/icn_arrow_down.svg'),
                                      selectedItem: selectedCountry.value,
                                      dropdownSearchDecoration: InputDecoration(
                                        filled: true,
                                        fillColor: AppColors.light,
                                        contentPadding: EdgeInsets.only(
                                            left: 20,
                                            right: 0,
                                            top: 7.5,
                                            bottom: 7.5),
                                        hintStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.grey,
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppColors.light,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(7.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppColors.light,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(7.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppColors.light,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(7.0),
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppColors.light,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(7.0),
                                        ),
                                      ),
                                      items: countries,
                                      mode: Mode.MENU,
                                    )),
                              ),
                              SizedBox(width: 10),
                              CustomTextField(hintText: 'City', isFull: false),
                            ],
                          )
                        : Column(children: [
                            Container(
                              width: context.width,
                              child: Obx(() => DropdownSearch(
                                    hint: 'Country',
                                    popupBackgroundColor: AppColors.light,
                                    onChanged: (value) {
                                      selectedCountry.value = value;
                                    },
                                    dropDownButton: SvgPicture.asset(
                                        'assets/images/icn_arrow_down.svg'),
                                    selectedItem: selectedCountry.value,
                                    dropdownSearchDecoration: InputDecoration(
                                      filled: true,
                                      fillColor: AppColors.light,
                                      contentPadding: EdgeInsets.only(
                                          left: 20,
                                          right: 0,
                                          top: 7.5,
                                          bottom: 7.5),
                                      hintStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.grey,
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppColors.light,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(7.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppColors.light,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(7.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppColors.light,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(7.0),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppColors.light,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(7.0),
                                      ),
                                    ),
                                    items: countries,
                                    mode: Mode.MENU,
                                  )),
                            ),
                            SizedBox(height: 15),
                            CustomTextField(hintText: 'City', isFull: true),
                          ]),
                    SizedBox(height: 20),
                    _TitleOfField('Social Networks'),
                    SizedBox(height: 15),
                    Obx(
                      () => Column(
                        children: List.generate(
                          socialNetworksTrackList.value.length,
                          (index) => Padding(
                            padding: EdgeInsets.only(
                                bottom: index ==
                                        socialNetworksTrackList.value.last.index
                                    ? 30
                                    : 25),
                            child: Obx(
                              () => socialNetworksTrackList.value[index],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Obx(
                      () => socialNetworksTrackList.value.length < 4
                          ? GestureDetector(
                              onTap: () {
                                socialNetworksTrackList.value
                                    .add(SocialNetworksBlock());
                                socialNetworksTrackList.refresh();
                              },
                              child: Text(
                                '+ Add',
                                style: TextStyle(
                                  color: AppColors.orange,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          : Container(),
                    ),
                    SizedBox(height: 30),
                    GradientButton(
                      text: 'Add account',
                      isMargin: false,
                      height: 53,
                      onTap: () {
                        Get.back();
                      },
                    ),
                    SizedBox(height: 25),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Cancel',
                            style: TextStyle(
                              height: 1,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.orange,
                            ),
                          ),
                        ],
                      ),
                    )
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

class _TitleOfField extends StatelessWidget {
  final String title;
  final Color color;

  _TitleOfField(this.title, {this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: color ?? AppColors.lightBlack,
      ),
    );
  }
}
