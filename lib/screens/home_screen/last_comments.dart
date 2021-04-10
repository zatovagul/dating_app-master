import 'package:dating_app/data/data.dart';
import 'package:dating_app/states.dart';
import 'package:dating_app/widgets/custom_widgets.dart';
import 'package:dating_app/widgets/page_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dating_app/resourses/colors.dart';

class LastComments extends StatelessWidget {
  AppStates appStates = Get.put(AppStates());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.light,
      body: Container(
        color: AppColors.lightBronze,
        height: context.height,
        width: context.width,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PageTitle('Last Comments'),
              SizedBox(height: 25),
              Expanded(
                child: context.mediaQuerySize.width < 500
                    ? ListView.separated(
                        itemBuilder: (context, i) {
                          return LastComment(
                            comment: Lists.listLastComments[i],
                            downText: Lists.listLastCommentsOrange[i],
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
                                child: LastComment(
                                  comment: Lists.listLastComments[i],
                                  downText: Lists.listLastCommentsOrange[i],
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
