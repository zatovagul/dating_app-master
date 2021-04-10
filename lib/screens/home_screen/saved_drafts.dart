import 'package:dating_app/data/data.dart';
import 'package:dating_app/states.dart';
import 'package:dating_app/widgets/custom_widgets.dart';
import 'package:dating_app/widgets/page_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dating_app/resourses/colors.dart';

class SavedDrafts extends StatelessWidget {
  AppStates appStates = Get.put(AppStates());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.light,
      // appBar: AppBar(
      //   leading: GestureDetector(
      //     onTap: () {
      //       Get.toNamed('/homeMenu');
      //     },
      //     child: Center(
      //       child: SvgPicture.asset('assets/images/list.svg',
      //           height: 20, width: 20),
      //     ),
      //   ),
      //   centerTitle: true,
      //   title: Image.asset('assets/images/logo.png', height: 48),
      //   elevation: 0,
      //   backgroundColor: AppColors.lightBronze,
      //   actions: [
      //     InkWell(
      //       onTap: () {
      //         Get.to(MessagesMain());
      //       },
      //       child: Padding(
      //         padding: const EdgeInsets.all(16.0),
      //         child: SvgPicture.asset(
      //           'assets/images/message.svg',
      //           height: 20,
      //           width: 20,
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      // bottomNavigationBar: Container(
      //   color: Colors.white,
      //   padding: const EdgeInsets.symmetric(horizontal: 30),
      //   height: 64,
      //   width: context.mediaQuerySize.width,
      //   child: Row(
      //     mainAxisAlignment: context.mediaQuerySize.width > 500
      //         ? MainAxisAlignment.spaceEvenly
      //         : MainAxisAlignment.spaceBetween,
      //     children: [
      //       GestureDetector(
      //         onTap: () {
      //           Get.toNamed('/allFeedbacks');
      //         },
      //         child: SvgPicture.asset(
      //           'assets/images/home.svg',
      //           color: AppColors.orange,
      //         ),
      //       ),
      //       GestureDetector(
      //         onTap: () {
      //           Get.toNamed('/globalSearch');
      //         },
      //         child: SvgPicture.asset(
      //           'assets/images/search.svg',
      //         ),
      //       ),
      //       GestureDetector(
      //         onTap: () {
      //           Get.toNamed('/addFeedback');
      //         },
      //         child: SvgPicture.asset(
      //           'assets/images/plus.svg',
      //         ),
      //       ),
      //       GestureDetector(
      //         onTap: () {
      //           Get.toNamed('/trackAccount');
      //         },
      //         child: SvgPicture.asset(
      //           'assets/images/ring.svg',
      //         ),
      //       ),
      //       GestureDetector(
      //         onTap: () {
      //           Get.toNamed('/myProfile');
      //         },
      //         child: Container(
      //           height: 24,
      //           width: 24,
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(30),
      //             // border: Border.all(color: AppColors.orange, width: 2),
      //             image: DecorationImage(
      //               image: AssetImage(appStates.profilePhoto.value),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      body: Container(
        color: AppColors.lightBronze,
        height: context.height,
        width: context.width,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PageTitle('Saved drafts'),
              SizedBox(height: 25),
              Expanded(
                child: context.mediaQuerySize.width < 500
                    ? ListView.separated(
                        itemBuilder: (context, i) {
                          return Draft(
                            draftTitle: 'My new passion',
                            draftText: Lists.listLastComments[i],
                            downText: 'Complete this feedback',
                          );
                        },
                        separatorBuilder: (context, i) {
                          return SizedBox(height: 10);
                        },
                        itemCount: 5,
                      )
                    : SingleChildScrollView(
                        child: Wrap(
                            spacing: 10,
                            children: List.generate(5, (i) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Draft(
                                  draftText: Lists.listLastComments[i],
                                  downText: 'Complete this feedback',
                                ),
                              );
                            })),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
