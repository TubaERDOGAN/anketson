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

      /// burası anlaşılmadı
      theme: ThemeData(
          primaryColor:Color(0xffc45d54),
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white), // günlük anket yanındaki ikonun rengi değişti
          color: Color(0xffc45d54), // değişiklik yapınca pek farketmedi
          foregroundColor: Colors.black, // değişiklik yapınca farketmedi
          systemOverlayStyle: SystemUiOverlayStyle( //<-- SEE HERE
// Status bar color
            statusBarColor: Color(0xffc45d54), // değişiklik yapınca farkettemedi
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
        ),
      ),
      home: LoginPage(),
        );
  }

}



