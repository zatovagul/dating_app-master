import 'dart:convert';
import 'dart:io';
import 'package:dating_app/route_pages.dart';
import 'package:dating_app/services/networking_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'screens/auth_screen/login_page.dart';
import 'resourses/colors.dart';
import 'screens/home_screen/all_feedbacks.dart';
import 'services/hive_helper.dart';
import 'package:dating_app/data/localizations.dart';

//
const isDev = true;
//
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final path = await getApplicationDocumentsDirectory();
  Hive.init(path.path);
  await Hive.openBox('appMetrics');
  HiveHelper.tokenBox = await Hive.openBox<String>('token');
  String refreshToken = HiveHelper.refreshToken;
  if (refreshToken != null) {
    try {
      http.Response response = await NetworkingService.refresh(refreshToken);
      Map<String, dynamic> _json = json.decode(response.body);

      if (_json['status']) {
        refreshToken = _json['refresh_token'];
        await HiveHelper.addRefreshToken(refreshToken);
        await HiveHelper.addToken(_json['access_token']);
      } else
        throw Exception('Status false from refresh method');
    } catch (_) {
      refreshToken = null;
    }
  }
  runApp(MyApp(refreshToken));
}

class MyApp extends StatelessWidget {
//

  MyApp(this.refreshToken);

  final String refreshToken;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return KeyboardVisibilityProvider(
      child: GetMaterialApp(
        key: _scaffoldKey,
        translations: AppLocalizations(),
        locale: Locale('en', 'US'),
        fallbackLocale: Locale('en', 'US'),
        theme: ThemeData(
          fontFamily: 'Graphic',
          highlightColor: AppColors.orange,
          appBarTheme: AppBarTheme(
            brightness: Brightness.light,
          ),
        ),
        debugShowCheckedModeBanner: false,
        getPages: RoutePages.routePages,
        home: refreshToken != null ? AllFeedbacks() : LoginPage(),
      ),
    );
  }

//
}
