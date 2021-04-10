import 'dart:convert';
import 'package:dating_app/data/data.dart';
import 'package:dating_app/models/all_feedback.dart';
import 'package:dating_app/resourses/colors.dart';
import 'package:dating_app/services/networking_service.dart';
import 'package:dating_app/widgets/feedback_mini.dart';
import 'package:dating_app/widgets/page_title.dart';
import 'package:dating_app/widgets/searching_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'all_feedbacks.dart';
import '../../states.dart';

class AllFeedbackScreen extends StatefulWidget {
//

  @override
  _AllFeedbackState createState() => _AllFeedbackState();

//
}

class _AllFeedbackState extends State<AllFeedbackScreen> {
//

  AppStates appStates = Get.put(AppStates());

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
      backgroundColor: AppColors.light,
      body: Padding(
        padding: EdgeInsets.only(top: 30, bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.only(left: 10), child: PageTitle('all_feedbacks'.tr)),
            SearchingTabBar(appStates: appStates),
            if (loading)
              Center(
                child: CircularProgressIndicator(),
              ),
            if (error) Text('Error to load data'),
            if (!loading && !error)
              Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: List<Widget>.generate(
                            1,
                            (index) {
                              if (allFeedback.length > 0)
                                return FeedbackMini(
                                  allFeedback[index],
                                  padding: EdgeInsets.only(
                                    left: 10,
                                    right: 10,
                                    bottom: 10,
                                  ),
                                );
                              else
                                return SizedBox();
                            },
                          ) +
                          <Widget>[
                            _topUsers(),
                          ] +
                          List<Widget>.generate(
                            allFeedback.length > 1 ? allFeedback.length - 1 : 1,
                            (_index) {
                              int index = _index - 1;

                              if (allFeedback.length > 1)
                                return FeedbackMini(allFeedback[index],
                                    padding: EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                      bottom: 10,
                                    ));
                              else
                                return SizedBox();
                            },
                          ) +
                          <Widget>[
                            _lastCommentsWidget(),
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

  _lastCommentsWidget() => Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PageTitle('last_comments'.tr),
                  SizedBox(
                    width: 70,
                    child: FlatButton(
                      padding: EdgeInsets.zero,
                      highlightColor: Colors.white,
                      onPressed: () {
                        appStates.firstPages.value = 2;
                      },
                      child: Text(
                        'More'.tr,
                        style: TextStyle(
                          color: AppColors.orange,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
         //TODO
         /*   SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 10, bottom: 40),
              child: Row(
                children: List.generate(
                  5,
                  (index) => LastCommentsHorizontal(),
                ),
              ),
            )*/
          ],
        ),
      );

  _topUsers() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PageTitle('top_users_of_exdating'.tr),
                  GestureDetector(
                    onTap: () {
                      appStates.firstPages.value = 1;
                    },
                    child: Text(
                      'more'.tr,
                      style: TextStyle(
                        color: AppColors.orange,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 10),
              child: Row(
                children: List.generate(
                  5,
                  (index) => TopUsersHorizontal(index: index),
                ),
              ),
            )
          ],
        ),
      );

//
}
