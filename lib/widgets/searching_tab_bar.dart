import 'package:country_provider/country_provider.dart';
import 'package:dating_app/data/data.dart';
import 'package:dating_app/screens/global_search_screen/global_search.dart';
import 'package:dating_app/resourses/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../states.dart';
import 'bordered_container.dart';
import 'custom_widgets.dart';

class SearchingTabBar extends StatefulWidget {
  final AppStates appStates;
  final AppStatesGlobalSearch appStatesGlobalSearch;
  SearchingTabBar({this.appStates, this.appStatesGlobalSearch});
  @override
  State<StatefulWidget> createState() => _SearchingTabBarState(appStates ?? appStatesGlobalSearch);
}

class _SearchingTabBarState extends State<SearchingTabBar> {
  _SearchingTabBarState(this.appStates);
  final AppStatesInterface appStates;

  TextEditingController tagsController = TextEditingController();

  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  List<String> countries = ['United States of America'];

  List<String> searchedCountries = [];
  List<String> searchedCities = [];
  var selectedCountry = Rx<String>();
//TODO: getCountries
  getCountries() async {
    List<Country> countriesCountry = await CountryProvider.getAllCountries();
    for (Country country in countriesCountry) {
      countries.add(country.name);
    }
  }

  @override
  void initState() {
    super.initState();
    print('widget.appStates:$appStates');
    getCountries();
  }

  var tagName = ''.obs;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 66,
            child: FlatButton(
              highlightColor: Colors.white,
              padding: EdgeInsets.zero,
              onPressed: () {
                showBottomSheetTags(context);
              },
              child: Obx(
                () => Text(
                  'Tags',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: appStates.filledSearchTags.value.isEmpty ? AppColors.black : AppColors.orange,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          FlatButton(
            highlightColor: Colors.white,
            padding: EdgeInsets.zero,
            onPressed: () {
              showBottomSheetCountry(context);
            },
            child: Obx(
              () => Text(
                'Country',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: appStates.filledSearchCountry.value.toList().isEmpty ? AppColors.black : AppColors.orange,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          FlatButton(
            highlightColor: Colors.white,
            padding: EdgeInsets.zero,
            onPressed: () => showBottomSheetCity(context),
            child: Obx(
              () => Text(
                '${appStates.filledSearchCity.value.toList().length > 0 ? appStates.filledSearchCity.value.toList().length.toString() : ''} City',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: appStates.filledSearchCity.value.toList().isEmpty ? AppColors.black : AppColors.orange,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          FlatButton(
            highlightColor: Colors.white,
            padding: EdgeInsets.zero,
            onPressed: () {
              showBottomSheetSocialNetworks(context);
            },
            child: Text(
              'Social Network',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.black,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(width: 30),
          FlatButton(
            padding: EdgeInsets.zero,
            highlightColor: Colors.white,
            onPressed: () {},
            child: Text(
              'Custom tags',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.orange,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  showBottomSheetTags(BuildContext context) {
    List<PopularTagSearch> popularTagsSearch = [
      PopularTagSearch(
        tag: 'love',
        appStates: appStates,
      ),
      PopularTagSearch(
        tag: 'phone',
        appStates: appStates,
      ),
      PopularTagSearch(
        tag: 'example',
        appStates: appStates,
      ),
      PopularTagSearch(
        tag: 'sea',
        appStates: appStates,
      ),
      PopularTagSearch(
        tag: 'ocean',
        appStates: appStates,
      ),
    ];
    return showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 7,
            //  top: context.mediaQuerySize.height * 0.05,
            left: 10,
            right: 10,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    Get.back();
                  },
                  icon: SvgPicture.asset('assets/images/close_modal.svg'),
                ),
                SizedBox(
                  height: 30,
                ),
                BorderedContainer(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TitleOfField('Add tags'),
                        Obx(() => appStates.filledSearchTags.value.length > 1
                            ? FlatButton(
                                onPressed: () {
                                  appStates.filledSearchTags.value.clear();
                                  appStates.filledSearchTags.refresh();
                                },
                                highlightColor: Colors.transparent,
                                child: Row(
                                  children: [
                                    SvgPicture.asset('assets/images/cross.svg', width: 12, height: 12),
                                    SizedBox(width: 5),
                                    Text(
                                      'Clear all',
                                      style: TextStyle(
                                        color: AppColors.orange,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container()),
                      ],
                    ),
                    SizedBox(height: 15),
                    CustomAutoCompleteTextFieldSearchTags(
                      appStates: appStates,
                      hintText: 'Enter tag name',
                      rightPadding: 50,
                      controller: tagsController,
                      onSubmited: (value) {
                        if (value.isNotEmpty)
                          appStates.filledSearchTags.value.add(
                            FilledTagSearch(
                              tag: value,
                            ),
                          );
                        appStates.filledSearchTags.refresh();
                        // tagsController.clear();
                      },
                    ),
                    Obx(
                      () => Wrap(
                        children: appStates.filledSearchTags.value,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        TitleOfField('Popular:'),
                        SizedBox(height: 15),
                        Wrap(
                          children: popularTagsSearch,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  showBottomSheetSocialNetworks(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 7,
            top: context.mediaQuerySize.height * 0.05,
            left: 10,
            right: 10,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  highlightColor: Colors.transparent,
                  icon: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SvgPicture.asset('assets/images/close_modal.svg'),
                    ],
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    BorderedContainer(
                      children: [
                        TitleOfField('Social Networks'),
                        SizedBox(height: 15),
                        Obx(
                          () => Column(
                            children: List.generate(
                              appStates.socialNetworksListGlobal.value.length,
                              (index) => Padding(
                                padding: EdgeInsets.only(bottom: index == appStates.socialNetworksListGlobal.value.last.index ? 0 : 25),
                                child: Obx(
                                  () => appStates.socialNetworksListGlobal.value[index],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Obx(
                          () => appStates.socialNetworksListGlobal.value.length < 4
                              ? FlatButton(
                                  onPressed: () {
                                    appStates.socialNetworksListGlobal.value.add(SocialNetworksBlockGlobal());
                                    appStates.socialNetworksListGlobal.refresh();
                                  },
                                  highlightColor: Colors.transparent,
                                  child: Text(
                                    '+ Add',
                                    style: TextStyle(
                                      color: AppColors.orange,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                )
                              : Container(),
                        ),
                        SizedBox(height: 30),
                        FlatButton(
                          onPressed: () {
                            appStates.socialNetworksListGlobal.value.clear();
                            appStates.socialNetworksListGlobal.refresh();
                            appStates.socialNetworksListGlobal.value.add(SocialNetworksBlockGlobal());
                            appStates.socialNetworksListGlobal.refresh();
                          },
                          highlightColor: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/images/cross.svg', width: 11, height: 11),
                              SizedBox(width: 10),
                              Text(
                                'Clear all',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.orange,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  showBottomSheetCountry(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(builder: (context, customSetState) {
          return DraggableScrollableSheet(
            initialChildSize: 0.95,
            maxChildSize: 0.95,
            expand: true,
            builder: (context, scrollController) => Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 7,
                top: 10,
                left: 10,
                right: 10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      height: 50,
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            highlightColor: Colors.transparent,
                            onPressed: () {
                              Get.back();
                            },
                            icon: SvgPicture.asset('assets/images/close_modal.svg'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 25),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    height: context.mediaQuerySize.height * 0.95 - 30 - 18 - 59,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TitleOfField('Add countries'),
                            Obx(
                              () => appStates.filledSearchCountry.value.length > 1
                                  ? FlatButton(
                                      onPressed: () {
                                        appStates.filledSearchCountry.value.clear();
                                      },
                                      highlightColor: Colors.transparent,
                                      child: Row(
                                        children: [
                                          SvgPicture.asset('assets/images/cross.svg', width: 12, height: 12),
                                          SizedBox(width: 5),
                                          Text(
                                            'Clear all',
                                            style: TextStyle(
                                              color: AppColors.orange,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : SizedBox(),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        CustomAutoCompleteTextFieldSearchCountry(
                          hintText: 'Enter country',
                          rightPadding: 50,
                          controller: countryController,
                          onSubmited: (value) {},
                          onChanged: (value) {
                            customSetState(() {
                              searchedCountries.clear();
                            });

                            print(countryController.text);
                            countries.forEach((country) {
                              if (country.toLowerCase().contains(countryController.text.toLowerCase())) {
                                customSetState(() {
                                  searchedCountries.add(country);
                                });
                              }
                            });
                            print(searchedCountries);
                          },
                        ),
                        Obx(
                          () => Expanded(
                            child: Scrollbar(
                              thickness: 3,
                              child: SingleChildScrollView(
                                child: Wrap(
                                  children: appStates.filledSearchCountry.value.toList(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Divider(thickness: 1),
                        Flexible(
                          flex: 3,
                          child: Scrollbar(
                            thickness: 3,
                            child: ListView.builder(
                              // controller: scrollController,
                              itemBuilder: (context, i) => SizedBox(
                                height: 40,
                                child: ListTile(
                                  contentPadding: EdgeInsets.only(left: 10),
                                  onTap: () {
                                    List<String> list = [];
                                    appStates.filledSearchCountry.value.forEach((country) {
                                      list.add(country.tag);
                                    });
                                    customSetState(() {});
                                    if (!list.contains(countryController.text.isEmpty ? countries[i] : searchedCountries[i])) {
                                      appStates.filledSearchCountry.value.add(
                                        FilledCountrySearch(
                                          tag: countryController.text.isEmpty ? countries[i] : searchedCountries[i],
                                        ),
                                      );
                                      appStates.filledSearchCountry.refresh();
                                      countryController.clear();
                                    }
                                  },
                                  title: Text(
                                    countryController.text.isEmpty ? countries[i] : searchedCountries[i],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.lightBlack,
                                    ),
                                  ),
                                ),
                              ),
                              //  separatorBuilder: (context, i) => SizedBox(height: 20),
                              itemCount: countryController.text.isEmpty ? countries.length : searchedCountries.length,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  showBottomSheetCity(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(builder: (context, customSetState) {
          return DraggableScrollableSheet(
            initialChildSize: 0.95,
            maxChildSize: 0.95,
            expand: true,
            builder: (context, scrollController) => Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 7,
                top: 10,
                left: 10,
                right: 10,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              highlightColor: Colors.transparent,
                              onPressed: () {
                                Get.back();
                              },
                              icon: SvgPicture.asset('assets/images/close_modal.svg'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    BorderedContainer(
                      children: [
                        Container(
                          height: context.mediaQuerySize.height * 0.72,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TitleOfField('Add city'),
                                  Obx(
                                    () => appStates.filledSearchCity.value.length > 1
                                        ? FlatButton(
                                            onPressed: () {
                                              appStates.filledSearchCity.value.clear();
                                            },
                                            highlightColor: Colors.transparent,
                                            child: Row(
                                              children: [
                                                SvgPicture.asset('assets/images/cross.svg', width: 12, height: 12),
                                                SizedBox(width: 5),
                                                Text(
                                                  'Clear all',
                                                  style: TextStyle(
                                                    color: AppColors.orange,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : SizedBox(),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              CustomAutoCompleteTextFieldSearchCountry(
                                hintText: 'Enter city',
                                rightPadding: 50,
                                controller: cityController,
                                onSubmited: (value) {},
                                onChanged: (value) {
                                  customSetState(() {
                                    searchedCities.clear();
                                  });

                                  print(cityController.text);
                                  Lists.cities.forEach((country) {
                                    if (country.toLowerCase().contains(cityController.text.toLowerCase())) {
                                      customSetState(() {
                                        searchedCities.add(country);
                                      });
                                    }
                                  });
                                  print(searchedCities);
                                },
                              ),
                              Obx(
                                () => Wrap(
                                  children: appStates.filledSearchCity.value.toList(),
                                ),
                              ),
                              Divider(thickness: 1),
                              Expanded(
                                child: Scrollbar(
                                  thickness: 3,
                                  child: ListView.builder(
                                    // controller: scrollController,
                                    itemBuilder: (context, i) => SizedBox(
                                      height: 40,
                                      child: ListTile(
                                        contentPadding: EdgeInsets.only(left: 10),
                                        onTap: () {
                                          List<String> list = [];
                                          appStates.filledSearchCity.value.forEach((country) {
                                            list.add(country.tag);
                                          });
                                          customSetState(() {});
                                          if (!list.contains(cityController.text.isEmpty ? Lists.cities[i] : searchedCities[i])) {
                                            appStates.filledSearchCity.value.add(
                                              FilledCitySearch(
                                                tag: cityController.text.isEmpty ? Lists.cities[i] : searchedCities[i],
                                              ),
                                            );
                                            appStates.filledSearchCity.refresh();
                                            cityController.clear();
                                          }
                                        },
                                        title: Text(
                                          cityController.text.isEmpty ? Lists.cities[i] : searchedCities[i],
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.lightBlack,
                                          ),
                                        ),
                                      ),
                                    ),
                                    //  separatorBuilder: (context, i) => SizedBox(height: 20),
                                    itemCount: cityController.text.isEmpty ? Lists.cities.length : searchedCities.length,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
