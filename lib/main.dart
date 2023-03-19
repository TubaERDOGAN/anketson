import 'package:ankets/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:ankets/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:ui';

import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: AppConstant.SUPPORTED_LOCALE,
      path: AppConstant.LANG_PATH,
      fallbackLocale: Locale('tr', 'TR'),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return  MaterialApp(
        debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black),
          color: Color(0xffc45d54),
          foregroundColor: Colors.black,
          systemOverlayStyle: SystemUiOverlayStyle( //<-- SEE HERE
// Status bar color
            statusBarColor: Color(0xffc45d54),
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
        ),
      ),
      home: LoginPage(),
        );
  }

}



