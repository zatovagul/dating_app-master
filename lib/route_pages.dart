import 'package:dating_app/screens/profile_screen/personal_information.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import 'screens/add_feedback_screen/add_feedback.dart';
import 'screens/global_search_screen/global_search.dart';
import 'screens/home_screen/all_feedbacks.dart';
import 'screens/home_screen/followers.dart';
import 'screens/home_screen/last_comments.dart';
import 'screens/home_screen/profile_page.dart';
import 'screens/home_screen/top_users.dart';
import 'screens/notification/track_account_main.dart';
import 'screens/profile_screen/edit_profile.dart';
import 'screens/profile_screen/my_profile_page.dart';

class RoutePages {
  static List<GetPage> routePages = [
    /* GetPage(
      name: '/homeMenu',
      page: () => HomeMenu(),
      transition: Transition.fadeIn,
    ),*/
    GetPage(
      name: '/allFeedbacks',
      page: () => AllFeedbacks(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/topUsers',
      page: () => TopUsers(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/lastComments',
      page: () => LastComments(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/addFeedback',
      page: () => AddFeedback(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/myProfile',
      page: () => MyProfile(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/profile',
      page: () => Profile(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/followers',
      page: () => Followers(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/editProfile',
      page: () => EditProfile(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/personalInformation',
      page: () => PersonalInformation(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/trackAccount',
      page: () => TrackAccountMain(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/globalSearch',
      page: () => GlobalSearch(),
      transition: Transition.fadeIn,
    ),
  ];
}
