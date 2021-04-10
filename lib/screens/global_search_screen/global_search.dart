import 'package:dating_app/data/data.dart';
import 'package:dating_app/resourses/colors.dart';
import 'package:dating_app/screens/profile_screen/edit_social_networks.dart';
import 'package:dating_app/widgets/feedback_mini.dart';
import 'package:dating_app/widgets/searching_tab_bar.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dating_app/models/all_feedback.dart';
import '../../states.dart';
import 'package:dating_app/services/networking_service.dart';
import 'dart:convert';

class GlobalSearch extends StatefulWidget {
  @override
  _GlobalSearchState createState() => _GlobalSearchState();
}

class _GlobalSearchState extends State<GlobalSearch> {
  List<AllFeedback> allFeedback;
  bool error = false;
  bool loading = true;

  @override
  void initState() {
    start();
    super.initState();
  }

  start() async {
    try {
      if (!loading) setState(() => loading = true);
      final response = await NetworkingService.allFeedbacks();
      if (response.statusCode == 200 && json.decode(response.body)['status']) {
        allFeedback = AllFeedback.fromJsonList(json.decode(response.body)['data']);
      }
      setState(() => loading = false);
    } catch (_) {
      print('\nError $_');
      setState(() => error = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.light,
      body: Padding(
        padding: EdgeInsets.only(
          top: 63,
          bottom: 0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                'Global search',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                'Find a feedback about a specific person',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.lightBlack.withOpacity(0.7),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SearchingTabBar(
              appStatesGlobalSearch: Get.put(AppStatesGlobalSearch()),
            ),
            if (loading)
              Center(
                child: CircularProgressIndicator(),
              ),
            if (error) Text('Error to load data'),
            if (!loading && !error)
              Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    primary: true,
                    child: Column(
                      children: [
                        Column(
                          children: List.generate(
                            allFeedback.length,
                            (index) => FeedbackMini(
                              allFeedback[index],
                              padding: EdgeInsets.only(
                                left: 10,
                                right: 10,
                                bottom: 10,
                              ),
                            ),
                          ),
                        ),
                        // Expanded(
                        //   child: SingleChildScrollView(
                        //     scrollDirection: Axis.horizontal,
                        //     child: TopUsersMini(),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class IconWithCount extends StatelessWidget {
  final int count;
  final Widget icon;
  final Color colorText;

  IconWithCount({this.count, this.icon, this.colorText});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        SizedBox(width: 5),
        Text(
          count.toString(),
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: colorText != null ? colorText : Color(0xFF9E9E9E),
          ),
        )
      ],
    );
  }
}

class TopUsersMini extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 50),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  Text(
                    'Top user of Exdating',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF161616),
                      height: 1,
                    ),
                  ),
                  Text(
                    'More',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.orange,
                      height: 1,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
            Expanded(
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: false,
                primary: false,
                itemBuilder: (context, i) {
                  return Container(
                    alignment: Alignment.center,
                    height: 250,
                    width: 174,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.bottomCenter,
                          child: Container(
                            height: 218,
                            width: 174,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: 31,
                                width: 31,
                                decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                              ),
                              Container(
                                alignment: Alignment.lerp(Alignment.center, Alignment.bottomCenter, i + 1 != 1 ? 0.2 : 0),
                                height: 26,
                                width: 26,
                                decoration: i + 1 != 1
                                    ? BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.black,
                                      )
                                    : BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(
                                          colors: [
                                            AppColors.orange,
                                            AppColors.mistake,
                                          ],
                                          stops: [0.2165, 0.6295],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                      ),
                                child: i + 1 != 1
                                    ? Text(
                                        '${i + 1}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      )
                                    : Icon(Icons.star, color: Colors.white, size: 15),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, i) {
                  return SizedBox(width: 10);
                },
                itemCount: Lists.listTopUsersName.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TitleOfField extends StatelessWidget {
  final String title;
  final Color color;

  TitleOfField(this.title, {this.color});

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

class PopularTagSearch extends StatefulWidget {
  final String tag;
  final AppStatesInterface appStates;
  PopularTagSearch({
    this.tag,
    @required this.appStates,
  });

  @override
  _PopularTagSearchState createState() => _PopularTagSearchState();
}

class _PopularTagSearchState extends State<PopularTagSearch> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
      child: GestureDetector(
        onTap: () {
          widget.appStates.filledSearchTags.value.add(
            FilledTagSearch(tag: widget.tag),
          );
          widget.appStates.filledSearchTags.refresh();
        },
        child: Chip(
          labelPadding: EdgeInsets.only(left: 7, right: 7),
          shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Color(0xFFE9E6E3),
              ),
              borderRadius: BorderRadius.circular(30)),
          backgroundColor: Colors.white,
          label: Text(
            '#${widget.tag.toUpperCase()}',
            style: TextStyle(
              color: AppColors.grey,
              height: 1.1,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    );
  }
}

class FilledTagSearch extends StatelessWidget {
  final String tag;

  FilledTagSearch({this.tag});

  AppStates appStates = Get.put(AppStates());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
      child: RawChip(
        labelPadding: EdgeInsets.only(left: 7, right: 0),
        backgroundColor: AppColors.orange,
        deleteIcon: SvgPicture.asset('assets/images/icn-delete.svg'),
        deleteIconColor: Colors.white,
        onDeleted: () {
          appStates.filledSearchTags.value.remove(this);
          appStates.filledSearchTags.refresh();
          print(this.tag);
        },
        label: Text(
          '#${tag.toUpperCase()}',
          style: TextStyle(
            color: AppColors.light,
            height: 1.1,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}

class FilledCountrySearch extends StatelessWidget {
  final String tag;

  FilledCountrySearch({this.tag});

  AppStates appStates = Get.put(AppStates());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
      child: RawChip(
        labelPadding: EdgeInsets.only(left: 7, right: 0),
        backgroundColor: AppColors.orange,
        deleteIcon: SvgPicture.asset('assets/images/icn-delete.svg'),
        deleteIconColor: Colors.white,
        onDeleted: () {
          appStates.filledSearchCountry.value.remove(this);
          appStates.filledSearchCountry.refresh();
          print(this.tag);
        },
        label: Text(
          '${tag.toUpperCase()}',
          style: TextStyle(
            color: AppColors.light,
            height: 1.1,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}

class FilledCitySearch extends StatelessWidget {
  final String tag;

  FilledCitySearch({this.tag});

  AppStates appStates = Get.put(AppStates());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
      child: RawChip(
        labelPadding: EdgeInsets.only(left: 7, right: 0),
        backgroundColor: AppColors.orange,
        deleteIcon: SvgPicture.asset('assets/images/icn-delete.svg'),
        deleteIconColor: Colors.white,
        onDeleted: () {
          appStates.filledSearchCity.value.remove(this);
          appStates.filledSearchCity.refresh();
          print(this.tag);
        },
        label: Text(
          '${tag.toUpperCase()}',
          style: TextStyle(
            color: AppColors.light,
            height: 1.1,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}

class SocialNetworksBlockGlobal extends StatelessWidget {
  final int index;

  SocialNetworksBlockGlobal({this.index}) : _value = 'Facebook'.obs;

  List<SocialNetwork> list = [
    SocialNetwork(networkName: 'Facebook'),
    SocialNetwork(networkName: 'Youtube'),
    SocialNetwork(networkName: 'Twitter'),
    SocialNetwork(networkName: 'Instagram'),
    /* SocialNetwork(networkName: 'InstagramFake'),
    SocialNetwork(networkName: 'NotInstagram'),
    SocialNetwork(networkName: 'I am social, real'),*/
  ];
  List<String> listStr = [
    'Facebook',
    'Youtube',
    'Twitter',
    'Instagram',
    /* SocialNetwork(networkName: 'InstagramFake'),
    SocialNetwork(networkName: 'NotInstagram'),
    SocialNetwork(networkName: 'I am social, real'),*/
  ];
  RxString _value;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 65,
        width: context.mediaQuerySize.width,
        child: /* context.width < 500
          ?*/
            Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.light,
                borderRadius: BorderRadius.circular(7),
              ),
              height: 65,
              // color: Colors.deepPurpleAccent,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Obx(
                  () => DropdownButton<String>(
                    value: _value.value,
                    icon: SvgPicture.asset('assets/images/icn_arrow_down.svg'),
                    iconSize: 24,
                    focusColor: Colors.transparent,
                    elevation: 16,
                    dropdownColor: AppColors.light,
                    underline: SizedBox(),
                    isExpanded: true,
                    onChanged: (String newValue) {
                      _value.value = newValue;
                    },
                    items: listStr.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: SocialNetwork(
                          networkName: value,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        )
        /*    : Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  width: context.width < 500 ? context.width : context.width / 2 - 30,
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
                CustomTextField(
                  hintText: 'Nickname or URL address',
                  isFull: context.width < 500 ? true : false,
                ),
              ],
            ),*/
        );
  }
}
/*   Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  //width: context.width < 500 ? context.mediaQuerySize.width : context.width / 2 - 30,
                  height: 65,
                  decoration: BoxDecoration(
                    color: AppColors.light,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Obx(
                    () => SizedBox(
                      width: context.mediaQuerySize.width - 50,
                      height: 45,
                      child: MenuButton(
                        crossTheEdge: true,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(child: _value.value),
                              SvgPicture.asset('assets/images/icn_arrow_down.svg'),
                            ],
                          ),
                        ), // Widget displayed as the button
                        items: list, // List of your items
                        topDivider: true,
                        scrollPhysics: AlwaysScrollableScrollPhysics(), // Change the physics of opened menu (example: you can remove or add scroll to menu)
                        itemBuilder: (value) => Container(
                            width: 100, //context.mediaQuerySize.width,
                            height: 45,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            child: value), // Widget displayed for each item
                        toggledChild: Container(
                          color: AppColors.light,
                          width: 200,//context.mediaQuerySize.width,
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
                ),
                SizedBox(height: 15),
                CustomTextField(
                  hintText: 'Nickname or URL address',
                  isFull: context.width < 500 ? true : false,
                ),
              ],
            )*/
