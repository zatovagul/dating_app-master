import 'package:country_provider/country_provider.dart';
import 'package:dating_app/screens/profile_screen/edit_social_networks.dart';
import 'package:dating_app/resourses/colors.dart';
import 'package:dating_app/widgets/bordered_container.dart';
import 'package:dating_app/widgets/custom_textfield.dart';
import 'package:dating_app/widgets/custom_widgets.dart';
import 'package:dating_app/widgets/expanded_bordered_container.dart';
import 'package:dating_app/widgets/page_title.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:zefyr/zefyr.dart';
import '../../states.dart';

class AddFeedback extends StatefulWidget {

  final String title;
  final String story;
  final PageController pageController;

  AddFeedback({
    this.title,
    this.story,
    this.pageController,
  });
  @override
  _AddFeedbackState createState() => _AddFeedbackState();

}

class _AddFeedbackState extends State<AddFeedback> {
  List<Asset> images = List<Asset>();

  AppStates appStates = Get.put(AppStates());

  TextEditingController tagsController = TextEditingController();
  TextEditingController titleController;
  //TextEditingController storyController;
  ZefyrController storyController;

  RxString tagName = ''.obs;
  RxBool isTermsAndConditions = true.obs;
  RxBool isStayAnonymous = false.obs;
  List<String> countries = ['United States of America'];
  Rx<String> selectedCountry = Rx<String>();
  bool savedDraft = false;
  FocusNode focusNodeTitle = FocusNode();
  FocusNode focusNodeStory = FocusNode();

  bool showKeyboard = false;
  bool showToolBar = false;

  getCountries() async {
    List<Country> countriesCountry = await CountryProvider.getAllCountries();

    for (Country country in countriesCountry) {
      countries.add(country.name);
    }
  }

  /* NotusDocument _loadDocument() {
    // For simplicity we hardcode a simple document with one line of text
    // saying "Zefyr Quick Start".
    // (Note that delta must always end with newline.)
    final Delta delta = Delta()..insert('');
    return NotusDocument(delta);
  }*/

  Future<void> loadAssets() async {
    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        selectedAssets: images ?? [],
      );
    } on Exception catch (e) {
      print('Exception: $e');
      error = e.toString();
    }

    if (!mounted) return;
    setState(() {
      if (resultList != null) images = resultList;
      if (error == null) error = 'No Error Dectected';
    });
  }

  Widget buildGridView() {
    print('images $images');
    if (images != null && images?.length > 0)
      return SizedBox(
        height: 100,
        child: GridView.count(
          scrollDirection: Axis.horizontal,
          crossAxisCount: 1,
          children: List<Widget>.generate(images.length, (index) {
                Asset asset = images[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: AssetThumb(
                          asset: asset,
                          width: 300,
                          height: 300,
                        ),
                      ),
                      Positioned(
                        top: -5,
                        right: -5,
                        child: IconButton(
                          onPressed: () => setState(() => images.removeAt(index)),
                          icon: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                              child: SvgPicture.asset(
                                'assets/images/icn-delete.svg',
                                color: AppColors.grey,
                              )),
                        ),
                      ),
                    ],
                  ),
                );
              }) +
              [
                FlatButton(
                  highlightColor: AppColors.grey.withOpacity(0.2),
                  padding: EdgeInsets.zero,
                  onPressed: loadAssets,
                  child: DottedBorder(
                    color: AppColors.orange,
                    strokeWidth: 2,
                    borderType: BorderType.RRect,
                    dashPattern: [3, 3],
                    radius: Radius.circular(10),
                    child: Container(
                      alignment: Alignment.center,
                      height: 78,
                      width: 78,
                      child: SvgPicture.asset(
                        'assets/images/plus.svg',
                        color: AppColors.orange,
                      ),
                    ),
                  ),
                ),
              ],
        ),
      );
    else
      return addPhotos();
  }

  Widget addPhotos() => FlatButton(
        highlightColor: AppColors.grey.withOpacity(0.2),
        padding: EdgeInsets.zero,
        onPressed: loadAssets,
        child: DottedBorder(
          color: AppColors.orange,
          strokeWidth: 2,
          borderType: BorderType.RRect,
          dashPattern: [3, 3],
          radius: Radius.circular(10),
          child: Container(
            alignment: Alignment.center,
            height: 68,
            width: 68,
            child: SvgPicture.asset(
              'assets/images/plus.svg',
              color: AppColors.orange,
            ),
          ),
        ),
      );

  Widget uploadPhotoContainer({@required Widget child}) => BorderedContainer(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _TitleOfField('Upload photo'),
              Text(
                '${images?.length ?? 0}/10',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.grey,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          child
        ],
      );

  @override
  void initState() {
    super.initState();

    getCountries();
    final document = NotusDocument() /* _loadDocument()*/;
    storyController = ZefyrController(document);
    titleController = TextEditingController(text: widget.title ?? '');
    // storyController = TextEditingController(text: widget.story ?? '');
  }

  @override
  Widget build(BuildContext context) {
    showKeyboard = KeyboardVisibilityProvider.isKeyboardVisible(context);

    return Scaffold(
      backgroundColor: AppColors.light,
      appBar: AppBar(
        centerTitle: true,
        leading: Container(),
        title: Image.asset('assets/images/logo.png', height: 48),
        elevation: 0,
        backgroundColor: AppColors.lightBronze,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 25, bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            savedDraft
                ? Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    margin: EdgeInsets.only(bottom: 15),
                    height: 57,
                    width: context.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFFD5E4D6),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/images/success_draft.svg'),
                        SizedBox(width: 15),
                        Text(
                          'Moved to your drafts',
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                  )
                : Container(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: PageTitle('Add feedbacks'),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    setState(() {
                      widget.title != null ? Get.back() : widget.pageController.jumpToPage(0);
                      FocusScope.of(context).unfocus();
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 13),
                    child: Container(
                      child: SvgPicture.asset(
                        'assets/images/cross.svg',
                        color: AppColors.lightBlack,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onPanDown: (_) {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: ListView(
                  children: [
                    BorderedContainer(
                      children: [
                        _TitleOfField('Title post'),
                        SizedBox(height: 15),
                        CustomTextField(focusNode: focusNodeTitle, hintText: 'Enter title', isFull: true, controller: titleController),
                        SizedBox(height: 20),
                        _TitleOfField(
                          'Start story',
                        ),
                        SizedBox(height: 15),
                        ZefyrField(
                          toolbar: ZefyrToolbar.basic(
                            controller: storyController,
                          ),
                          textCapitalization: TextCapitalization.sentences,
                          // padding: EdgeInsets.all(16),
                          controller: storyController,
                          focusNode: focusNodeStory,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.light,
                            contentPadding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                            hintText: 'Enter story',
                            hintStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.light,
                              ),
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.light,
                              ),
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.light,
                              ),
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.light,
                              ),
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    uploadPhotoContainer(child: buildGridView()),
                    ExpandedBorderedContainer(
                      childrenMinimized: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/plus.svg',
                              color: AppColors.orange,
                              width: 12,
                            ),
                            SizedBox(width: 10),
                            _TitleOfField(
                              'Add information about person',
                              color: AppColors.orange,
                            ),
                          ],
                        ),
                      ],
                      childrenMaximized: [
                        _TitleOfField('About person'),
                        SizedBox(height: 15),
                        context.width > 500
                            ? Row(
                                children: [
                                  CustomTextField(
                                    hintText: 'First name',
                                    isFull: context.width < 500 ? true : false,
                                  ),
                                  SizedBox(width: 10),
                                  CustomTextField(
                                    hintText: 'Last name',
                                    isFull: context.width < 500 ? true : false,
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  CustomTextField(
                                    hintText: 'First name',
                                    isFull: context.width < 500 ? true : false,
                                  ),
                                  SizedBox(height: 15),
                                  CustomTextField(
                                    hintText: 'Last name',
                                    isFull: context.width < 500 ? true : false,
                                  ),
                                ],
                              ),
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
                                          dropDownButton: SvgPicture.asset('assets/images/icn_arrow_down.svg'),
                                          selectedItem: selectedCountry.value,
                                          dropdownSearchDecoration: InputDecoration(
                                            filled: true,
                                            fillColor: AppColors.light,
                                            contentPadding: EdgeInsets.only(left: 20, right: 0, top: 7.5, bottom: 7.5),
                                            hintStyle: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.grey,
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColors.light,
                                              ),
                                              borderRadius: BorderRadius.circular(7.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColors.light,
                                              ),
                                              borderRadius: BorderRadius.circular(7.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColors.light,
                                              ),
                                              borderRadius: BorderRadius.circular(7.0),
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColors.light,
                                              ),
                                              borderRadius: BorderRadius.circular(7.0),
                                            ),
                                          ),
                                          items: countries,
                                          mode: Mode.MENU,
                                        )),
                                  ),
                                  SizedBox(width: 10),
                                  CustomTextField(
                                    hintText: 'City',
                                    isFull: false,
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  Obx(() => DropdownSearch(
                                        showSearchBox: true,
                                        searchBoxDecoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: AppColors.orange),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: AppColors.orange),
                                          ),
                                        ),
                                        hint: 'Country',
                                        popupBackgroundColor: AppColors.light,
                                        onChanged: (value) {
                                          selectedCountry.value = value;
                                        },
                                        dropDownButton: SvgPicture.asset('assets/images/icn_arrow_down.svg'),
                                        selectedItem: selectedCountry.value,
                                        dropdownSearchDecoration: InputDecoration(
                                          filled: true,
                                          fillColor: AppColors.light,
                                          contentPadding: EdgeInsets.only(left: 20, right: 0, top: 7.5, bottom: 7.5),
                                          hintStyle: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.grey,
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppColors.light,
                                            ),
                                            borderRadius: BorderRadius.circular(7.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppColors.light,
                                            ),
                                            borderRadius: BorderRadius.circular(7.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppColors.light,
                                            ),
                                            borderRadius: BorderRadius.circular(7.0),
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppColors.light,
                                            ),
                                            borderRadius: BorderRadius.circular(7.0),
                                          ),
                                        ),
                                        items: countries,
                                        mode: Mode.MENU,
                                      )),
                                  SizedBox(height: 15),
                                  CustomTextField(
                                    hintText: 'City',
                                    isFull: true,
                                  ),
                                ],
                              ),
                        SizedBox(height: 20),
                        _TitleOfField('Social Networks'),
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
                        SizedBox(height: 15),
                        Obx(
                          () => appStates.socialNetworksList.value.length < 4
                              ? FlatButton(
                                  onPressed: () {
                                    appStates.socialNetworksList.value.add(SocialNetworksBlock());
                                    appStates.socialNetworksList.refresh();
                                  },
                                  highlightColor: Colors.transparent,
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 56,
                                    width: 84,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: AppColors.orange,
                                      ),
                                    ),
                                    child: Text(
                                      '+ Add',
                                      style: TextStyle(
                                        color: AppColors.orange,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                        ),
                      ],
                    ),
                    BorderedContainer(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _TitleOfField('Add tags'),
                            Obx(() => appStates.filledTags.value.length > 1
                                ? FlatButton(
                                    onPressed: () {
                                      appStates.filledTags.value.clear();
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
                        CustomAutoCompleteTextField(
                          hintText: 'Enter tag name',
                          rightPadding: 50,
                          controller: tagsController,
                          onSubmited: (value) {
                            tagsController.text.isNotEmpty
                                ? appStates.filledTags.value.add(
                                    FilledTag(
                                      tag: value,
                                    ),
                                  )
                                : null;
                            appStates.filledTags.refresh();
                            tagsController.clear();
                          },
                        ),
                        Obx(
                          () => Wrap(
                            children: appStates.filledTags.value,
                          ),
                        ),
                        Obx(
                          () => appStates.filledTags.value.length > 0
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 20),
                                    _TitleOfField('Popular:'),
                                    SizedBox(height: 15),
                                    Wrap(children: appStates.popularTags),
                                  ],
                                )
                              : Container(),
                        ),
                      ],
                    ),
                    SizedBox(height: 33),
                    Obx(
                      () => TextWithSwitch(
                        text: 'Terms & Conditions',
                        checkIcon: true,
                        value: isTermsAndConditions.value,
                        onToggle: (value) {
                          isTermsAndConditions.value = value;
                        },
                      ),
                    ),
                    SizedBox(height: 15),
                    Obx(
                      () => TextWithSwitch(
                        withQuestion: true,
                        text: 'Stay anonymous',
                        checkIcon: false,
                        value: isStayAnonymous.value,
                        onToggle: (value) {
                          isStayAnonymous.value = value;
                        },
                      ),
                    ),
                    GradientButton(
                      text: 'Publicate',
                      onTap: () {
                        Get.toNamed('/allFeedbacks');
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          savedDraft = true;
                          Future.delayed(Duration(seconds: 4), () {
                            setState(() {
                              savedDraft = false;
                            });
                          });
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(bottom: 30),
                        width: context.mediaQuerySize.width,
                        child: Text(
                          'Save draft',
                          style: TextStyle(
                            color: AppColors.orange,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
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

class FilledTag extends StatelessWidget {
  final String tag;

  FilledTag({this.tag});

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
          appStates.filledTags.value.remove(this);
          appStates.filledTags.refresh();
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

class PopularTag extends StatefulWidget {
  final String tag;

  PopularTag({this.tag});

  @override
  _PopularTagState createState() => _PopularTagState();
}

class _PopularTagState extends State<PopularTag> {
  AppStates appStates = Get.put(AppStates());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
      child: GestureDetector(
        onTap: () {
          appStates.filledTags.value.add(
            FilledTag(tag: widget.tag),
          );
          appStates.filledTags.refresh();
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
