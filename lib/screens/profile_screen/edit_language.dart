import 'package:dating_app/widgets/bordered_container.dart';
import 'package:dating_app/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:dating_app/resourses/colors.dart';
import 'package:hive/hive.dart';

enum Languages { Russian, English, Spanish, Portugal, France }

class EditLanguage extends StatefulWidget {
  @override
  _EditLanguageState createState() => _EditLanguageState();
}

class _EditLanguageState extends State<EditLanguage> {
  var box = Hive.box('appMetrics');

  Languages currentLanguage = Languages.English;
  List<String> langs = ['Russian', 'English', 'Spanish', 'Portugal', 'France'];

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
          'Change language',
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
        child: ListView(
          shrinkWrap: true,
          children: [
            BorderedContainer(
              children: [
                Column(
                  children: List.generate(
                    5,
                    (index) => ListTile(
                      leading: Radio(
                        focusColor: AppColors.orange,
                        activeColor: AppColors.orange,
                        value: Languages.values[index],
                        groupValue: currentLanguage,
                        onChanged: (value) {
                          setState(() {
                            currentLanguage = value;
                          });
                        },
                      ),
                      title: Text(langs[index]),
                    ),
                  ),
                ),
                SizedBox(height: 50),
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
    );
  }
}
