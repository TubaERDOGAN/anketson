import 'package:ankets/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:ankets/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:ui';
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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage()
    );
  }
}




